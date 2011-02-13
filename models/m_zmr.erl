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

m_find_value(log, #m{value={repo, Id}}=M, Context) ->
    M#m{value={repo_log, get_repo_log(Id, Context)}};

m_find_value(exist, #m{value={repo, Id}}, Context) ->
    filelib:is_dir(mod_zmr:repo_path(Id, Context));

m_find_value(Key, #m{value={repo_log_entry, Entry}}, _Context) ->
    %?PRINT(Key),
    %?PRINT(Entry),
    proplists:get_value(Key, Entry).


m_to_list(#m{value={repo_log, Log}}=M, _Context) ->
    [M#m{value={repo_log_entry, Entry}} || Entry <- Log];
m_to_list(#m{value={repo_log_entry, Entry}}, _Context) ->
    Entry;

m_to_list(_, _) ->
    undefined.


m_value(#m{value={repo, Id}}, _Context) ->
    Id.


get_repo_log(Id, Context) -> 
    Repo = mod_zmr:repo_path(Id, Context),
    Cmd = lists:flatten(["cd ", Repo, " && ", mod_zmr:get_cmd(Id, Context, [log])]),
    Output = os:cmd(Cmd),
    %?PRINT(Output),
    {match, Match} = re:run(Output, "(?m)^(\\w+):\\s*(.*)$|^$", [global, {capture, all_but_first, list}]),
    match_to_proplist(Match).

%%
% Matches are reversed after this conversion. Use lists:reverse to restore, if needed

match_to_proplist([]) -> [];
match_to_proplist(Match) -> match_to_proplist(Match, [[]]).

%keeps props in order, but less efficient
%match_to_proplist([[Key, Value]|MatchList], [H|Acc]) -> match_to_proplist(MatchList, [H++[{Key, Value}]|Acc]);
% props in reverse order
match_to_proplist([[Key, Value]|MatchList], [H|Acc]) -> 
    match_to_proplist(MatchList, 
		      [
		       [{z_convert:to_atom(string:to_lower(Key)), Value}|H]
		       |Acc
		      ]
		     );

match_to_proplist([[]], Acc) -> Acc;

% could call lists:reverse here to restore prop order, if needed
match_to_proplist([[]|MatchList], Acc) -> match_to_proplist(MatchList, [[]|Acc]);

match_to_proplist([], Acc) -> Acc.
    

