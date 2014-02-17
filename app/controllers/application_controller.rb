class ApplicationController < ActionController::Base
  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_daemon

  def check_daemon
    SensorWatch.check_daemon
  end

protected

  def require_admin
    return render text: 'Access denied', layout: 'application', status: 403 unless admin?
  end
end
