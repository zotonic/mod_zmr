%% @author Arjan Scherpenisse <arjan@scherpenisse.net>
%% @copyright 2009 Arjan Scherpenisse
%% @date 2011-02-15
%% @doc List all zmr repositories

%% Copyright 2009 Arjan Scherpenisse
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

-module(service_zmr_repositories).
-author("Arjan Scherpenisse <arjan@scherpenisse.net>").

-svc_title("List Zotonic Module Repositories.").
-svc_needauth(false).

-export([process_get/2]).

-include_lib("zotonic.hrl").

process_get(_ReqData, Context) ->
    Query = z_context:get_q(q,Context),
    Result = case Query =/= undefined of
                 true -> search(Query,Context);
                 false -> search(all,Context)
             end,
    Ids = Result#search_result.result,
    z_convert:to_json([repo_info(Id, Context) || Id <- Ids]).

search(all,Context)->
    z_search:search({'query', [{cat, zmr_repository}]}, Context);
search(Query,Context)->
    z_search:search({'query',[{cat,zmr_repository},{text, Query}]}, Context).

repo_info(Id, Context) ->
    ToolId = mod_zmr:get_scm_tool(Id, Context),
    [
     {title, z_trans:lookup_fallback(m_rsc:p(Id, title, Context), Context)},
     {description, z_trans:lookup_fallback(m_rsc:p(Id, summary, Context), Context)},
     {repository, m_rsc:p(Id, zmr_repository_url, Context)},
     {scm, m_rsc:p(ToolId, zmr_command, Context)}
    ].
