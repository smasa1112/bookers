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
end
