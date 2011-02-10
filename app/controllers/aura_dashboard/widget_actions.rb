module AuraDashboard
  module WidgetActions
    def show_widget
      respond_to do |format|
        format.html do
          render
        end
        format.json do
          begin
            if params[:dashboard_widget_id]
              if dashboard_widget = DashboardWidget.find(params[:dashboard_widget_id].to_i)
                widget = dashboard_widget.widget
                if builder_class = widget.widget_class.constantize
                  builder = builder_class.new(
                    :view => AuraVisualize::ViewFactory.from_yaml(widget.widget_args),
                    :id => widget.id)
                  render :json => {
                    :title => widget.title,
                    # HTML to place inside the widget
                    :content => builder.content,
                    # HTML display if a widget is made fullscreen
                    :fullscreen => builder.fullscreen,
                    # Javascript to run once the fullscreen content has been rendered
                    :fullscreenJs => builder.fullscreen_js,
                    # Javascript to run once the content has been rendered
                    :js => builder.js,
                    :settings => true,
                  }
                else # if builder_class = widget.widget_class.constantize
                  logger.error "request for #{widget.widget_class} is not supported ; unknown widget class"
                  render :status => 501
                end
              else
                render :status => 404
              end
            else
              logger.error "#{current_method} called without :dashboard_widget_id parameter"
              render :status => 400
            end
          rescue Exception => e
            render :json => {
              :title => widget.title,
              # HTML to place inside the widget
              :content => "<div class=\"tb\">#{e.clean_message}<br/>#{e.clean_backtrace.join('<br/>')}</div>",
              :settings => true,
            }
          end
        end
      end
    end

    def show_widget_settings
      f = SqlPivotViewForm.new

      dashboard_widget = DashboardWidget.find(params[:dashboard_widget_id].to_i)
      widget = dashboard_widget.widget

      # No settings yet.
      if params['table'].nil?
        widget_args = YAML.load(widget.widget_args)
        if widget_args[:view] == 'AuraVisualize::SqlPivotView' and
          widget_args[:arguments]

          [:dimensions, :filters, :orderings].each do |arg|
            strip_names(widget_args[:arguments], arg)
          end

          # Stringify keys for form building
          walk_hash(widget_args[:arguments]) do |sub_hash|
            sub_hash.stringify_keys!
          end

          f.add_data(widget_args[:arguments])
        end
      else
        # Remove empty measures
        if params[:measures].is_a? Array
          params[:measures].reject! do |h|
            h[:name].blank?
          end
        end

        # Create separate form and use cloning to avoid data corruption.
        save_form = SqlPivotViewForm.new
        save_form.add_data(params.dup)

        # User has clicked save.
        if request.post?
          new_arguments = save_form.to_hash
          walk_hash(new_arguments) do |sub_hash|
            sub_hash.symbolize_keys!
          end


          [:dimensions, :filters, :orderings].each do |arg|
            add_names(new_arguments, arg)
          end


          current_widget_args = YAML.load(widget.widget_args)
          current_widget_args[:arguments] = new_arguments
          widget.update_attribute(:widget_args, current_widget_args.to_yaml)
        end

        f.add_data(params.dup)
      end
      @form = f

      respond_to do |format|
        format.html do
          return render
        end
        format.json do
          return render :json => {
            :markup => render_to_string(:partial => 'widgets/widget_args_fields')
          }
        end
      end
    end

    # Mutate an Array in a Hash for data storage.
    # Transform 'blah' to {:name => 'blah'}
    #
    # Before:
    #  - year
    #  - month
    #
    # After:
    #  - :name: year
    #  - :name: month
    def add_names(top_hash, key)
      if top_hash[key].is_a? Array
        new_values = top_hash[key].collect do |h|
          if h.is_a? Hash
            h
          else
            {:name => h}
          end
        end.compact
        top_hash[key] = new_values
      end
    end

    # Mutate an Array in a Hash for form building.
    # Transform {:name => 'blah'} to 'blah'
    #
    # Before:
    #  - :name: year
    #  - :name: month
    #
    # After:
    #  - year
    #  - month
    def strip_names(top_hash, key)
      if top_hash[key].is_a? Array
        new_values = top_hash[key].collect do |h|
          if h.is_a? Hash
            h[:name]
          else
            h
          end
        end.compact
        top_hash[key] = new_values
      end
    end

    # Yield every hash in given data, includes hashes in arrays in hashes.
    # Used to mutate keys, since rails params are strings and our widget_args
    # expect symbols.
    def walk_hash(h)
      case h
        when Hash
          # HashWithIndifferentAccess doesn't do symbolize_keys! correctly.
          bad_hashes = h.select do |k, v|
            v.is_a? HashWithIndifferentAccess
          end
          bad_hashes.each do |bad_key|
            h[bad_key] = h[bad_key].to_hash
          end

          h.each do |k, v|
            case v
              when Hash, Array
                walk_hash(v){|sh| yield sh}
            end
          end
          # symbolize_keys! does not work on these.
          # cast to plain Hash
          if h.is_a? HashWithIndifferentAccess
            h = h.to_hash
          end
          yield h
        when Array
          # HashWithIndifferentAccess doesn't do symbolize_keys! correctly.
          h = h.each_with_index do |v, i|
            if v.is_a? HashWithIndifferentAccess
              h[i] = v.to_hash
            end
          end

          h.each do |v|
            case v
              when Hash, Array
                walk_hash(v){|sh| yield sh}
            end
          end
      end
    end
  end
end
