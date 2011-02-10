module AuraDashboard

  class Widget < ActiveRecord::Base
  
    has_many :dashboard_widgets
  
  end

end