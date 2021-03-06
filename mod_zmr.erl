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

%% Will use the gen_server mode for this module to implement auto update and version creation in the background.
%-behaviour(gen_server).

-mod_title("ZMR Server").
-mod_description("A Zotonic module repository server.").
-mod_prio(100).

%% interface functions
-export([
	 init/1,
	 get_repo_url/2,
	 get_repo_path/2,
	 get_scm_cmd/3,
	 get_scm_tool/2,
	 get_scm_log_split/2,
	 get_scm_log_parse/2
	]).

%% gen_server interface functions
%-export([
%	 handle_call/3,
%	 handle_cast/2,
%	 handle_info/2,
%	 terminate/2,
%	 code_change/3,
%	 start_link/1
%	]).

-include_lib("zotonic.hrl").

%-record(state, {context}).

%start_link(Args) when is_list(Args) ->
%    gen_server:start_link(?MODULE, Args, []).

%init(Args) ->
%    process_flag(trap_exit, true),
%    {context, Context} = proplists:lookup(context, Args),
%    {ok, #state{context = z_context:new(Context)}}.


init(Context) ->
    z_datamodel:manage(?MODULE, datamodel(), Context),
    z_path:files_subdir_ensure("zmr_repos", Context),
    ok.


get_repo_url(RepoId, Context) ->
    m_rsc:p(RepoId, zmr_repository_url, Context).

get_repo_path(RepoId, Context) ->
    z_path:files_subdir(filename:join("zmr_repos", z_convert:to_list(RepoId)), Context).

get_scm_tool(RepoId, Context) ->
    m_edge:object(RepoId, zmr_repo_scm, 1, Context).

get_scm_log_split(ToolId, Context) ->
    z_html:unescape(m_rsc:p(ToolId, zmr_log_re_split, Context)).

get_scm_log_parse(ToolId, Context) ->
    z_html:unescape(m_rsc:p(ToolId, zmr_log_re_parse, Context)).

get_scm_cmd(ToolId, [Op|Vars], Context) when is_atom(Op) ->
    OpProp = case Op of
		 clone -> zmr_arg_clone;
		 log -> zmr_arg_log
	     end,
    OpVal = z_convert:to_list(m_rsc:p(ToolId, OpProp, Context)),
    Args = lists:foldl(fun({From, To}, Arg) -> re:replace(Arg, From, To, [{return, list}]) end,
		       OpVal,
		       Vars),
    Exe = z_convert:to_list(m_rsc:p(ToolId, zmr_command, Context)),
    lists:flatten([Exe, " ", Args]).



datamodel() ->
    [

     {categories,
      [
       {zmr_repository,
	location,
	[{title, <<"ZMR Repository">>}]},

       {zmr_scm_tool,
	other,
	[{title, <<"SCM Tool">>}]},

       {zmr_release,
	other,
	[{title, <<"ZMR Release">>}]}
      ]
     },

     {predicates,
      [
       {zmr_repo_scm,
	[{title, <<"Source Code Management">>}],
	[{zmr_repository, zmr_scm_tool}]},
       
       {zmr_repo_release,
	[{title, <<"Release">>}],
	[{zmr_repository, zmr_release}]}
      ]
     },

     {resources,
      [
       {zmr_scm_hg,
	zmr_scm_tool,
	[
	 {title, <<"Mercurial (hg)">>},
	 {zmr_command, <<"hg">>},
	 {zmr_arg_clone, <<"clone --noupdate $source $target">>},
	 {zmr_arg_log, <<"log">>},
	 {zmr_log_re_split, <<"\\R\\R">>},
	 {zmr_log_re_parse, <<"(?m)^(?<key>\\w+):\\s*(?<value>.*)$">>}
	]},

       {zmr_scm_git,
	zmr_scm_tool,
	[
	 {title, <<"Git (git)">>},
	 {zmr_command, <<"git">>},
	 {zmr_arg_clone, <<"clone --no-checkout $source $target">>},
	 {zmr_arg_log, <<"log">>},
	 {zmr_log_re_split, <<"\\R\\s+.*\\R\\R">>},
	 {zmr_log_re_parse, <<"(?m)^(?<key>\\w+)?:?\\s*(?<value>.*)$">>}
	]},
	
       {mod_zmr_repo,
	zmr_repository,
	[
	 {title, <<"mod_zmr">>},
	 {summary, <<"The Module for ZMR itself.">>},
	 {body, <<"Zotonic Modules Repository (zmr) is a server for hosting releases of zotonic modules.">>},
	 {zmr_repository_url, <<"https://bitbucket.astekk.se/zmr">>}
	]}
      ]},

     {edges,
      [
       {zmr_repo, zmr_repo_scm, zmr_scm_hg}
      ]}

    ].
