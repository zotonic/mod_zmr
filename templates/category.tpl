{% extends "base.tpl" %}

{% block content %}

        <h3>Category: {{ m.rsc[id].title }}</h3>
        <p class="summary">
                {{ m.rsc[id].summary }}
        </p>

        <p>
                {{ m.rsc[id].body|show_media }}
        </p>

        <p>
                {% for col in m.search[{referrers id=id}]|split_in:4 %}
                        <div class="modules-list">
                                {% for id, predicate in col %}
                                        {% include "_zmr_mod_card.tpl" id=id %}
                                {% endfor %}
                        </div>
                {% endfor %}
        </p>


{% endblock %}
