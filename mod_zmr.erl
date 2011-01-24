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

-mod_title("ZMR Server").
-mod_description("A Zotonic module repository server.").
-mod_prio(800).

%% interface functions
-export([
	 init/1
	]).

-include("zotonic.hrl").


init(Context) ->
    z_datamodel:manage(?MODULE, datamodel(), Context),
    ok.

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
	[{zmr_repository, zmr_scm_tool}]}
      ]
     },

     {resources,
      [
       {zmr_scm_hg,
	zmr_scm_tool,
	[
	 {title, <<"Mercurial (hg)">>},
	 {zmr_command, <<"hg">>},
	 {zmr_arg_checkout, <<"clone $repo $dest">>},
	 {zmr_arg_history, <<"log">>}
	]},

       {zmr_scm_git,
	zmr_scm_tool,
	[
	 {title, <<"Git">>},
	 {zmr_command, <<"git">>},
	 {zmr_arg_checkout, <<"clone $repo $dest">>},
	 {zmr_arg_history, <<"log">>}
	]},
	
       {zmr_repo,
	zmr_repository,
	[
	 {title, <<"ZMR Repository">>},
	 {summary, <<"The repository for ZMR itself.">>},
	 {body, <<"Zotonic Modules Repository (zmr) is a server for hosting releases of zotonic modules.">>},
	 {zmr_repository_path, <<"https://bitbucket.astekk.se/zmr">>}
	]}
      ]},

     {edges,
      [
       {zmr_repo, zmr_scm, zmr_scm_hg}
      ]}

    ].
