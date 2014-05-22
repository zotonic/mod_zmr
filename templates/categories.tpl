{% extends "base.tpl" %}

{% block content %}

<h1 class="page-header">Module Categories</h1>

<ul id="zmr-categories-list">
  {% for col in m.search[{keyword_cloud cat='zmr_repository'}]|split_in:4 %}
  {% for id, count in col %}
  <li>
    <a href="{{ m.rsc[id].page_url }}">{{ m.rsc[id].title }}</a>
    <span class="badge">({{ count }})</span>
  </li>
  {{ m.rsc[id].summary }}
  {% endfor %}
  {% endfor %}
</ul>

{% endblock %}
