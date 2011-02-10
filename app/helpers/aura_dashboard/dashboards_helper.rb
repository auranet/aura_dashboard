module AuraDashboard
  
  module DashboardsHelper
    
    def include_dashboard_styles_and_scripts(options={})
      # Validate options
      options.each do |option_name, option_value|
        raise "Invalid non-Symbol option name class #{option_name.class.to_s}" if !option_name.inherits_from(Symbol)
        raise "Invalid non-String option class #{option_value.class.name} for #{option_name.to_s}" if !option_value.inherits_from?(String)
      end
      # Set option default values
      options[:jquery] ||= "aura-dashboard/jquery/jquery-1.4.3.min"
      options[:jquery_ui] ||= "aura-dashboard/jquery-ui/jquery-ui.min"
      options[:jquery_ui_stylesheet] ||= "aura-dashboard/jquery-ui/jquery-ui"
      options[:dashboard_stylesheet] ||= "aura-dashboard/dashboard"
      # Render
      render :partial => 'aura_dashboard/standard_styles_and_scripts', :locals => {:options => options}
    end
    
  end
  
end