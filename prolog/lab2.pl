test:-
	test_1.

test_1:-
    [1,2,3]==[1,2,3],
	list([1,2]).

% 2
list([]).
list([_|T]) :- list(T).

duplicated([],[]).
duplicated([_|_],[]):-false.
duplicated([],[_|_]):-false.
duplicated([H|[H|T1]], [H|T2]):-
    duplicated(T1,T2).
    
stutter(L1,L2) :- duplicated(L2,L1).





% 3
remove_all(_, [], []).
remove_all(X, [X|T], T1) :-
    remove_all(X, T, T1).
remove_all(X, [H|T], [H|T1]) :-
    X \= H,
    remove_all(X, T, T1).


remove_duplicates([], []).
remove_duplicates([H|T], [H|T1]) :-
  remove_all(H, T, T2),
  remove_duplicates(T2, T1).
remove_duplicates([H|T], [H|T1]) :-
  not(member(H, T)),
  remove_duplicates(T, T1).



% 4

my_flatten([], []).
my_flatten([H|T], FlatList) :-
  is_list(H),
  my_flatten(H, HFlat),
  my_flatten(T, TFlat),
  append(HFlat, TFlat, FlatList).
my_flatten([H|T], [H|TFlat]) :-
  not(is_list(H)),
  my_flatten(T, TFlat).

% 5

add_element_to_lists(_, [], []).
add_element_to_lists(X, [H|T], [[X|H]|T1]) :-
  is_list(H),
  add_element_to_lists(X, T, T1).
add_element_to_lists(X, [H|T], [H|T1]) :-
  not(is_list(H)),
  add_element_to_lists(X, T, T1).

gray([], []).
gray([_], [[0],[1]]).
gray([_|T], Code):-
    gray(T, C),
	  add_element_to_lists(0, C, Code0),
    add_element_to_lists(1, C, Code1),
    append(Code0, Code1, Code).

