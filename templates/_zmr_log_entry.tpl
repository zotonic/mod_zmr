{# until we got some proper css styles... it's a mess #}
<hr />

{% wire id=#entry
	type="click" 
	action={set_value target=target value=entry.id} 
	action={dialog_close} 
%}
<div id={{#entry}}>
{% for key, value in entry %}
	<b>{{key}}:</b> {{value|escape}}<br />
{% endfor %}
</div>
