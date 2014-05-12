{% extends "base.tpl" %}

{% block title %}{_ Search _}{% endblock %}

{% block content %}
	{% if q.qs or q.qcat %}
	{% with result|default_if_undefined:m.search.paged[{query
	        text=q.qs
	        cat=q.qcat|default:[`zmr_repository`]
	        pagelen=10 page=q.page}] as result
	%}
	        {% if result.total > 0 %}
	                <div id="content-pager">
	                        <span class="pull-left">{_ Searching for _}
	                                {% if q.qs %}<b class="qs">{{ q.qs|escape }}</b>{% endif %}
	                                {% if q.qcat %}<span class="qcat">{{ m.rsc[q.qcat].title }}</span>{% endif %}
	                        </span>
	                        &nbsp;
	                    <span class="pull-right">
	                            {_ Page _} {{ result.page }}/{{ result.pages }}
	                    </span>
                            <div>
	                            {% pager result=result %}
                            </div>

                            {% for id in result %}
                                    {% include "_zmr_mod_card.tpl" id=id %}
                            {% endfor %}

	                    <div class="clearfix"></div>
                            <div>
	                            {% pager result=result %}
                            </div>
                    </div>
	    {% else %}
	    <p id="content-pager">
	        {_ Did not find any pages matching _} <b class="qs">{{ q.qs|escape }}</b>.
	    </p>
	    {% endif %}
	{% endwith %}

	<hr/>
	{% endif %}

	<form class="form-inline" method="get" action="{% url search %}">
		<div class="form-group">
	        <input type="hidden" name="qcat" value="{{ q.qcat|escape }}" />
		<input class="form-control" type="text" name="qs" value="" placeholder="{_ Search _} {_ modules _}" />
		</div>
		<button class="btn btn-default" type="submit">{_ Search _} {{ m.rsc[q.qcat].title }}</button>
	</form>

{% endblock %}
