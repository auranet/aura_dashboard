class AddMinimizedFlagToWidgets < ActiveRecord::Migration
  def self.up
    add_column :dashboard_widgets, :is_minimized, :boolean, :default => false
  end

  def self.down
    remove_column :dashboard_widgets, :is_minimized
  end
end
