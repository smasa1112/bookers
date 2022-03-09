class UsersController < ApplicationController

  before_action ->{
    translation_to_i18n(:ja)
  }


  def show
    @user=User.includes(:books).find(params[:id])
    @books=@user.books
    @new_book=Book.new
    #グラフ描画に使用する.coffeeファイルに変数を転送する
    gon.linedata = []
    6.step(0, -1) do |i|
      gon.linedata << @user.books.n_day_before(i).count
    end
    #DM用のコード
    #それぞれ保持しているEntryを列挙
    @current_user_entries = Entry.where(user_id: current_user.id)
    @user_entries = Entry.where(user_id: @user.id)
    #ログインしているuserページでは無いとき
    if @user != current_user
      @current_user_entries.each do |current_user_entry|
        #@current_user_entryのもつroom_idと同じroom_idを持つか判定
        if @user_entries.find_by(room_id: current_user_entry.room_id)
          @is_room = true
          @room = current_user_entry.room
        end
      end
      #roomが存在しない場合には新規作成
      if not @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end


  end

  def edit
    @user=User.find(params[:id])
    if @user!=current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @users=User.all
    @new_book=Book.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

