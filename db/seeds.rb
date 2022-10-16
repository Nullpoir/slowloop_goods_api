p '管理ユーザー作成開始'
FactoryBot.create(:user, email: 'admin@example.com', is_admin: true, password: 'test-1234', password_confirmation: 'test-1234')
p '管理ユーザー作成完了'

p 'グッズ作成開始'
FactoryBot.create_list(:good, 10)
p 'グッズ作成完了'

p 'seedデータ作成完了'
