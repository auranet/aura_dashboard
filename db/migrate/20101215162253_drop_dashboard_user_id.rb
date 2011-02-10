class DropDashboardUserId < ActiveRecord::Migration
  def self.up
    remove_column :dashboards, :user_id

    remove_index :dashboards, :name => :index_dashboards_on_user_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    add_column :dashboards, :user_id, :integer

    add_index :dashboards, [:user_id]
  end
end
