
{% with m.rsc[id] as r %}
<div class="item-wrapper">
	<h3 class="above-item clearfix">
		<span class="title">{_ ZMR Release _}</span>
	</h3>

	<div class="item">
		<fieldset class="admin-form">
		<div class="form-item clearfix">
			<label for="zmr_changeset">{_ Changeset _}</label>
			<input id="zmr_changeset" type="text" name="zmr_changeset" value="{{ r.zmr_changeset }}" />
			
			{% button 
				text=_"Select from log" 
				action={dialog_open 
					title="Select changeset from log" 
					template="_zmr_select_changeset.tpl" 
					repo=r.s.zmr_repo_release|first 
					target="zmr_changeset"
				} 
			%}

			
			{% include "_admin_save_buttons.tpl" %}

		</div>
		</fieldset>
	</div>
</div>
{% endwith %}