class Readd < ActiveRecord::Migration
  def self.up
    add_column :depreciation_budgets, :fy11_depreciation, :float
    add_column :depreciation_budgets, :usefullife, :float
    add_column :depreciation_budgets, :fy10_depreciation, :float
    add_column :depreciation_budgets, :totalcost, :float
  end

  def self.down
    remove_column :depreciation_budgets, :fy11_depreciation
    remove_column :depreciation_budgets, :usefullife
    remove_column :depreciation_budgets, :fy10_depreciation
    remove_column :depreciation_budgets, :totalcost
  end
end
