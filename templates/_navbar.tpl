<!-- Fixed navbar -->
<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
                <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="{% url home %}">{_ The Zotonic Module Repository _}</a>
                </div>
                <div class="collapse navbar-collapse">
                        <ul class="nav navbar-nav">
                                <li class="{% ifequal zotonic_dispatch 'home' %}active{% endifequal%}"><a href="{% url home %}">{_ Modules _}</a></li>
                                <li class="{% ifequal zotonic_dispatch 'howto' %}active{% endifequal%}"><a href="{% url howto %}">{_ Howto _}</a></li>
                                <li class="{% ifequal zotonic_dispatch 'submit' %}active{% endifequal%}"><a href="{% url submit %}">{_ Submit _}</a></li>
                                <li class="{% ifequal zotonic_dispatch 'zmr_categories' %}active{% endifequal%}"><a href="{% url zmr_categories %}">{_ Browse Categories _}</a></li>
                        </ul>
                        <form class="navbar-form navbar-right" role="search" action="{% url search %}" method="get">
                                <div class="form-group">
	                                <input type="hidden" name="qcat" value="{{ q.qcat|escape }}" />
		                        <input class="form-control" type="text" id="qs" name="qs" value="" placeholder="{_ Search _} {_ modules _}" />
                                        <input type="submit" class="btn btn-default btn-sm" id="search-button" alt="search" value="Go" />
                                </div>
                        </form>
                </div> <!--/.nav-collapse -->
        </div>
</div>
