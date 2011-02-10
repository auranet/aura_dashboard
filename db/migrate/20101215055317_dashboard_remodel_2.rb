class DashboardRemodel2 < ActiveRecord::Migration
  def self.up
    create_table :dashboard_widgets do |t|
      t.float    :order_number, :default => 0
      t.integer  :column_number, :default => 0
      t.boolean  :is_minimized, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :dashboard_id
      t.integer  :widget_id
    end
    add_index :dashboard_widgets, [:dashboard_id]
    add_index :dashboard_widgets, [:widget_id]
  end

  def self.down
    drop_table :dashboard_widgets
  end
end
