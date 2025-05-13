class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def require_role(role)
    unless session[:role] == role
      flash[:alert] = "You do not have access to that page"
      redirect_to root_path
    end
  end

  def require_admin
    require_role('admin')
  end

  def require_student
    require_role('student')
  end

  def require_mentor
    require_role('mentor')
  end
end
