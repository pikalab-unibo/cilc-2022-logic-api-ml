/* attributes definition here */

% dataset definition
iris(5.1, 3.2, 1.4, 0.2, setosa).
iris(4.9, 3, 1.7, 1.2, versicolor).
iris(5.9, 3.4, 1.1, 0.9, virginica).
/*... other entries here...*/

% reading schema from theory
iris_schema(S) :- theory_to_schema(S).

% reading dataset from theory            
iris_dataset(D) :- 
    iris_schema(S), theory_to_dataset(S, D).