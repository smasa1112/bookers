class SearchesController < ApplicationController
  def search
    @keyword = params[:keyword]
    match_type = params[:match]
    @model = params[:model].to_i
    #選択肢がUserのときにはUserテーブルから検索
    if @model==0
      @datas = User.search(@keyword,match_type)
    # Bookの場合はBookテーブルからタイトル検索
    elsif @model==1
      @datas = Book.search(@keyword,match_type,"title")
    # それ以外の場合にはカテゴリー検索を行って一覧ページを表示
    else
      redirect_to books_path(category: @keyword, match_type: match_type)
    end

  end

  def get_number_of_post
    user=User.find(params[:user_id])
    date=params[:post_date]
    p date.class
    @post_count=user.books.where(created_at: DateTime.parse(date).all_day).count
  end
end
