class CreateGoods < ActiveRecord::Migration[7.0]
  def change
    create_table :goods do |t|
      t.string :name, comment: '名称'
      t.string :description, comment: '説明'
      t.string :isbn, null:true, comment: 'ISBN番号'
      t.string :jan, null:true, comment: 'JANコード'
      t.string :shopping_url, comment: '購入可能URL'
      t.datetime :released_at, comment: '発売日'
      t.datetime :production_ended_at, comment: '生産終了日'

      t.timestamps
    end
  end
end
