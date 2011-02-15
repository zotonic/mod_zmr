{% extends "base.tpl" %}

{% block content %}


<h1>Modules</h1>


{% for cols in  m.search[{query cat="zmr_repository" sort="pivot_title" pagelen=10000}]|group_title_firstchar:4 %}

<ol class="alphabetical-list">
    {% for group in cols %}
    <li><h2>{{ group.first }}</h2>
        <ul>
            {% for id in group.result %}
            <li>
                <h3><a href="{{ m.rsc[id].page_url }}">{{ m.rsc[id].title }}</a></h3>
                {{ m.rsc[id].summary }}
            </li>
            {% endfor %}
        </ul>
    </li>
    {% endfor %}
</ol>

{% endfor %}



{% endblock %}
