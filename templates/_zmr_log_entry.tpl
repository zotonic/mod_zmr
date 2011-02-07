{# until we got some proper css styles... it's a mess #}
<hr />

{% wire id=#entry
	type="click" 
	action={set_value target=target value=entry.changeset} 
	action={dialog_close} 
%}
<div id={{#entry}}>
{% autoescape on %}
	<b>Changeset:</b> {{entry.changeset}}{% if entry.tag %} ({{entry.tag}}){% endif %}<br />
	<b>Date:</b> {{entry.date}}<br />
	<b>User:</b> {{entry.user}}<br />
	<b>Summary:</b> {{entry.summary}}<br />
{% endautoescape %}
</div>
