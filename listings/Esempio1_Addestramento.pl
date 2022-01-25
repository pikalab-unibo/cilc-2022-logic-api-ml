/* definizione iperparametri */
iterations(30).
iterations(50).
batch_size(32).
batch_size(16).
lr(0.01).
lr(0.1).
threshold(0.90).

/* allenamento e test */
hyperparams([iterations(X), lr(Y), batch_size(Z)]) :- iterations(X), 
                                                      lr(Y), 
                                                      batch_size(Z).

train_validate(N, D, S, Acc, Params) :-  random_split(D,0.8,Train,Val), 
                                         hyperparams(Params), 
                                         train(N, Train, S, Params, N2),
                                         accuracy(N2, Val, S, Acc).

/* applicazione */
try_hypers(Acc, Params):- dataset(D), 
                         build_network(N),
                         schema_from_theory(S), 
                         transform_process(S,D, T),  
                         process_data(T,D, F, O),
                         random_split(O,0.9,Train,Test),
                         train_validate(N, Train, F, Acc, Params).

/* applicazione */
application(Tp, Network, Acc_Test):- dataset(D), 
                                     build_network(N), 
                                     schema_from_theory(S), 
                                     transform_process(S,D, T), 
                                     process_data(T,D, F, O), 
                                     random_split(O,0.9,Train,Test), 
                                     train_validate(N, Train, Acc_Val, Params), 
                                     threshold(X), Acc_Val > X,!, 
                                     train(N, Train, F, Params, N2), 
                                     accuracy(N2, Test, F, Acc_Test),
                                     register(Tp,T), register(Network, Nw).