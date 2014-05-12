<!DOCTYPE html>
{# Base TEXT template #}
<html lang="{{ z_language|default:'en'|escape }}">
  <head>
    <meta charset="utf-8" />
    <title>{% block title %}{{ id.title }} &mdash; {{ m.config.site.title.value }}{% endblock %}</title>

    <link rel="icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="author" content="Zotonic" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">

    <meta property="og:title" content="{% block title %}{{ m.site.title }}{% endblock %}"/>
    {% with m.rsc[id].media|first as first_media %}{% if first_media %}
                    <meta property="og:image" content="http://{{ m.site.hostname }}{% image_url first_media width=500 %}"/>
            {% endif %}{% endwith %}
    <meta property="og:site_name" content="{{ m.site.title }}"/>
    {% if id and m.rsc[id].summary %}<meta property="og:description" content="{{ m.rsc[id].summary|escape }}"/>{% endif %}

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    {% all include "_html_head.tpl" %}
    {% lib
            "css/bootstrap.min.css"
            "css/bootstrap-theme.css"
            "css/project.css"
    %}
    {% block html_head_extra %}{% endblock %}
  </head>
  <body class="{% block page_class %}{% endblock %}">
    {% block navbar %}
            {% include "_navbar.tpl" %}
    {% endblock %}
    <!-- Begin page content -->
    <div class="container">
            {% block content %}
            {% endblock %}
    </div>
    {% include '_footer.tpl' %}
    <!-- Placed at the end of the document so the pages load faster -->
    {% block js_libs %}
            {% include "_js_include_jquery.tpl" %}
            {% lib
	            "js/apps/zotonic-1.0.js"
	            "js/apps/z.widgetmanager.js"
	            "js/modules/livevalidation-1.3.js"
	            "js/modules/z.inputoverlay.js"
            %}
            {% lib
                    "js/bootstrap.min.js"
            %}

            {% stream %}
            {% script %}

            <script type="text/javascript">
              $(function ()
              {
                  $.widgetManager();
              });
            </script>
    {% endblock %}
    {% block _js_include_extra %}{% endblock %}
    {% block _css_include_extra %}{% endblock %}

    {% all include "_html_body.tpl" %}
    {# debug toolbar #}
    {% if m.site.debug %}
            {% debug_toolbar %}
    {% endif %}

    {% lib "js/bootstrap.min.js" %}
  </body>
</html>
