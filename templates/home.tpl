{% extends "base.tpl" %}

{% block html_head_extra %}

{% endblock %}

{#% block page_class %}ui-widget{% endblock %#}

{% block content %}
<div class="well">
    <h1>{{ m.rsc[id].title }}</h1>
    {{ m.rsc[id].body|show_media }}
</div>

{% with m.search[{query cat="zmr_repository" sort="pivot_title" pagelen=m.config.site.pagelen.value}] as result %}
        <div class="modules-list row">
                {% for id in  result %}
	                {% include "_zmr_mod_card.tpl" id=id %}
                {% endfor %}
        </div>

        <div class="clearfix">
                {% ifequal m.config.site.pagelen.value result|length %}
                        {% button text="load more..." action={moreresults result=result
                                        target="modules-list"
                                        template="_zmr_mod_card.tpl"}
                                class="btn-default btn-primary"
                        %}
                {% endifequal %}
        </div>

{% endwith %}



{% endblock %}
