class ApplicationController < ActionController::Base
  before_action :set_cart
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?

  helper_method :current_cart  # Make current_cart available in views

  private

  def current_cart
    @current_cart ||= begin
      if session[:cart_id]
        Cart.find(session[:cart_id])
      else
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
      end
    end
  end

  def set_cart
    @cart = current_cart
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:street, :province])
    devise_parameter_sanitizer.permit(:account_update, keys: [:street, :province])
  end
end
