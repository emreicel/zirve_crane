module UsersHelper
    def render_user_role_badge(role)
      badge_class = case role.to_s.downcase
      when 'admin', 'yönetici'
        'text-bg-danger'
      when 'super_admin', 'süper yönetici'
        'text-bg-warning'
      when 'user', 'kullanıcı'
        'text-bg-info'
      when 'accountant', 'muhasebeci'
        'text-bg-success'
      else
        'text-bg-secondary'
      end
  
      tag.span(role.to_s.titleize, class: "badge rounded-pill #{badge_class}")
    end
  end