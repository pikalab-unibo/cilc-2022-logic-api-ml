/* definizione schema */
attribute(0, sl, type(double)).
attribute(1, sw, type(double)).
attribute(2, pl, type(double)).
attribute(3, pw, type(double)).
attribute(4, species, type(categorical([setosa, versicolor, virginica]))).
schema_target(species).
schema_name(iris).
threshold(0.90).

/* definizione iperparametri */
iterations(30).
iterations(50).
batch_size(32).
batch_size(16).
lr(0.01).
lr(0.1).
hyperparams([iterations(X), lr(Y), batch_size(Z)]) :- iterations(X), lr(Y), batch_size(Z).

/* definizione dataset*/                 
dataset( D):- load_dataset_from_csv('resources/iris.csv', D).

/* definizione rete neurale */
build_network(N) :- input_layer(4, I),dense_layer(I, 40, activation(relu), D), dense_layer(D, 20, activation(relu), X), output_layer(X, 3, activation(softmax), loss(cross_entropy), O), network(O, N).

/* definizione processo di trasformazione */
transform_process(S, D, T) :- transform_process(S, T1), normalize(T1, [pw, pl, sw, sl], T2), one_hot_encode(T2, [species], T3), fit(T3, D, T).

/*elaborazione dati */
process_data(T,D, F, O):-  transform_dataset(D, T, O), final_schema(T, F).

/* allenamento e test */


train_validate(N, D, S, N_trained, Acc, Params) :-  random_split(D,0.8,Train,Val), hyperparams(Params), train(N, Train, S, Params, N_trained),  accuracy(N_trained, Val, S, Acc).


/*schema addestramento*/                           
training_schema(Att, Name, Targets):-dataset(D), build_network(N), schema_from_theory(S), transform_process(S,D, T), final_schema(T, S2), schema_attributes(Att, Name, Targets, S2).

/* applicazione */
try_hypers(Acc, Params):- dataset(D), build_network(N), schema_from_theory(S), transform_process(S,D, T),  process_data(T,D, F, O), random_split(O,0.9,Train,Test), train_validate(N, Train, F, N_trained, Acc, Params).

application(T, N, Acc_Test):- dataset(D), build_network(N), schema_from_theory(S), transform_process(S,D, T), 
					process_data(T,D, F, O), random_split(O,0.9,Train,Test), train_validate(N, Train, F, N_trained, Acc_Val, Params), threshold(X), Acc_Val > X,!, 
					trainaccuracy(N, Train, F, Params, N_trained), accuracy(N_trained, Test, F, Acc_Test), register(Tp,T), register(Network, N_trained).
