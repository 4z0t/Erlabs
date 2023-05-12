%1

power(_,0,1).
power(X,N,R):-
    N>0,
    N1 is N-1,
    power(X,N1,R1),
    R is R1*X.

%2

poly(_,[],0).
poly(X,[A|T],R):-
    poly(X,T,R1),
    R is R1 * X + A.


%3


nnf(\+ Atom) :-
    atom(Atom);
    nnf(Atom).

nnf(A /\ B) :-
    nnf(A);
    nnf(B).
nnf(A \/ B) :-
    nnf(A);
    nnf(B).
nnf(A -> B) :-
    nnf(A);
    nnf(B).

nnf(_):-false.

%4


nnf(Formula) :-
    nnf(Formula, NNF),
    Formula = NNF.

nnf(not(Atom), not(Atom)) :- atomic(Atom).

nnf(not(and(A, B)), or(NnfA, NnfB)) :-
  nnf(not(A), NnfA),
  nnf(not(B), NnfB).

nnf(not(or(A, B)), and(NnfA, NnfB)) :-
  nnf(not(A), NnfA),
  nnf(not(B), NnfB).

nnf(not(implication(A, B)), and(NnfA, NnfNotB)) :-
  nnf(A, NnfA),
  nnf(not(B), NnfNotB).

% Отрицание перед переменной
nnf(Atom, Atom) :-
    atom(Atom).
nnf(\+(Atom), \+(Atom)) :-
    nnf(Atom, Atom).

% Де Морган для конъюнкции
nnf(\+ (A /\ B), NNF) :-
    nnf(\+ A, NNF1),
    nnf(\+ B, NNF2),
    nnf(NNF1 \/ NNF2, NNF).

nnf(A /\ B, NNF1 /\ NNF2) :-
    nnf(A, NNF1),
    nnf(B, NNF2).

% Де Морган для дизъюнкции
nnf(\+ (A \/ B), NNF) :-
    nnf(\+ A, NNF1),
    nnf(\+ B, NNF2),
    nnf(NNF1 /\ NNF2, NNF).

nnf(A \/ B, NNF1 \/ NNF2) :-
    nnf(A, NNF1),
    nnf(B, NNF2).

% Импликация
nnf(\+ (A -> B), NNF) :-
    nnf(A, NNF1),
    nnf(\+ B, NNF2),
    nnf(NNF1 /\ NNF2, NNF).
nnf(A -> B, NNF) :-
    nnf(\+ A, NNF1),
    nnf(B, NNF2),
    nnf(NNF1 \/ NNF2, NNF).

%5

% Проверка, является ли число простым
is_prime(2).
is_prime(3).
is_prime(P) :-
    P > 3,
    integer(P),
    P mod 2 =\= 0,
    \+ has_factor(P, 3).

% Проверка, есть ли у числа делители кроме 1 и самого числа
has_factor(N, Factor) :-
    N mod Factor =:= 0.
has_factor(N, Factor) :-
    Factor * Factor < N,
    NextFactor is Factor + 2,
    has_factor(N, NextFactor).

% Разбиение числа на простые множители
prime_factors(1, []).
prime_factors(N, [Factor|Factors]) :-
    N > 1,
    ( is_prime(N) ->
    Factor = N,
    Factors = []
    ; N mod 2 =:= 0 ->
    Factor = 2,
    N1 is N // 2,
    prime_factors(N1, Factors)
    ; next_prime_factor(N, 3, Factor),
    N1 is N // Factor,
    prime_factors(N1, Factors)
    ).

% Поиск следующего простого множителя
next_prime_factor(N, Factor, Factor) :-
    N mod Factor =:= 0,
    is_prime(Factor).
next_prime_factor(N, Factor, NextFactor) :-
    N mod Factor =\= 0,
    NextFactor is Factor + 2,
    next_prime_factor(N, NextFactor, _).