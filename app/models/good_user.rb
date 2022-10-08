class GoodUser < ApplicationRecord
  belongs_to :user
  belongs_to :good

  validates :user_id,
            uniqueness: {
              scope: [
                :good_id
              ]
            }
end
