class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_filter :authenticate


  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "bhooklagli" && password == "snacksmagva"
    end
  end


end
