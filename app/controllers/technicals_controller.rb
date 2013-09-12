class TechnicalsController < ApplicationController
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
