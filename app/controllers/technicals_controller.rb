class TechnicalsController < ApplicationController
  before_filter :authenticate_user!
  def books
    @books = Book.all
  end

  def projects
    @projects = Project.all
  end

  def interviews
    @interviews = Interview.all
  end
end
