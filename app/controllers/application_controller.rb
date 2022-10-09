class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ApiRenderable
  include ApiPaginate
end
