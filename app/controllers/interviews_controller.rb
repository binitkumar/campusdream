class InterviewsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @interview = Interview.new
  end

  def create
    interview = Interview.create(params[:interview])
    redirect_to interview
  end

  def show
    @interview = Interview.find(params[:id])
  end
end
