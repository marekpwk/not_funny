class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private


  def sort_column(default="id")
    class_name = controller_name.classify.constantize
    class_name.column_names.include?(params[:sort]) ? params[:sort] : default
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
