/**
 This file lives in the aura-dashboard plugin and will be overwritten
 at server startup.
 */
jQuery(function() {
  window.dashboard = jQuery('#dashboard').dashboard({
    columns: 3,
    emptyPlaceholderInner: '<a href="/">Add some more widgets to your dashboard.</a>',
    ajaxCallbacks: {
      getWidgetsByColumn: {
        url: '/dashboards/show_dashboard'
      },
      saveColumns: {
        url: '/dashboards/save_dashboard'
      },
      widgetSettings: {
        url: '/widgets/show_widget_settings'
      },
      getWidget: {
        url: '/widgets/show_widget'
      }
    },
    callbacks: {
      enterFullscreen: function(widget) {
        var dashboard = this;
        eval(widget.fullscreenJs);
      },
    },
    widgetCallbacks: {
      get: function() {
        var widget = this;
        eval(widget.js);
      },
    }
  });
});
