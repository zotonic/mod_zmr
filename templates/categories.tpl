{% extends "base.tpl" %}

{% block content %}

<h1>Module Categories</h1>

<p>
{% for col in m.search[{keyword_cloud cat='zmr_repository'}]|split_in:4 %}
  <div class="zp-25">
    <ul>
      {% for id, count in col %}
        <li>
  	  <h3><a href="{{ m.rsc[id].page_url }}">{{ m.rsc[id].title }}</a> ({{ count }})</h3>
	  {{ m.rsc[id].summary }}
        </li>
      {% endfor %}
    </ul>
  </div>
{% endfor %}
</p>

{% endblock %}
