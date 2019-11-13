-module(prop_base).

-include_lib("proper/include/proper.hrl").

prop_test() ->
    ?FORALL(    
        Type,
        mytype(),
        begin
            boolean(Type)
        end
    ).

prop_key_sort() ->
    ?FORALL(
        List,
        list({atom(), integer()}),
        begin
            Keys = [K||{K,_V} <- lists:keysort(1, List)],
            Values = [V||{_K,V} <- lists:keysort(2, List)],
            is_sorted(Keys) andalso is_sorted(Values)
        end
    ).

boolean(_) -> true.

mytype() -> term().

prop_sort() ->
    ?FORALL(
        List, list(integer()), is_sorted(lists:sort(List))
    ).

is_sorted([Head, Next | Tail]) when Head =< Next ->
    is_sorted([Next|Tail]);
is_sorted([Head, Next | _Tail]) when Head > Next ->
    false;
is_sorted(_) ->
    true.


prop_min_element_modeling() ->
    ?FORALL(
        List,
        non_empty(list(integer())),
        hd(lists:sort(List)) =:= thinking:min_element(List)
    ).

prop_min_element_gereralizing() ->
    ?FORALL(
        {List, KnownMin},
        {list(integer(100, inf)), integer(inf, 99)},
        begin
            NewList = lists:append([KnownMin], List),
            KnownMin =:= thinking:min_element(NewList)
        end
    ).

prop_min_element_in_list() ->
    ?FORALL(
        List,
        non_empty(list(integer())),
        begin
            Min = thinking:min_element(List),
            lists:member(Min, List) =:= true
        end
    ).

prop_min_element_single() ->
    ?FORALL(
        List,
        resize(1, non_empty(list(integer()))),
        begin
            [Min] = List,
            Min =:= thinking:min_element(List)
        end
    ).

prop_symmetric() ->
    ?FORALL(
        Data,
        oneof([integer(), atom(), string(), {atom(), float()}]),
        begin
            Data =:= thinking:decode(thinking:encode(Data))
        end
    ).