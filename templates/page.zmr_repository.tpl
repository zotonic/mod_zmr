{% extends "base.tpl" %}

{% block content %}

<h1>{{ m.rsc[id].title }}</h1>

<p class="summary">
    {{ m.rsc[id].summary }}
</p>

<p>
    <div class="left"><a href="{% url categories %}">Categories</a>:</div> {% include "_zmr_mod_category_links.tpl" %}<br />
    SCM system: {{ m.rsc[id].zmr_repo_scm.title  }}<br />
    {% if m.rsc[id].author %}Author: {{ m.rsc[id].author.title }}<br />{% endif %}
    Project website: <a href="{{ m.rsc[id].website|default:m.rsc[id].zmr_repository_url }}">{{ m.rsc[id].website|default:m.rsc[id].zmr_repository_url }}</a>
</p>

<p>
    {{ m.rsc[id].body|show_media }}
</p>


<h2>Installation</h2>

Zotonic >= 0.10:
<pre>
zotonic modules install {{ m.rsc[id].title }}
</pre>

Zotonic <= 0.9:
<pre>
zotonic installmodule {{ m.rsc[id].title }}
</pre>

Zotonic <= 0.6:
<pre>
{{ m.rsc[id].zmr_repo_scm.zmr_command }} clone {{ m.rsc[id].zmr_repository_url }} {{ m.rsc[id].title }}
</pre>



<section class="clearfix">{% include "_edit_button.tpl" %}</section>

<section id="comments">{% include "_comments.tpl" id=id %}</section>

{% endblock %}

{% block sidebar %}
{% endblock %}
