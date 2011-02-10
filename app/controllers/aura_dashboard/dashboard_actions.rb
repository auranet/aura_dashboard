module AuraDashboard
  
  module DashboardActions
    
    def save_dashboard
      dashboard = Dashboard.find(params[:dashboard_id])
      # Initialize columns.  Columns will not be present if the last
      # widget has been removed.
      if not params[:columns]
        params[:columns] = {}
      end
      # Save placement and state
      params[:columns].each do |column_index, dashboard_widgets|
        dashboard_widgets.each do |dashboard_widget_id, widget_info|
          dashboard_widget = DashboardWidget.find(dashboard_widget_id)
          column_index = column_index.to_i
          # Only set column number, if in bounds.
          if column_index >= 0 && column_index < dashboard.number_of_columns
            dashboard_widget.column_number = column_index
          end
          dashboard_widget.order_number = (widget_info["order"] ? widget_info["order"].to_i : 0)
          dashboard_widget.is_minimized = (widget_info["minimized"] ? widget_info["minimized"] == '1' : false)
          dashboard_widget.save!
        end
      end
      # Remove unmentioned widgets
      all_widgets = dashboard.dashboard_widgets.collect{|dw| dw.id}
      current_widgets = params[:columns].collect do |column_index, widgets|
        widgets.collect do |widget_id, widget_info|
          widget_id.to_i
        end
      end.flatten
      removed_widgets = all_widgets.select{|id| !current_widgets.include?(id)}
      if not removed_widgets.empty?
        DashboardWidget.destroy(removed_widgets)
      end
      render :json => []
    end

    def show_dashboard
      respond_to do |format|
        format.html do
          render
        end
        format.json do
          if dashboard = Dashboard.find(params[:dashboard_id])
            column_data = []
            (0..(dashboard.number_of_columns-1)).each do |column_number|
              widget_data = []
              dashboard_widgets = dashboard.widgets_for_column(column_number)
              dashboard_widgets.each do |dashboard_widget|
                widget_data << {:id => dashboard_widget.id.to_s, :minimized  => dashboard_widget.is_minimized}
              end
              column_data << widget_data
            end
            render :json => column_data.to_json
          else
            render :status => 404
          end
        end
      end
    end
    
  end
  
end
