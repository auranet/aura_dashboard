module AuraDashboard
  
  class Dashboard < ::ActiveRecord::Base

    has_many :dashboard_widgets

    # return an array of DashboardWidget objects related to this dashboard
    # whose column index matches argument 1 passed to the function.
    def widgets_for_column(column_number)
      raise ArgumentError.new("first argument must be an Integer") unless column_number.is_a? Integer
      if column_number < 0 or column_number > (number_of_columns - 1)
        raise ArgumentError.new("out of range: argument #{column_number} must be between 0 and #{number_of_columns - 1}")
      end
      dashboard_widgets.all(
        :conditions => {:column_number => column_number},
        :order => 'order_number')
    end

  end
  
end