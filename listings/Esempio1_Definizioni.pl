/* definizione schema */
attribute(0, sl, type(double)).
attribute(1, sw, type(double)).
attribute(2, pl, type(double)).
attribute(3, pw, type(double)).
attribute(4, species, type(categorical([setosa, versicolor, virginica]))).
schema_target(species).
schema_name(iris).

/* definizione dataset*/                 
dataset(D):- load_dataset_from_csv('resources/iris.csv', D).

/* definizione rete neurale */
build_network(N):- input_layer(4, I),
                  dense_layer(I, 40, activation(relu), D), 
                  dense_layer(D, 20, activation(relu), X), 
                  output_layer(X, 3, activation(softmax), loss(cross_entropy), O),
                  network(O, N).

/* definizione processo di trasformazione */
transform_process(S, D, T):- transform_process(S, T1), 
                              normalize(T1, [pw, pl, sw, sl], T2),
                              one_hot_encode(T2, [species], T3), 
                              fit(T3, D, T).