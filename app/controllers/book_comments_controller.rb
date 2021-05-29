class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id =current_user.id
    comment.book_id = book.id
    if comment.save
      redirect_to book_path(book)
    else
      @book=book
      @user=@book.user
      @new_book=Book.new
      @book_comment=BookComment.new
      render "books/show"
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id:params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
