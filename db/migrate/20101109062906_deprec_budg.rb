class DeprecBudg < ActiveRecord::Migration
  def self.up
    create_table :depreciation_budgets do |t|
      t.string   :inservice_date, :length => 10
      t.string   :ps2_project, :length => 6
      t.string   :old_asset_id, :length => 8
      t.string   :fy11_depreciation, :length => 10
      t.string   :usefullife, :length => 5
      t.string   :fy10_depreciation, :length => 16
      t.string   :totalcost, :length => 16
      t.string   :description, :length => 45
      t.string   :status, :length => 15
      t.string   :department, :length => 4
      t.text     :annotations
      t.text     :imported_from_file
      t.integer  :line_number
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :depreciation_budgets
  end
end
