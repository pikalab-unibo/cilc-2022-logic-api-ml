/* idea di base */
iris(sl(X1), sw(X2), pl(X3), pw(X4), species(Y)) :- Y = /*valore predetto da una rete neurale*/ .
/* applicazione */
?- iris(sl(5.1), sw(3.0), pl(1.4), pw(0.2), species(Y)). % -> yes({Y/setosa})
?- iris(sl(5.1), sw(3.0), pl(1.4), pw(0.2), species(setosa)). % -> yes()
?- iris(sl(5.1), sw(3.0), pl(1.4), pw(0.2), species(versicolor)). % -> no()