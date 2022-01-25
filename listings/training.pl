/* Hyper paramenters */
hidden_layers([10]). hidden_layers([20, 10]). hidden_layers([30, 20, 10]).

/* Learning paramenters */
max_epochs(30). max_epochs(50).
batch_size(32). batch_size(16).
learning_rate(0.01). learning_rate(0.1).
loss(cross_entropy).

/* Workflow paramenters */
target_performance(0.90).
test_percentage(0.2).

/* Generates all possible hyper and learning params combinations */
params([hidden_layers(H)], [iterations(X), learning_rate(Y), batch_size(Z), loss(L)]):- 
    hidden_layers(H),
    max_epochs(X), 
    learning_rate(Y), 
    batch_size(Z),
    loss(L).

/* Generates and trains all possible Predictors for the given Dataset and Schema, */
/* whose Performance is at least target_performance. */
model_selection(Dataset, Schema, Predictor, Transformation, Performance) :-
    test_percentage(R), target_performance(T),
    random_split(Dataset, R, TraingSet, TestSet), 
    preprocessing_pipeline(TraingSet, Schema, Transformation),
    transform(TraingSet, Transformation, ProcessedTrainingSet),
    params(HyperParams, LearnParams),
    train_cv(TraingSet, HyperParams, LearnParams, P),
    P >= T,
    multi_layer_perceptron(4, HyperParams, NN),
    train(NN, TrainingSet, LearnParams, Predictor),
    transform(TraingSet, Transformation, ProcessedTestSet),
    test(NN, TestSet, Performance).

/* Trains a NN multiple times, over Dataset, using the provided Params. */
/* Returns the AveragePerformance over a 10-fold CV. */
train_cv(Dataset, HyperParams, LearnParams, AveragePerformance) :-
    findall(
        Performance, 
        train_cv_fold(Dataset, 10, HyperParams, LearnParams, Performance), 
        AllPerformances
    ),
    mean(AllPerformances, AveragePerformance).

/* Trains a NN once, for the k-th round of CV. */
/* Returns the Performance over the k-th validation set. */
train_cv_fold(Dataset, K, HyperParams, LearnParams, Performance) :-
    fold(Dataset, K, Train, Validation),
    train_validate(Train, Validation, HyperParams, LearnParams, Performance).

/* Tranis a NN on the provided TrainingSet, using the provided Params, */
/* and computes its Performance over the provided ValidationSet. */
train_validate(TrainingSet, ValidationSet, HyperParams, LearnParams, Performance) :-  
    multi_layer_perceptron(4, HyperParams, 3, NN),
    train(NN, TrainingSet, LearnParams, TrainedNN),
    test(NN, ValidationSet, Performance).

/* Computes the Performance of the provided NN against the provided ValidationSet */
test(NN, ValidationSet, Performance) :-
    predict(NN, ValidationSet, ActualPredictions),
    accuracy(ActualPredictions, ValidationSet, Performance).

/* Example of training query: */
?- iris_dataset(D), iris_schema(S), model_selection(D, S, P, _, A).