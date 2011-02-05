%% @author Andreas Stenius <andreas.stenius@astekk.se>
%% @copyright 2011 Andreas Stenius
%% @date 2011-01-20
%% @doc zmr admin module (a zotonic module repository server)

%% Copyright 2009 Andreas Stenius
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

-module(mod_zmr).
-author("Andreas Stenius <andreas.stenius@astekk.se>").
%-behaviour(gen_server).

-mod_title("ZMR Server").
-mod_description("A Zotonic module repository server.").
-mod_prio(800).

%% interface functions
-export([
	 init/1,
	 repo_path/2
%	 handle_call/3,
%	 handle_cast/2,
%	 handle_info/2,
%	 terminate/2,
%	 code_change/3,
%	 start_link/1
	]).

-include_lib("zotonic.hrl").
%-record(state, {context}).

%start_link(Args) when is_list(Args) ->
%    gen_server:start_link(?MODULE, Args, []).

%init(Args) ->
init(Context) ->
%    process_flag(trap_exit, true),
%    {context, Context} = proplists:lookup(context, Args),
    z_datamodel:manage(?MODULE, datamodel(), Context),
    z_path:files_subdir_ensure("zmr_repos", Context),
%    {ok, #state{context = z_context:new(Context)}}.
    ok.


repo_path(RepoId, Context) ->
    z_path:files_subdir(filename:join("zmr_repos", z_convert:to_list(RepoId)), Context).


datamodel() ->
    [

     {categories,
      [
       {zmr_repository,
	location,
	[{title, <<"Repository">>}]},

       {zmr_scm_tool,
	other,
	[{title, <<"SCM Tool">>}]},

       {zmr_release,
	other,
	[{title, <<"Release">>}]}
      ]
     },

     {predicates,
      [
       {zmr_scm,
	[{title, <<"Source Code Management">>}],
	[{zmr_repository, zmr_scm_tool}]},
       
       %% perhaps use the existing 'relation' predicate for this instead... ?
       {zmr_module_release,
	[{title, <<"Release for">>}],
	[{zmr_release, zmr_repository}]}
      ]
     },

     {resources,
      [
       {zmr_scm_hg,
	zmr_scm_tool,
	[
	 {title, <<"Mercurial (hg)">>},
	 {zmr_command, <<"hg">>},
	 {zmr_arg_checkout, <<"clone --noupdate $source $target">>},
	 {zmr_arg_history, <<"log">>}
	]},

       {zmr_scm_git,
	zmr_scm_tool,
	[
	 {title, <<"Git">>},
	 {zmr_command, <<"git">>},
	 {zmr_arg_checkout, <<"clone $source $target">>},
	 {zmr_arg_history, <<"log">>}
	]},
	
       {zmr_repo,
	zmr_repository,
	[
	 {title, <<"ZMR Repository">>},
	 {summary, <<"The repository for ZMR itself.">>},
	 {body, <<"Zotonic Modules Repository (zmr) is a server for hosting releases of zotonic modules.">>},
	 {zmr_repository_path, <<"https://bitbucket.astekk.se/zmr">>}
	]},

       {zmr_default_release,
	zmr_release,
	[
	 {title, <<"Default ZMR release (head)">>},
	 {zmr_branch, <<"default">>}
	]}
      ]},

     {edges,
      [
       {zmr_repo, zmr_scm, zmr_scm_hg},
       {zmr_default_release, zmr_module_release, zmr_repo},

       %% using the existing 'relation' predicate
       {zmr_repo, relation, zmr_default_release},
       {zmr_default_release, relation, zmr_repo}
      ]}

    ].
