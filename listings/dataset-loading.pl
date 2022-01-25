% schema declaration
attribute(0, sepal_length, real).
attribute(1, sepal_width, real).
attribute(2, petal_length, real).
attribute(3, petal_width, real).
attribute(4, species, categorical([setosa, versicolor, virginica])).
schema_target([species]).
schema_name(iris).

% reading schema from theory
iris_schema(S) :- theory_to_schema(S).

% dataset loading              
iris_dataset(D) :- read_dataset('/path/to/iris.csv', csv, D).