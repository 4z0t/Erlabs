-module(lab1).

-export([distance/2, insert/2, drop_every/2, rle_decode/1, diagonal/1, intersect/2]).

distance({X1, Y1}, {X2, Y2}) -> math:sqrt(math:pow(X1 - X2, 2) + math:pow(Y1 - Y2, 2)).

insert(List, X) -> lists:sort(List ++ [X]).

drop_every(List, N) ->
    lists:map(
        fun({_, V}) -> V end, lists:filter(fun({I, _}) -> I rem N /= 0 end, lists:enumerate(List))
    ).

decodeTupleElement({Elem, 1}) -> [Elem];
decodeTupleElement({Elem, N}) -> [Elem] ++ decodeTupleElement({Elem, N - 1}).

decodeElement(X) when is_tuple(X) -> decodeTupleElement(X);
decodeElement(X) -> [X].

rle_decode(EncodedList) ->
    lists:append(lists:map(fun decodeElement/1, EncodedList)).

diagonal(M) -> lists:map(fun({I, R}) -> lists:nth(I, R) end, lists:enumerate(M)).

contains(V, L) -> lists:any(fun(E) -> V =:= E end, L).

intersect(L1, L2) -> lists:filter(fun(V) -> contains(V, L1) end, L2).
