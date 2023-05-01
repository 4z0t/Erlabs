test:-
	test_1.

test_1:-
    [1,2,3]==[1,2,3],
	list([1,2]).


list([]).
list([_|T]) :- list(T).

duplicated([],[]).
duplicated([_|_],[]):-false.
duplicated([],[_|_]):-false.
duplicated([H11|[H12|T1]], [H2|T2]):-
    H11==H2,H12==H2,
    duplicated(T1,T2).
    
stutter(L1,L2) :- duplicated(L2,L1).

remove_duplicates(L1, L2):-
    list(L1), list(L2).

append([], List, List).
append([Head|Tail], List, [Head|Rest]) :-
    append(Tail, List, Rest).


my_flatten_list([], [H|T], L2):-
    my_flatten_(H, T, L2).
my_flatten_list([H], Tail, L2):-
    my_flatten_(H, Tail, L2).
my_flatten_list([H|T], Tail, L2):-
    my_flatten_(H, [T|Tail], L2).


my_flatten_(Head, Tail, [H2|T2]):-
    (   
   		list(Head),
        my_flatten_list(Head, Tail, [H2|T2])
    )
    ;   
    (   
    	Head==H2,
        my_flatten_(Tail, T2)
    ).
    
my_flatten_([],[]):-true.
my_flatten_(L1, L2):-
 	my_flatten_(L1,[],L2).
    
my_flatten(LN, L):- my_flatten_(LN,L).