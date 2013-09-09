class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:facebook_login]

  def facebook_login
    omniauth = request.env['omniauth.auth']   # This contains all the details of the user say Email, Name, Age so that you can store it in your application db.
    user = User.find_by_email(omniauth['info']['email'])
    if user
      user.update_attributes!(
        uid: omniauth['uid'],
        name: omniauth['info']['name'],
        oauth_token: omniauth['credentials']['token'],
        provider: 'facebook'
      )
    else
      user = User.create!(
          uid: omniauth['uid'],
          name: omniauth['info']['name'],
          oauth_token: omniauth['credentials']['token'],
          provider: 'facebook',
          email: omniauth['info']['email'],
          password: "12345678",
          password_confirmation: "12345678"
      )
    end
    sign_in user
    redirect_to root_path
  end

  def expert_consultancy
    @inbox = current_user.mailbox.inbox
  end

  def query
    @query = Query.new
  end

  def create_query
    query = Query.create!(params[:query])
    current_user.send_message( User.site_admins.to_a, query.description, query.subject )
    redirect_to expert_consultancy_users_path
  end

  def sent
    @sent = current_user.mailbox.sentbox
  end

  def show_mail
    @conversation = Conversation.find_by_id(params[:id])
    unless @conversation.is_participant?(current_user)
      flash[:alert] = "You do not have permission to view that conversation."
      return redirect_to root_path
    end
    @message = Message.new conversation_id: @conversation.id
    current_user.mark_as_read(@conversation)
  end

  def reply_mail
    @message = Message.new params[:message]

    if @message.conversation_id
      @conversation = Conversation.find(@message.conversation_id)
      unless @conversation.is_participant?(current_user)
        flash[:alert] = "You do not have permission to view that conversation."
        return redirect_to root_path
      end
      receipt = current_user.reply_to_conversation(@conversation, @message.body, nil, true, true, @message.attachment)
    else
      unless @message.valid?
        return render :new
      end
      current_user.send_message(@message.recipients, @message.body, @message.subject, true, @message.attachment)
    end
    flash[:notice] = "Message sent."

    redirect_to expert_consultancy_users_path
  end

  def account
    @user = current_user
  end

  def update
    redirect_to root_path
  end
end
