{% for entry in m.zmr.repo[repo].log %}
	{% include "_zmr_log_entry.tpl" entry=entry target=target %}
{% empty %}
	No history.
{% endfor %}

