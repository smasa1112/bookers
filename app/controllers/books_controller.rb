class BooksController < ApplicationController
  impressionist :actions=>[:show]
  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice]="You have posted a new book successfully."
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      render :index
    end
  end

  def show
    @book=Book.find(params[:id])
    impressionist(@book)
    @new_book=Book.new
    @comment=BookComment.new
  end

  def index
    if params[:way]=="new"
      @books=Book.all.order(created_at: "DESC")
    elsif params[:way]=="evaluation"
      @books=Book.all.order(evaluation: "DESC")
    else
      @books=Book.all.last_week_rank
    end

    if params[:category]
      if params[:match_type]
        @books=Book.search(params[:category],params[:match_type],"category")
      else
        @books=Book.search(params[:category],"complete","category")
      end
    end

    @book=Book.new
  end

  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice]="You have updated book successfully"
    else
      render :edit
    end
  end

  def edit
    @book=Book.find(params[:id])
    if @book.user!=current_user
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :evaluation, :category)
  end
end
