class CreateGoodUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :good_users do |t|

      t.timestamps
    end
  end
end
