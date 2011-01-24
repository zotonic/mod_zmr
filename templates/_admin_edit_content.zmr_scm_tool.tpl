
{% with m.rsc[id] as r %}
<div class="item-wrapper">
	<h3 class="above-item clearfix">
		<span class="title">{_ SCM Tool _}</span>
	</h3>

	<div class="item">
		<fieldset class="admin-form">

			<div class="form-item clearfix">
				<label for="zmr_command">{_ Command _}</label>
				<input id="zmr_command" type="text" name="zmr_command" value="{{ r.zmr_command }}" style="width: 80%" />
			</div>

			<div class="form-item clearfix">
				<label for="zmr_arg_checkout">{_ Checkout _}</label>
				<input id="zmr_arg_checkout" type="text" name="zmr_arg_checkout" value="{{ r.zmr_arg_checkout }}" style="width: 80%" />
			</div>

			<div class="form-item clearfix">
				<label for="zmr_arg_history">{_ History _}</label>
				<input id="zmr_arg_history" type="text" name="zmr_arg_history" value="{{ r.zmr_arg_history }}" style="width: 80%" />
			</div>

		</fieldset>
	</div>

</div>
{% endwith %}