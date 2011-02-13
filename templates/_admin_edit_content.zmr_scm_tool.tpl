
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
				<label for="zmr_arg_clone">{_ Clone _}</label>
				<input id="zmr_arg_clone" type="text" name="zmr_arg_clone" value="{{ r.zmr_arg_clone }}" style="width: 80%" />
			</div>

			<div class="form-item clearfix">
				<label for="zmr_arg_log">{_ Log _}</label>
				<input id="zmr_arg_log" type="text" name="zmr_arg_log" value="{{ r.zmr_arg_log }}" style="width: 80%" />
			</div>

			<div class="form-item clearfix">
				<label for="zmr_log_re">{_ Log Parser (Regular Expression, PCRE) _}</label>
				<input id="zmr_log_re" type="text" name="zmr_log_re" value="{{ r.zmr_log_re }}" style="width: 80%" />
			</div>

		</fieldset>
	</div>

</div>
{% endwith %}