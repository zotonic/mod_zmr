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
                        <div class="pull-left">{% menu id=id menu_id='main_menu' %} </div>

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
