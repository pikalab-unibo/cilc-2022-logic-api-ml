/* elaborazione dati */
process_data(T, Din, S, Dout):- transform_dataset(Din, T, Dout),
                                final_schema(T, S).
/* schema addestramento */                           
training_schema(Att, Name, Targets):- dataset(D), 
                                      build_network(N), 
                                      schema_from_theory(S),
                                      transform_process(S,D, T),
                                      final_schema(T, S2),
                                      schema_attributes(Att, Name, Targets, S2).