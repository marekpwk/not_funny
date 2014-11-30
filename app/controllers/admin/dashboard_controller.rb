class Admin::DashboardController < ApplicationController
  before_filter :admin_user
  def index
  end

  def admin_user
    unless current_user.admin?
      redirect_to(root_path)
    end
  end
end
