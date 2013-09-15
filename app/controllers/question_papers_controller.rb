class QuestionPapersController < ApplicationController
  before_filter :authenticate_user!, except: ['list']
  # GET /question_papers
  # GET /question_papers.json
  def index
    @question_papers = QuestionPaper.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @question_papers }
    end
  end

  # GET /question_papers/1
  # GET /question_papers/1.json
  def show
    @question_paper = QuestionPaper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question_paper }
    end
  end

  # GET /question_papers/new
  # GET /question_papers/new.json
  def new
    @question_paper = QuestionPaper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question_paper }
    end
  end

  # GET /question_papers/1/edit
  def edit
    @question_paper = QuestionPaper.find(params[:id])
  end

  # POST /question_papers
  # POST /question_papers.json
  def create
    @question_paper = QuestionPaper.create!(
      name: params[:name],
      description: params[:description],
      weitage: params[:weitage]
    )

    name =  params[:question_set].original_filename
    directory = "tmp"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(params[:question_set].read) }
    question_set = File.new(path,"r")
    @rejected_records = Array.new
    counter = 0
    while(record = question_set.gets) do
      counter += 1
      begin
        record = record.split(",")
        Question.create!(
          title: record[0],
          answer_1: record[1],
          answer_2: record[2],
          answer_3: record[3],
          answer_4: record[4],
          correct_answer: record[5],
          question_paper_id: @question_paper.id,
          position: counter
        )
      rescue => exception
        counter -= 1
      end
    end
    question_set.close
    respond_to do |format|
      if @question_paper.save
        format.html { redirect_to @question_paper, notice: 'Question paper was successfully created.' }
        format.json { render json: @question_paper, status: :created, location: @question_paper }
      else
        format.html { render action: "new" }
        format.json { render json: @question_paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /question_papers/1
  # PUT /question_papers/1.json
  def update
    @question_paper = QuestionPaper.find(params[:id])

    respond_to do |format|
      if @question_paper.update_attributes(params[:question_paper])
        format.html { redirect_to @question_paper, notice: 'Question paper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question_paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_papers/1
  # DELETE /question_papers/1.json
  def destroy
    @question_paper = QuestionPaper.find(params[:id])
    @question_paper.destroy

    respond_to do |format|
      format.html { redirect_to question_papers_url }
      format.json { head :no_content }
    end
  end

  def list
    render :json=> QuestionPapersDatatable.new(view_context)
  end

  def detail
    @question_paper = QuestionPaper.find(params[:id])
  end

  def start
    @question_paper = QuestionPaper.find(params[:id])

    session[:question_paper_id] = @question_paper.id
    session[:test_start_time] = Time.now
    session[:test_total_time] = @question_paper.total_time * 60
    session[:question_id] = 1

    @question = @question_paper.get_questions( 1 )
    @total_question_set = @question_paper.questions

    unless @question.selected_answer(current_user.id)
      @answer = StudentAnswer.new
    else
      @answer = @question.selected_answer(current_user.id)
    end

    @next_question = @question_paper.get_questions(2)

    session[:consumed_time] = 0
    session[:remaining_time] = session[:test_total_time]
    @hour = ( session[:remaining_time] / 3600 ).to_i
    @minute = ( (session[:remaining_time]  % 3600) / 60 ).to_i
    @second = ( session[:remaining_time] % 60 ).to_i

    TestParticipation.create(
      question_paper_id: @question_paper.id,
      user_id: current_user.id
    )
    render  'test_conductor'
  end

  def test_conductor
    @question_paper = QuestionPaper.find(session[:question_paper_id].to_i)

    if params[:answer]
      ques = Question.find(params[:question_id])
      existing_answer = ques.selected_answer(current_user.id)

      if existing_answer
        existing_answer.answer = params[:answer]
        existing_answer.save!
      else
        StudentAnswer.create!(
            user_id: current_user.id,
            question_id: params[:question_id],
            answer: params[:answer]
        )
      end
    end

    if ( ( Time.now - session[:test_start_time] ) >= ( @question_paper.total_time * 60 ) ) || params[:id].to_i == 0
      redirect_to test_submit_question_paper_path(@question_paper.id)
      return
    end

    @total_question_set = @question_paper.questions
    question_id = params[:id].to_i

    @current_question = Question.find(question_id)

    @next_question = Question.where(
        question_paper_id: @current_question.question_paper.id,
        position: (@current_question.position + 1)
      ).first

    unless @next_question
      @next_question = 0
    end
    @question = @current_question

    session[:consumed_time] = Time.now - session[:test_start_time]
    session[:remaining_time] = session[:test_total_time] - session[:consumed_time]
    session[:question_id] = @question.id
    @hour = ( session[:remaining_time] / 3600 ).to_i
    @minute = ( (session[:remaining_time]  % 3600) / 60 ).to_i
    @second = ( session[:remaining_time] % 60 ).to_i

    if @question.selected_answer(current_user.id).nil?
      @student_answer = StudentAnswer.new
    else
      @student_answer = @question.selected_answer(current_user.id)
    end

    if @current_question.position > @total_question_set.length
      redirect_to test_submit_question_paper_path(@question_paper.id)
    end
  end

  def test_submit
    @question_paper = QuestionPaper.find(params[:id])

    @score = @question_paper.score(current_user.id)

    if  session[:test_start_time]
      consumed_time = Time.now - session[:test_start_time]

      session[:question_paper_id] = nil
      session[:test_start_time] = nil
      session[:test_total_time] = nil
      session[:question_id] = nil
      session[:remaining_time] = nil
      session[:consumed_time] = nil

      test_participation = TestParticipation.current_participation(@question_paper.id, current_user.id)
      test_participation.update_attributes(
        time_consumed: consumed_time,
        score: @score
      )
    end
  end

  def review
    @question_paper = QuestionPaper.find(params[:id])

    @question = @question_paper.get_questions( 1 )
    @total_question_set = @question_paper.questions

    unless @question.selected_answer(current_user.id)
      @answer = StudentAnswer.new
    else
      @answer = @question.selected_answer(current_user.id)
    end

    @next_question = @question_paper.get_questions(2)
    render  'test_reviewer'
  end

  def test_reviewer
    question_id = params[:id].to_i

    if question_id == 0
      redirect_to "/student/mock_tests"
      return
    end

    @current_question = Question.find(question_id)
    @question_paper = @current_question.question_paper
    @total_question_set = @question_paper.questions


    @next_question = Question.where(
        question_paper_id: @current_question.question_paper.id,
        position: (@current_question.position + 1)
    ).first
    unless @next_question
      @next_question = 0
    end
    @question = @current_question

    if @current_question.nil?
      redirect_to question_paper_path(@question_paper)
      return
    end

    if @current_question.selected_answer(current_user.id).nil?
      @answer = StudentAnswer.new
    else
      @answer = @current_question.selected_answer(current_user.id)
    end
  end
end
