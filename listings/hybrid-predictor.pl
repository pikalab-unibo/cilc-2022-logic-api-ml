/* assumption: */
:- iris_dataset(D), iris_schema(S), (*@\label{line:hybrid-predictor-setup}@*)
    model_selection(D, S, N, T, _), !,
    assert(iris_nn(N, T)).

/* hybrid iris classifier */ 
iris(SL, SW, PL, PW, Species) :-
   X = [SL, SW, PL, PW],
   iris_nn(Network, Transformation),
   transform(X , Transformation, ActualX), 
   predict(Network, X, Y),
   Classes = [setosa, versicolor, virginica],
   classify(Y, argmax, Classes, Species).
