class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top,:about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def translation_to_i18n(local)
    I18n.locale = local # Or whatever logic you use to choose.
  end


  protected

  def configure_permitted_parameters
    # deviseでnameをキーにしたため、逆にemailを変更できるように許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
