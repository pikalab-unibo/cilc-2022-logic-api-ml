shape(H, W, Class) :- transform(shape(H, W,\_), TP, X), 
                     classify(X, N, [rectangle, square], Y), 
                     Class = class(Y)