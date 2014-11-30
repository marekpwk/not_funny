module ApplicationHelper
  def admin_user
    unless current_user.admin?
      redirect_to(root_path)
    end
  end
end
