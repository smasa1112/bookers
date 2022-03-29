class BooksController < ApplicationController
  before_action ->{
    translation_to_i18n(:ja)
  }

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
    # タグで取得したものに対しても並び替えできるようにしたい
    if params[:tag]
      books=Book.tagged_with(params[:tag])
    else
      books=Book.all
    end

    if params[:way]=="new"
      @books=books.order(created_at: "DESC")
    elsif params[:way]=="evaluation"
      @books=books.order(evaluation: "DESC")
    else
      @books=books.last_week_rank
    end

    if params[:category]
      if params[:match_type]
        @books=Book.search(params[:category],params[:match_type],"category")
      else
        @books=Book.search(params[:category],"complete","category")
      end
    end

    @tags=Book.tag_counts_on(:tags).most_used(10)
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

  def detail_search
    @q=Book.ransack(params[:q])
  end

  def detail_search_result
    @q=Book.search(search_params)
    @books=@q.result.includes([:user,:tags])
  end

  private
  def search_params
    params.require(:q).permit!
  end


  def book_params
    params.require(:book).permit(:title, :body, :evaluation, :category,:tag_list)
  end
end
