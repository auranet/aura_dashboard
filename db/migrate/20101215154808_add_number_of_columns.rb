class AddNumberOfColumns < ActiveRecord::Migration
  def self.up
    add_column :dashboards, :number_of_columns, :integer, :null => false, :default => 3
  end

  def self.down
    remove_column :dashboards, :number_of_columns
  end
end
