class DashboardRemodel1 < ActiveRecord::Migration
  def self.up
    rename_table :dashboard_widgets, :widgets

    drop_table :dashboard_columns

    remove_column :widgets, :dashboard_column_id
    remove_column :widgets, :order_number
    remove_column :widgets, :is_minimized

    remove_index :widgets, :name => :index_dashboard_widgets_on_dashboard_column_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    add_column :dashboard_widgets, :dashboard_column_id, :integer
    add_column :dashboard_widgets, :order_number, :integer, :default => 0
    add_column :dashboard_widgets, :is_minimized, :boolean, :default => false

    rename_table :widgets, :dashboard_widgets

    create_table "dashboard_columns", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "dashboard_id"
    end

    add_index "dashboard_columns", ["dashboard_id"], :name => "index_dashboard_columns_on_dashboard_id"

    add_index :dashboard_widgets, [:dashboard_column_id]
  end
end
