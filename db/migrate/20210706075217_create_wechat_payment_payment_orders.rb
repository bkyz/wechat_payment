class CreateWechatPaymentPaymentOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :wechat_payment_payment_orders do |t|
      t.string :openid
      t.string :out_trade_no
      t.references :goods, polymorphic: true, null: false
      t.references :customer, polymorphic: true, null: false
      t.string :transaction_id
      t.string :body
      t.integer :total_fee
      t.string :trade_type
      t.string :spbill_create_ip
      t.string :prepay_id
      t.string :state
      t.datetime :paid_at
      t.datetime :refunded_at
      t.jsonb :payment_params

      t.timestamps
    end
    add_index :wechat_payment_payment_orders, :openid
  end
end
