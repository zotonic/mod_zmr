
{% with m.rsc[id] as r %}
<div class="item-wrapper">
	<h3 class="above-item clearfix">
		<span class="title">{_ ZMR Release _}</span>
	</h3>

	<div class="item">
		<fieldset class="admin-form">
		<div class="form-item clearfix">
			<label for="zmr_branch">{_ Branch/Revision/Changeset _}</label>
			<input id="zmr_branch" type="text" name="zmr_branch" value="{{ r.zmr_branch }}" />
			
			{% button 
				text=_"Show log" 
				action={dialog_open 
					title="Select branch from log" 
					template="_zmr_select_branch.tpl" 
					repo=r.zmr_module_release|first 
					target="zmr_branch"
				} 
			%}

			
			{% include "_admin_save_buttons.tpl" %}

		</div>
		</fieldset>
	</div>
</div>
{% endwith %}