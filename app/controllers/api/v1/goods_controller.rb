class Api::V1::GoodsController < ApplicationController
  def index
    render json: goods, each_serializer: GoodSerializer
  end

  private

  def goods
    @goods ||= Good.order(id: :asc).limit(limit).offset(offset)
  end
end
