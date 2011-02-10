class WidgetToColumnRelation < ActiveRecord::Migration
  def self.up
    add_column :dashboard_widgets, :dashboard_column_id, :integer

    add_index :dashboard_widgets, [:dashboard_column_id]
  end

  def self.down
    remove_column :dashboard_widgets, :dashboard_column_id

    remove_index :dashboard_widgets, :name => :index_dashboard_widgets_on_dashboard_column_id rescue ActiveRecord::StatementInvalid
  end
end
