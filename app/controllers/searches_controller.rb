class SearchesController < ApplicationController
  def search
    @keyword = params[:keyword]
    match_type = params[:match]
    @model = params[:model].to_i
    #選択肢がUserのときにはUserテーブルから検索
    if @model==0
      @datas = User.search(@keyword,match_type)
    # それ以外の場合にはBookテーブルから検索
    else
      @datas = Book.search(@keyword,match_type)
    end
  end

  def get_number_of_post
    user=User.find(params[:user_id])
    date=params[:post_date]
    p date.class
    @post_count=user.books.where(created_at: DateTime.parse(date).all_day).count
  end
end
