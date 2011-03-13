
{% with m.rsc[id] as r %}
<div class="item-wrapper">
<h3 class="above-item clearfix">
<span class="title">{_ ZMR Repository _}</span>
</h3>

<div class="item">
<fieldset class="admin-form">

<div class="form-item clearfix">
<label for="zmr_repository_url">{_ Repository URL _}</label>
<input id="zmr_repository_url" type="text" name="zmr_repository_url" value="{{ r.zmr_repository_url }}" style="width: 80%" />

<div id="repo_status">
{ % if m.zmr.repo[id].exist %} 
	Repository is cloned.
{ % else %}
	{ % button text="Clone repository" action={clone_repo id=id target="repo_status"} %}
{ % endif %}
</div>
</div>

</fieldset>
</div>

</div>
{% endwith %}