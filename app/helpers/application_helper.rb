module ApplicationHelper
  def admin_user
    unless current_user.admin?
      redirect_to(root_path)
    end
  end
  
  def sortable(column, title=nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil)
  end

  def title(page_title)
    content_for(:title) { page_title }
  end
end
