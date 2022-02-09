iris(SL, SW, PL, PW, setosa) :- PW =< 0.78.
iris(SL, SW, PL, PW, versicolor) :-
    PL >= 2.86, PL < 4.91.
iris(SL, SW, PL, PW, virginica).
