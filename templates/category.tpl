{% extends "base.tpl" %}

{% block content %}

<h1>Category: {{ m.rsc[id].title }}</h1>
<p class="summary">
  {{ m.rsc[id].summary }}
</p>

<p>
    {{ m.rsc[id].body|show_media }}
</p>

<p>
{% for col in m.search[{referrers id=id}]|split_in:4 %}
  <div class="zp-25">
    <ul>
      {% for id, predicate in col %}
        <li class="padding">
	  {% include "_zmr_mod_card.tpl" id=id %}
        </li>
      {% endfor %}
    </ul>
  </div>
{% endfor %}
</p>


{% endblock %}
