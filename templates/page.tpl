{% extends "base.tpl" %}

{% block content %}

        {% block page_header %}
	        <h1 class="page-header">{{ m.rsc[id].title }}</h1>
        {% endblock %}

        {% block page_summary %}
	        <p class="summary">
	                {{ m.rsc[id].summary }}
	        </p>
        {% endblock %}

        {% block page_body %}
                {{ m.rsc[id].body|show_media }}
        {% endblock %}

        <section class="clearfix">{% include "_edit_button.tpl" %}</section>

        <section id="comments">{% include "_comments.tpl" id=id %}</section>

{% endblock %}

{% block sidebar %}
{% endblock %}
