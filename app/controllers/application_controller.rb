class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :new_lead

  def new_lead
    @lead = Lead.new
  end

  def after_sign_in_path_for(resource)
    user_essays_path(current_user)
  end

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :full_name, :administrator])
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :full_name, :administrator])
    end
end
