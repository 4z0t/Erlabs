-module(lab3).

-export([
    dict_insert/3,
    dict_find/2,
    dict_remove/2,
    dict_values/1,
    dict_keys/1,
    dict2_insert/3,
    dict2_find/2,
    dict2_remove/2,
    dict2_values/1,
    dict2_keys/1,
    flatten/1
]).

dict_remove(D, K) -> lists:filter(fun({X, _}) -> X =/= K end, D).
dict_insert(D, K, V) -> dict_remove(D, K) ++ [{K, V}].
dict_find(D, K) -> lists:nth(1, lists:filter(fun({X, _}) -> X =:= K end, D)).
dict_values(D) -> lists:map(fun({_, V}) -> V end, D).
dict_keys(D) -> lists:map(fun({K, _}) -> K end, D).

%????
dict2_remove(D, K) -> D.
dict2_insert(D, K, V) -> D#{K := V}.
dict2_find(D, K) -> D.
dict2_values(D) -> D.
dict2_keys(D) -> D.

% {V, R, L}
flatten({V}) -> [V];
flatten({V, R, L}) -> flatten(R) ++ [V] ++ flatten(L).
