class Initial < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :crypted_password, :limit => 40
      t.string   :salt, :limit => 40
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :name
      t.string   :email_address
      t.boolean  :administrator, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :state, :default => "active"
      t.datetime :key_timestamp
    end
    add_index :users, [:state]

    create_table :dashboards do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    add_index :dashboards, [:user_id]

    create_table :dashboard_columns do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :dashboard_id
    end
    add_index :dashboard_columns, [:dashboard_id]

    create_table :dashboard_widgets do |t|
      t.integer  :order_number, :default => 0
      t.string   :name
      t.string   :widget_class
      t.text     :widget_args
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :users
    drop_table :dashboards
    drop_table :dashboard_columns
    drop_table :dashboard_widgets
  end
end
