module RequestMacros
  def fake_admin_login(user)
    login_as user, scope: :user
  end
end
