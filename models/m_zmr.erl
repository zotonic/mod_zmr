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
    end.

%m_find_value(_, _, _) -> undefined.

m_to_list(_, _) ->
    undefined.

m_value(_, _) ->
    undefined.




