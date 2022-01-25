/* costruzione rete neurale */
build_network(N):- input_layer(4, I), 
                   add_layer(I,D), 
                   output_layer(D, 3, activation(softmax), loss(cross_entropy),O),
                   network(O, N).
add_layer(D,D).
add_layer(D,D3):- dense_layer(D, 20, activation(relu), D2),
                  add_layer(D2,D3).