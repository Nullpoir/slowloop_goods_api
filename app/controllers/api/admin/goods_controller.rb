class Api::Admin::GoodsController < AdminController
  def index
    render json: goods, each_serializer: GoodSerializer
  end

  private

  def goods
    @goods ||= Good.order(id: :asc)
  end
end
