-module(lab3).

-import(lists, [min/1]).

-export([
    dict_insert/3,
    dict_find/2,
    dict_remove/2,
    dict_values/1,
    dict_keys/1
]).

dict_remove(D, K) -> lists:filter(fun({X, _}) -> X =/= K end, D).
dict_insert(D, K, V) -> dict_remove(D, K) ++ [{K, V}].
dict_find(D, K) -> lists:nth(1, lists:filter(fun({X, _}) -> X == K end, D)).
dict_values(D) -> lists:map(fun({_, V}) -> V end, D).
dict_keys(D) -> lists:map(fun({K, _}) -> K end, D).
