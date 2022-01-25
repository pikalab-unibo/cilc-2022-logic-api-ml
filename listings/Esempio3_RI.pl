/* rete neurale */
/* ?:- registered(network,N), registered(tp,T), enhance(T, N) */ 
 iris(SL, SW, PL, PW, SP):-  X = iris(SL, SW, PL, PW, _),
                              Cat = [setosa, versicolor, virginica],
                              transform(X , 'transform_process', V), 
                              classify(V, 'network', Cat, Y), 
                              SP = species(Y). 

/* classificatore logico */
iris(sw(SL) , SW, PL  , PW, SP):- SL < 4, !, 
                                  SP = species(setosa).
iris(SL , sw(SW), PL  , PW, SP):- SW < 3, !,
                                   SP = species(versicolor).
iris(SL , SW , PL , PW, SP):- SP = species(virginica).