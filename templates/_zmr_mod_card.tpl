<div class="ui-widget-content ui-corner-all">
  <a href="{{ m.rsc[id].page_url }}"><h3 class="ui-widget-header">{{ m.rsc[id].title }}</h3></a>
  <div class="padding">
    {% include "_zmr_mod_category_links.tpl" %}
    <p>
	{{ m.rsc[id].summary }}
    </p>
  </div>
</div>
