iris(SepalLength, SepalWidth, PetalLength, PetalWidth, setosa) :- PetalWidth =< 0.78.
iris(SepalLength, SepalWidth, PetalLength, PetalWidth, versicolor) :- 
    PetalLength >= 2.86, PetalLength < 4.91.
iris(SepalLength, SepalWidth, PetalLength, PetalWidth, virginica).