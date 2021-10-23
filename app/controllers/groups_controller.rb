class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  
  def index
    @group = Group.all
  end 
  
  def create
    @group = Group.new(group_params)
  end 
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :image_id)
  end 
end
