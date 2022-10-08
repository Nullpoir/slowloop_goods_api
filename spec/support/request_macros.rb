module RequestMacros
  def fake_admin_login(user)
    login_as administrator, scope: :administrator
  end
end
