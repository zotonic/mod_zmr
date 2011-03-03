  <span class="zmr_categories">
    {% for cat in m.rsc[id].subject %}
      <span class="zmr_category"><a href="{{ m.rsc[cat].page_url }}">{{ m.rsc[cat].title }}</a></span>
    {% endfor %}
  </span>
