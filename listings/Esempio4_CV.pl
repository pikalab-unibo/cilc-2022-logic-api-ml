/* calcolo media valori lista*/
list_average(List, Avg):-  sum_list(List, N), 
                           length_list(List, Sum),
                           Avg is Sum / N.

/* addestramento e validazione rispetto ad una delle K parti */
validate(N, D, S, Params, K, Acc_val):- fold(D, K, TrainSet, ValSet),
                                        train(N, TrainSet, S, Params, N_trained),
                                        accuracy(N_trained, ValSet, S, Acc_val).
/* convalida incrociata */
cross_val(N, D, S, P, K, Acc):- findall(Acc, validate(N, D, S, P, K, Acc),L),
                                list_average(L,Acc).


train_validate(N, D, S, Acc, Params):-  random_split(D,0.8,Train,Val), 
                                        hyperparams(Params),
                                        cross_val(N, Val, S, Params, 10, Acc).