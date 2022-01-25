/* assumption: */
:- iris_dataset(D), iris_schema(S), model_selection(D, S, N, T, _), !, assert(iris_nn(N, T)).

/* hybrid iris classifier */ 
iris(SepalLength, SepalWidth, PetalLength, PetalWidth, Species) :-  
   X = [SepalLength, SepalWidth, PetalLength, PetalWidth],
   iris_nn(Network, Transformation),
   transform(X , Transformation, ActualX), 
   predict(Network, X, Y),
   classify(Y, argmax, [setosa, versicolor, virginica], Species).