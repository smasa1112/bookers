class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def index
    @groups = Group.all
    @new_book = Book.new
  end

  def show
    @group = Group.find(params[:id])
    @new_book = Book.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id=current_user.id
    if @group.save
      group_user = GroupUser.new
      group_user.user_id = current_user.id
      group_user.group_id = @group.id
      group_user.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    if @group.owner_id != current_user.id
      redirect_to groups_path
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group.id)
    else
      render :edit
    end
  end

  def new_mail
    @group = Group.find(params[:group_id])
  end

  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    GroupMailer.send_mail(@mail_title, @mail_content,group_users).deliver
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image,)
  end
end
