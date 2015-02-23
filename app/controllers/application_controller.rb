class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :authenticate_author!
  layout :layout_by_resource

  before_filter :custom_auth

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  private

  def custom_auth
    if params.has_key?("sk")
      if params[:sk]!= "abLogfOrdEvbYavIshEkjAnatWentyfIFteEn"
        render :json => {:error =>"You need to sign in or sign up before continuing."}, :status => 401
      end
    else
       authenticate_author!
    end
  end

  def layout_by_resource
    if devise_controller? && resource_name == :author && (action_name == 'new' || action_name == 'unregistered')
      "login"
    else
      "application"
    end
  end
end
