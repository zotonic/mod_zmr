{% for cat in m.rsc[id].subject %}
  <div class="clearfix"><a href="{{ m.rsc[cat].page_url }}"><div class="ui-icon ui-icon-tag left"></div>{{ m.rsc[cat].title }}</a></div>
{% endfor %}
