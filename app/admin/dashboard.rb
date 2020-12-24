ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    
    session = Session.where(default_session: true).first
    courses = session&.courses&.includes(:assignments)
    render 'main', {
      courses: courses
    }
  end
end
