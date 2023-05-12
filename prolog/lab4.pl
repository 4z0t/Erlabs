%1

my_nonvar(X) :- var(X),fail; !.

%2

my_ground(Term) :-
  nonvar(Term),
  Term =.. [_|Args],
  check_ground(Args).

check_ground([]).
check_ground([Arg|Args]) :-
  nonvar(Arg),
  check_ground(Args).

%green

check_ground([]).
check_ground([Arg|Args]) :-
  ( nonvar(Arg)
  -> check_ground(Args)
  ; !, fail
  ).

%3

list_add(List, X, Result) :-
( member(X, List)
-> Result = List
; append(List, [X], Result)
).


%4

