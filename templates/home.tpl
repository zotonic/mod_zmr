{% extends "base.tpl" %}

{% block html_head_extra %}
   
{% endblock %}

{#% block page_class %}ui-widget{% endblock %#}

{% block content %}
<div class="zp-100">
    <h1>{{ m.rsc[id].title }}</h1>
    {{ m.rsc[id].body|show_media }}
</div>

{% for col in m.search[{query cat="zmr_repository" sort="pivot_title" pagelen=10000}]|split_in:4 %}
<div class="zp-25">
    <ul>
        {% for id in col %}
        <li class="padding">
	  {% include "_zmr_mod_card.tpl" id=id %}
        </li>
        {% endfor %}
    </ul>
</div>
{% endfor %}


{% endblock %}
