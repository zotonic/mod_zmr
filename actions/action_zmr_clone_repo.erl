%%% @author Andreas Stenius <andreas.stenius@astekk.se>
%%% @copyright (C) 2011, Andreas Stenius
%%% @doc
%%%
%%% @end
%%% Created :  5 Feb 2011 by Andreas Stenius <andreas.stenius@astekk.se>

-module(action_zmr_clone_repo).
-author("Andreas Stenius <andreas.stenius@astekk.se>").

-export([
	 render_action/4,
	 event/2,
	 clone_repo/3
	]).

-include_lib("zotonic.hrl").

render_action(TriggerId, TargetId, Args, Context) ->
    RepoId = proplists:get_value(id, Args),
    {PostbackMsgJS, _PickledPostback} = z_render:make_postback({clone_repo, RepoId}, 
							       click, 
							       TriggerId, 
							       TargetId,
							       ?MODULE,
							       Context),
    {PostbackMsgJS, Context}.

event({postback, {clone_repo, RepoId}, _TriggerId, TargetId}, Context) ->
    z_session_page:spawn_link(?MODULE, clone_repo, [TargetId, RepoId, Context], Context),
    Context.


clone_repo(TargetId, RepoId, Context) ->
    Context1 = update_progress(TargetId, [{message, "Cloning repository..."}], Context),
    Source = mod_zmr:repo_source(RepoId, Context),
    Target = mod_zmr:repo_path(RepoId, Context),
    Cmd = mod_zmr:get_cmd(RepoId, Context, 
			  [clone, 
			   {"\\$source", Source}, 
			   {"\\$target", Target}
			  ]),
    Result = os:cmd(Cmd),
    ?PRINT(Result),
    Message = lists:flatten(["Clone Repository Done. <br /><pre>", Result, "</pre>"]),
    update_progress(TargetId, [{message, Message}, {done, true}], Context1).



update_progress(TargetId, Vars, Context) ->
    Context1 = z_render:update(TargetId, 
			       #render{ template="_zmr_progress.tpl", 
					vars=Vars
				      }, 
			       Context
			      ),
    z_session_page:add_script(Context1).
