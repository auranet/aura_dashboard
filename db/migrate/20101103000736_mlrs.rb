class Mlrs < ActiveRecord::Migration
  def self.up
    create_table :mlrs do |t|
      t.float    :active_accounts
      t.float    :deactivated_gross_profit_pct
      t.float    :activated_nonrecur_cogs
      t.float    :activated_nonrecur_profit_pct
      t.float    :activated_nonrecur_profit
      t.float    :activated_nonrecur_revenue
      t.float    :month
      t.float    :week
      t.string   :start_day
      t.float    :deactivated_recur_profit
      t.float    :num_deactivated
      t.float    :activated_avg_revenue
      t.float    :avg_revenue
      t.float    :activated_gross_profit_pct
      t.float    :activated_recur_profit
      t.float    :activated_recur_cogs
      t.float    :num_activated
      t.float    :churn_pct
      t.float    :active_deals
      t.float    :deactivated_recur_cogs
      t.float    :num_deals_signed
      t.float    :deactivated_recur_revenue
      t.float    :num_activated_reporting
      t.float    :year
      t.float    :weekly_recurrent_cogs_delta
      t.float    :active_circuits_delta
      t.float    :num_deactivated_reporting
      t.float    :weekly_recurrent_profit_delta
      t.float    :activated_avg_profit
      t.float    :num_pending
      t.float    :avg_profit
      t.float    :weekly_recurrent_revenue_delta
      t.float    :activated_recur_revenue
      t.text     :annotations
      t.text     :imported_from_file
      t.integer  :line_number
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :mlrs
  end
end
