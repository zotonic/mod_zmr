{% extends "base.tpl" %}

{% block content %}
<div class="zp-100">
    <h1>{{ m.rsc[id].title }}</h1>
    {{ m.rsc[id].body|show_media }}
</div>

{% for col in m.search[{query cat="zmr_repository" sort="pivot_title" pagelen=10000}]|vsplit_in:4 %}
<div class="zp-25">
    <ul>
        {% for id in col %}
        <li>
            <h3><a href="{{ m.rsc[id].page_url }}">{{ m.rsc[id].title }}</a></h3>
            {{ m.rsc[id].summary }}
        </li>
        {% endfor %}
    </ul>
</div>
{% endfor %}


{% endblock %}
