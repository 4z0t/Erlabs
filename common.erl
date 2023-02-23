-module(common).

-export([filter/2, pow/2, enumerate/1, any/2, droplast/1, partition/2, last/1, seq/2]).

filter_(true, E) -> [E];
filter_(false, _) -> [].

filter(_, []) -> [];
filter(Pred, [H | T]) -> filter_(Pred(H), H) ++ filter(Pred, T).

pow(V, 0) -> 1;
pow(V, P) -> V * pow(V, P - 1).

map(F, []) -> [];
map(F, [H, T]) -> [F(H)] ++ map(F, T).

enumerate_([], _) -> [];
enumerate_([H | T], I) -> [{I, H}] ++ enumerate_(T, I + 1).
enumerate(L) -> enumerate_(L, 1).

append([]) -> [];
append([H | T]) -> H ++ append(T).

any(Pred, List) -> length(filter(Pred, List)) > 0.

droplast([E]) -> [];
droplast([H | T]) -> [H] ++ droplast(T).

partition(Pred, L) -> {filter(Pred, L), filter(fun(X) -> not Pred(X) end, L)}.

seq(S, E) when S > E -> [];
seq(S, E) -> [S] ++ seq(S + 1, E).

last([H]) -> H;
last([H | T]) -> last(T).
