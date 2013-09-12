class BooksController < ApplicationController
  before_filter :authenticate_user!
  def new
    @book = Book.new
  end

  def create
    Book.create(params[:book])
    redirect_to books_technicals_path
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update_attributes(params[:book])
    redirect_to books_technicals_path
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_technicals_path
  end
end
