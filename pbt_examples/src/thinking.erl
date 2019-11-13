-module(thinking).

-export([min_element/1, encode/1, decode/1]).

-spec min_element([integer()]) -> integer().
min_element([Head | Tail]) ->
    min_element(Tail, Head).

min_element([], Min) ->
    Min;
min_element([Head | Tail], Min) when Head < Min ->
    min_element(Tail, Head);
min_element([Head | Tail], Min) when Head >= Min ->
    min_element(Tail, Min).

-spec encode(any()) -> binary().
encode(Term) ->
    term_to_binary(Term).

-spec decode(binary()) -> any().
decode(Binary) ->
    binary_to_term(Binary).


% min_element_test() ->
%     -23 =:= min_element([-23]),
%     1 =:= min_element([1,2,3]),
%     3 =:= min_element([5,4,3]).