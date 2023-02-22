-module(lab2).

-import(lists, [min/1]).

-export([
    list_lenghts/1,
    min_value/2,
    group_by/2,
    prev_and_next/1,
    dropfirst/1,
    for/4,
    conditional_range/3,
    sort_by/2
]).

length_or_neg(E) when is_list(E) -> length(E);
length_or_neg(_) -> -1.

list_lenghts(L) -> lists:filter(fun(N) -> N >= 0 end, lists:map(fun length_or_neg/1, L)).

all(Pred, List) -> 0.

min_value(F, N) -> min(lists:map(F, lists:seq(1, N))).

dropfirst([]) -> [];
dropfirst([_ | T]) -> T.

prev_and_next(L) when length(L) == 1 -> [{lists:nth(1, L), lists:nth(1, L)}];
prev_and_next(L) -> lists:zipwith(fun(X, Y) -> {X, Y} end, lists:droplast(L), dropfirst(L)).

unpack_2_tuple({X, Y}) -> [X, Y].

to_normal_list(L) when length(L) == 0 -> [];
to_normal_list(L) ->
    lists:map(fun({X, _}) -> X end, lists:droplast(L)) ++ unpack_2_tuple(lists:last(L)).

splitwhen(_, L) when length(L) == 0 -> [];
splitwhen(Pred, L) -> [lists:takewhile(Pred, L)] ++ splitwhen(Pred, lists:dropwhile(Pred, L)).

first_tuple({X, _}) -> X.
second_tuple({_, X}) -> X.

merge_split({L1, L2}, Ids) -> split_by(L1, Ids) ++ [L2].

split_by(L, Ids) when length(Ids) == 0 -> [L];
split_by(L, Ids) -> merge_split(lists:split(lists:last(Ids), L), lists:droplast(Ids)).

group_by(Pred, L) ->
    split_by(
        L,
        lists:map(
            fun({I, R}) -> I end,
            lists:filter(
                fun({I, R}) -> not R end,
                lists:enumerate(lists:map(fun({X, Y}) -> Pred(X, Y) end, prev_and_next(L)))
            )
        )
    ).

do_conditional_step(I, Cond, Step, false) -> [];
do_conditional_step(I, Cond, Step, true) -> [I] ++ conditional_range(Step(I), Cond, Step).

conditional_range(Init, Cond, Step) ->
    do_conditional_step(Init, Cond, Step, Cond(Init)).

for(Init, Cond, Step, Body) -> lists:foreach(Body, conditional_range(Init, Cond, Step)).

compare(E1, E2, true) -> [E1, E2];
compare(E1, E2, false) -> [E2, E1].

do_sort([E1, E2], Comparator) -> compare(E1, E2, Comparator(E1, E2)).

sort_by(_, L) when length(L) < 2 -> L;
sort_by(Comparator, L) when length(L) == 2 -> do_sort(L, Comparator);
sort_by(Comparator, L) ->
    {L1, L2} = lists:partition(fun(X) -> Comparator(X, lists:last(L)) end, lists:droplast(L)),
    sort_by(Comparator, L1) ++ [lists:last(L)] ++ sort_by(Comparator, L2).
