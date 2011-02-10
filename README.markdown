Aura-Dashboard
==============


Typical Usage
-------------

To embed a dashboard within a typical view, first you must include the standard assets in your page's ``<head>`` section:

    <%= include_dashboard_styles_and_scripts %>

Then, include a ``<div>`` section with an id of ``dashboard``:

    <div id="dashboard"></div>

Include the dashboard helper methods in your helper:

    include AuraDashboard::DashboardsHelper

Also, include the dashboard methods in your controller:

    include AuraDashboard::DashboardActions
    helper AuraDashboard::DashboardsHelper

Custom Usage
------------

If you need to customize your styles and scripts away from standard, you can add any or all of the following arguments to
your view's call to ``include_dashboard_styles_and_scripts`` to replace the defaults built into the plugin:

* ``:jquery => *"path/to/jquery/javascript"*``
* ``:jquery_ui => *"path/to/jquery/ui/javascript"*``
* ``:jquery_ui_stylesheet => *"path/to/jquery/ui/stylesheet"*``
* ``:dashboard_stylesheet => *"path/to/custom/dashboard/stylesheet"*``