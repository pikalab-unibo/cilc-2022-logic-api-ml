% schema declaration
attribute(0, sepal_length, real).
attribute(1, sepal_width, real).
attribute(2, petal_length, real).
attribute(3, petal_width, real).
attribute(4, species, categorical([setosa, versicolor, virginica])).
schema_target([species]).
schema_name(iris).

% dataset definition
iris(5.1, 3.2, 1.4, 0.2, setosa).
iris(4.9, 3, 1.7, 1.2, versicolor).
iris(5.9, 3.4, 1.1, 0.9, virginica).
/*
 *    ... other entries here...
 */

% reading schema from theory
iris_schema(S) :- theory_to_schema(S).

% reading dataset from theory            
iris_dataset(D) :- 
    iris_schema(S),
    theory_to_dataset(S, D).