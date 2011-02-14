%%% @author Andreas Stenius <andreas.stenius@astekk.se>
%%% @copyright (C) 2011, Andreas Stenius
%%% @doc
%%%
%%% @end
%%% Created :  3 Feb 2011 by Andreas Stenius <andreas.stenius@astekk.se>


-module(m_zmr).
-author("Andreas Stenius <andreas.stenius@astekk.se>").

-behaviour(gen_model).

-export([
	 m_find_value/3,
	 m_to_list/2,
	 m_value/2
	]).

-include_lib("zotonic.hrl").


m_find_value(repo, #m{value=undefined} = M, _Context) ->
    M#m{value=repo};
m_find_value(Id, #m{value=repo} = M, Context) ->
    case m_rsc:rid(Id, Context) of
	undefined ->
	    undefined;
	RId ->
	    case z_acl:rsc_visible(RId, Context) of
		true ->
		    M#m{value={repo, RId}};
		false ->
		    fun(is_a, C) ->
			    m_rsc:is_a(RId, C);
		       (_, _C) ->
			    undefined
		    end
	    end
    end;

m_find_value(log, #m{value={repo, Id}}=_M, Context) ->
%    M#m{value={repo_log, get_repo_log(Id, Context)}};
    get_repo_log(Id, Context);

m_find_value(exist, #m{value={repo, Id}}, Context) ->
    filelib:is_dir(mod_zmr:get_repo_path(Id, Context)).

%m_find_value(Key, #m{value={repo_log_entry, Entry}}, _Context) ->
    %?PRINT(Key),
    %?PRINT(Entry),
%    proplists:get_value(Key, Entry).


%m_to_list(#m{value={repo_log, Log}}=M, _Context) ->
%    [M#m{value={repo_log_entry, Entry}} || Entry <- Log];
%m_to_list(#m{value={repo_log_entry, Entry}}, _Context) ->
%    Entry;

m_to_list(_, _) ->
    undefined.


m_value(#m{value={repo, Id}}, _Context) ->
    Id.


get_repo_log(Id, Context) -> 
    Repo = mod_zmr:get_repo_path(Id, Context),
    ToolId = mod_zmr:get_scm_tool(Id, Context),
    {ok, Split} = re:compile(mod_zmr:get_scm_log_split(ToolId, Context)),
    {ok, Parse} = re:compile(mod_zmr:get_scm_log_parse(ToolId, Context)),
    Cmd = lists:flatten(["cd ", Repo, " && ", mod_zmr:get_scm_cmd(ToolId, [log], Context)]),
    Output = os:cmd(Cmd),
    %?PRINT(Output),
    RawLog = [re:run(Entry, Parse, [global, {capture, [key, value], list}])
	   || Entry <- re:split(Output, Split, [trim, {return, list}])],
    rawlog_to_proplists(RawLog).


rawlog_to_proplists([{match, Matches}|Rest]) -> [rawlog_to_proplists(Matches) | rawlog_to_proplists(Rest)];
rawlog_to_proplists([nomatch|Rest]) -> rawlog_to_proplists(Rest);
rawlog_to_proplists([[Key, Value]|MatchList]) -> [{fix_key(Key), Value} | rawlog_to_proplists(MatchList)];
rawlog_to_proplists(_) -> [].

fix_key(changeset) -> id;
fix_key(commit) -> id;
fix_key([]) -> fix_key(summary);
fix_key(Key) when is_list(Key) -> fix_key(z_convert:to_atom(string:to_lower(Key)));
fix_key(Key) when is_atom(Key) -> Key;
fix_key(Key) -> fix_key(z_convert:to_atom(Key)).
