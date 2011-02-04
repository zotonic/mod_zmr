Log: <a id={{#entry}} href="javascript:void(0)">{{entry}}</a><br />
{% wire id=#entry
	type="click" 
	action={set_value target=target value=entry} 
	action={dialog_close} 
%}