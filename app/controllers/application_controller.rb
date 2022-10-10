class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ApiRenderable
  include ApiPaginate

  private

  def limit
    @limit = params[:limit].nil? ? 50 : params[:limit]
  end

  def offset
    @offset = params[:offset].nil? ? 0 : params[:offset]
  end

  def render_success_destroy
    render json: { success: true}, status: :ok
  end
end
