{% extends "page.tpl" %}

{% block content %}

	<h1>{{ m.rsc[id].title }}</h1>

	<p class="summary">
	    {{ m.rsc[id].summary }}
	</p>

	{{ m.rsc[id].body|show_media }}

{% wire id="contact-form" 
        type="submit" 
        postback={contact email_template="email_contact.tpl"} 
        delegate="mod_contact" %}
<form id="contact-form" method="post" action="postback">

 	<div class="form-item">
		<label for="title">{_ Module name (mod_*) _}</label>
    	<input type="text" name="title" id="title" />
    	{% validate id="title" type={presence} %}
   	</div>

 	<div class="form-item">
		<label for="name">{_ Author's name _}</label>
    	<input type="text" name="name" id="name" />
    	{% validate id="name" type={presence} %}
   	</div>

	<div class="form-item">
		<label for="email">{_ E-mail _}</label>
    	<input type="text" name="mail" id="mail" />
    	{% validate id="mail" type={email} type={presence} %}
	</div>
	
 	<div class="form-item">
		<label for="repository">{_ Git/Mercurial clone URL _}</label>
    	<input type="text" name="repository" id="repository" style="width: 383px" />
    	{% validate id="repository" type={presence} %}
   	</div>

	<div class="form-item">
	    <label for="message">{_ Module summary _}</label>
	    <textarea name="message" id="message" cols="60" rows="8"></textarea>
    	{% validate id="message" type={presence} %}
	</div>

    <button type="submit">{_ Send _}</button>

</form>

<div id="contact-form-sent" style="display: none">
    <h2>{_ Thank you! _}</h2>
    <p>{_ Your module has been submitted! We’ll get in touch soon. _}</p>
</div>

{% endblock %}
