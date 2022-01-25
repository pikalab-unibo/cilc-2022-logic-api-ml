% neural network declaration
multi_layer_perceptron(Nin, Nhidden, Nout, NN) :- 
    input_layer(Nin, IL),
    hidden_layer(IL, Nhidden, H), 
    output_layer(H, Nout, softmax, O),
    neural_network(O, NN).

hidden_layer(L, [], L).
hidden_layer(L, [N | M], H) :-
    dense_layer(L, N, relu, L1),
    hidden_layer(L1, M, H).