class GoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :isbn, :jan,
             :created_at, :updated_at
end
