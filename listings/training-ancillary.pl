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

% Computes the Performance of the provided NN against the provided ValidationSet
test(NN, ValidationSet, Performance) :-
    predict(NN, ValidationSet, ActualPredictions),
    accuracy(ActualPredictions, ValidationSet, Performance).
