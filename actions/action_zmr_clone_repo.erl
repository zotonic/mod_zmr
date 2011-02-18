%%% @author Andreas Stenius <andreas.stenius@astekk.se>
%%% @copyright (C) 2011, Andreas Stenius
%%% @doc
%%%
%%% @end
%%% Created :  5 Feb 2011 by Andreas Stenius <andreas.stenius@astekk.se>

%% Copyright 2011 Andreas Stenius
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

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
    Source = mod_zmr:get_repo_url(RepoId, Context),
    Target = mod_zmr:get_repo_path(RepoId, Context),
    ToolId = mod_zmr:get_scm_tool(RepoId, Context),
    Cmd = mod_zmr:get_scm_cmd(ToolId,
			      [clone, 
			       {"\\$source", Source}, 
			       {"\\$target", Target}
			      ],
			      Context),
    Context1 = update_progress(TargetId, [{message, "Cloning repository..."}], Context),
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
