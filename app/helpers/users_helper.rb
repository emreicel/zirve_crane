module UsersHelper
    def render_user_role_badge(role)
      badge_class = case role.to_s.downcase
      when 'admin', 'yönetici'
        'text-bg-danger'
      when 'manager', 'müdür'
        'text-bg-warning'
      when 'user', 'kullanıcı'
        'text-bg-info'
      else
        'text-bg-secondary'
      end
  
      tag.span(role.to_s.titleize, class: "badge rounded-pill #{badge_class}")
    end
  end