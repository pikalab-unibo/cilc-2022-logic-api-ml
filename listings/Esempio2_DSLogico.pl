/* dati logici*/
iris(sl(5.1), sw(3.2), pl(1.4), pw(0.2), species(setosa)).
iris(sl(4.9), sw(3), pl(1.7), pw(1.2), species(versicolor)).
iris(sl(5.9), sw(3.4), pl(1.1), pw(0.9), species(virginica)).

/* elaborazione */
encode_species(Se, Ve, Vi):- registered(tp,T), 
                             load_dataset_from_theory(iris,D), 
                             transform_dataset(D,T,D2),
                             final_schema(T,S), 
                             theory_from_dataset(S,D2,iris(_,_,_,_,Se,Ve,Vi)).