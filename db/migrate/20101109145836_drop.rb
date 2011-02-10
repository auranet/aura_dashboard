class Drop < ActiveRecord::Migration
  def self.up
    remove_column :depreciation_budgets, :fy11_depreciation
    remove_column :depreciation_budgets, :usefullife
    remove_column :depreciation_budgets, :fy10_depreciation
    remove_column :depreciation_budgets, :totalcost
  end

  def self.down
    add_column :depreciation_budgets, :fy11_depreciation, :string
    add_column :depreciation_budgets, :usefullife, :string
    add_column :depreciation_budgets, :fy10_depreciation, :string
    add_column :depreciation_budgets, :totalcost, :string
  end
end
