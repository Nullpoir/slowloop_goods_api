class CreateGoodUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :good_users do |t|
      t.bigint :good_id, index: true, comment: 'グッズID'
      t.bigint :user_id, index: true, comment: 'ユーザーID'
      t.datetime :purchased_at, comment: '購入日'

      t.timestamps
    end
    # 重複で登録を防ぐため、goodとuserに複合一意制約を設ける
    add_index  :good_users, [:good_id, :user_id], unique: true
  end
end
