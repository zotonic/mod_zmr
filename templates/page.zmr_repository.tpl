{% extends "base.tpl" %}

{% block content %}

<h1>{{ m.rsc[id].title }}</h1>

<p class="summary">
    {{ m.rsc[id].summary }}
</p>

<pre>
{{ m.rsc[id].zmr_repo_scm.zmr_command }} clone {{ m.rsc[id].zmr_repository_url }} {{ m.rsc[id].title }}
</pre>

{{ m.rsc[id].body|show_media }}

<p>
    SCM system: {{ m.rsc[id].zmr_repo_scm.title  }}<br />
    Project website: <a href="{{ m.rsc[id].website|default:m.rsc[id].zmr_repository_url }}">m.rsc[id].website|default:m.rsc[id].zmr_repository_url</a>
</p>


<section id="comments">{% include "_comments.tpl" id=id %}</section>

{% endblock %}

{% block sidebar %}
{% endblock %}
