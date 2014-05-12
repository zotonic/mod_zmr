{% extends "page.tpl" %}

{% block content %}

        {% block page_header %}
	        <h1 class="page-header">{{ m.rsc[id].title }}</h1>
        {% endblock %}

        {% block page_summary %}
	        <p class="summary">
	                {{ m.rsc[id].summary }}
	        </p>
        {% endblock %}

        {% block page_body %}
                {{ m.rsc[id].body|show_media }}
        {% endblock %}

{% wire id="contact-form"
        type="submit"
        postback={contact email_template="email_contact.tpl"}
        delegate="mod_contact" %}
<form id="contact-form" method="post" action="postback" class="form-horizontal" role="form">
        <fieldset>
                <legend>{_ Tell us about your module _}</legend>
 	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">{_ Module name (mod_*) _}</label>
                <div class="col-sm-10">
    	                <input type="text" name="title" id="title" />
    	                {% validate id="title" type={presence} %}
                </div>
   	</div>

 	<div class="form-group">
		<label for="name" class="col-sm-2 control-label">{_ Author's name _}</label>
                <div class="col-sm-10">
    	                <input type="text" name="name" id="name" />
    	                {% validate id="name" type={presence} %}
                </div>
   	</div>

	<div class="form-group">
		<label for="email" class="col-sm-2 control-label">{_ E-mail _}</label>
                <div class="col-sm-10">
    	                <input type="email" name="mail" id="mail" />
    	                {% validate id="mail" type={email} type={presence} %}
	        </div>
        </div>

 	<div class="form-group">
		<label for="repository" class="col-sm-2 control-label">{_ Git/Mercurial clone URL _}</label>
                <div class="col-sm-10">
    	                <input type="text" name="repository" id="repository" style="width: 383px" />
    	                {% validate id="repository" type={presence} %}
   	        </div>
        </div>

	<div class="form-group">
	        <label for="message">{_ Module summary _}</label>
	        <textarea name="message" id="message" class="form-control" cols="30" rows="8"></textarea>
    	        {% validate id="message" type={presence} %}
	</div>

        <button type="submit" class="btn btn-primary btn-sm">{_ Send _}</button>
    </fieldset>
</form>

<div id="contact-form-sent" style="display: none">
    <h2>{_ Thank you! _}</h2>
    <p>{_ Your module has been submitted! We’ll get in touch soon. _}</p>
</div>

{% endblock %}
