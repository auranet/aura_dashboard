class AuraDashboard < ActiveRecord::Migration
  def self.up
    create_table "dashboard_widgets", :force => true do |t|
      t.float    "order_number",  :default => 0.0
      t.integer  "column_number", :default => 0
      t.boolean  "is_minimized",  :default => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "dashboard_id"
      t.integer  "widget_id"
    end

    add_index "dashboard_widgets", ["dashboard_id"], :name => "index_dashboard_widgets_on_dashboard_id"
    add_index "dashboard_widgets", ["widget_id"], :name => "index_dashboard_widgets_on_widget_id"

    create_table "dashboards", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "number_of_columns", :default => 3, :null => false
      t.string   "name"
    end

    create_table "widgets", :force => true do |t|
      t.string   "name"
      t.string   "widget_class"
      t.text     "widget_args"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table :widgets
    drop_table :dashboards
    drop_table :dashboard_widgets
  end
end
