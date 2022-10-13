class GoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :isbn, :jan, :shopping_url,
             :released_at, :production_ended_at, :created_at, :updated_at
end
