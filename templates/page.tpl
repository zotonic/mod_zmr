{% extends "base.tpl" %}

{% block content %}

	<h1>{{ m.rsc[id].title }}</h1>

	<p class="summary">
	    {{ m.rsc[id].summary }}
	</p>

<pre>
{{ m.rsc[id].zmr_repository_url }}
</pre>

	{{ m.rsc[id].body|show_media }}

<p>
    <a href="{{ m.rsc[id].zmr_repository_url }}">Visit repository site &raquo;</a>
</p>

	<section id="comments">{% include "_comments.tpl" id=id %}</section>
	
{% endblock %}

{% block sidebar %}
{% endblock %}
