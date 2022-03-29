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
    @content_select={"を含む" => "cont" , "を除く"=> "not_cont","で始まる"=> "start","で終わる"=> "end","完全一致"=> "eq"}
  end

  def detail_search_result
    @q=Book.search(search_params)
    @books=@q.result.includes([:user,:tags])
  end

  private
  def search_params
    attributes=[
      *content_params("title"),
      *content_params("category"),
      *content_params("body"),
      *content_params("user_name"),
      *content_params("tags")
      ]
    params.require(:q).permit(*attributes)
  end


  def book_params
    params.require(:book).permit(:title, :body, :evaluation, :category,:tag_list)
  end

  # セレクトフォームを作成する関係上すべてのパラメータをpermitできるわけではないためparam作成
  def content_params(attribute)
    return ["#{attribute}_cont".to_sym, "#{attribute}_eq".to_sym,"#{attribute}_not_cont".to_sym, "#{attribute}_start", "#{attribute}_end"]
  end

end
