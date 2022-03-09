# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  before_action ->{
    translation_to_i18n(:ja)
  }
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  #def create
     #super
     #respond_to do |format|
        #format.any
        #format.html
     #end
     #flash[:notice]="パスワード再設定用メールを送信しました"
     #redirect_to root_path
  #end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
