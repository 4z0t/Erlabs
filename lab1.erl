-module(lab1).

-export([distance/2, insert/2, drop_every/2, rle_decode/1, diagonal/1, intersect/2, is_date/3]).

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

to_01(V) when V -> 1;
to_01(_) -> 0.

is_ves(Y) -> to_01(((Y rem 4 == 0) and (Y rem 100 /= 0)) or (Y rem 400 == 0)).

days_count(M) when ((M < 8) and (M rem 2 == 1)) or ((M >= 8) and (M rem 2 == 0)) -> 31;
days_count(_) -> 30.

plus_1_rem_7(V) -> (V rem 7) + 1.

is_date(1, 1, 1970) -> 4;
is_date(D, M, Y) when (M == 3) and (D == 1) -> plus_1_rem_7(is_date(28 + is_ves(Y), M - 1, Y));
is_date(D, M, Y) when (M == 1) and (D == 1) -> plus_1_rem_7(is_date(31, 12, Y - 1));
is_date(D, M, Y) when D == 1 -> plus_1_rem_7(is_date(days_count(M - 1), M - 1, Y));
is_date(D, M, Y) -> plus_1_rem_7(is_date(D - 1, M, Y)).
