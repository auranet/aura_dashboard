module AuraDashboard
  
  class DashboardWidget < ::ActiveRecord::Base

    belongs_to :dashboard
    belongs_to :widget

    # return true if any value is found in the is_minimized
    def is_minimized
      if attributes["is_minimized"].nil?
        return false
      else
        attributes["is_minimized"]
      end
    end

    # syntactic sugar for is_minimized (aliases to the shorter function)
    def is_minimized?
      is_minimized
    end

  end

end