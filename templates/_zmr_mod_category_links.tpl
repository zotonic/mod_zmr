<ul class="inline">
{% for cat in m.rsc[id].subject %}
        <li><a href="{{ m.rsc[cat].page_url }}"><span class="label label-primary">{{ m.rsc[cat].title }}</span></a></li>
{% endfor %}
</ul>
