class HoboMigration1 < ActiveRecord::Migration
  def self.up
    add_column :mlrs, :total_revenue, :float
    add_column :mlrs, :total_profit, :float
  end

  def self.down
    remove_column :mlrs, :total_revenue
    remove_column :mlrs, :total_profit
  end
end
