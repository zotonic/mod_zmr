<li {% ifequal comment.user_id creator_id %}class="comment-author"{% endifequal %} {% if hidden %}style="display: none"{% endif %} id="comment-{{ comment.id }}">
        <div class="row">
	<div class="col-sm-1">{% include "_comment_avatar.tpl" size=60 %}</div>
        <div class="col-sm-9">
	        <h3><a name="#comment-{{ comment.id }}"></a>{{ comment.name|default:m.rsc[comment.user_id].title }}</h3>
	        <p class="comment-meta">{_ Posted _} {{ comment.created|timesince }}.</p>
	        <p class="comment-body">{{ comment.message }}</p>
        </div>
</div>
</li>
