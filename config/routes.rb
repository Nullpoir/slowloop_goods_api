Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
    # 公開側
    namespace :v1 do
      resources :goods, only: %i(index show)
    end
    # 管理側
    namespace :admin do
      resources :goods
    end
  end
end
