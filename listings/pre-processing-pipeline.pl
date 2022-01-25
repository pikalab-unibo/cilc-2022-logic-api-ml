%  declaring & fitting the preprocessing pipeline
preprocessing_pipeline(Dataset, Schema, Pipeline) :- 
    schema_transformation(Schema, Step0),
    normalize(Step0, [petal_width, petal_length, sepal_width, sepal_length], Step1),
    one_hot_encode(Step1, [species], Step2), 
    fit(Step2, Dataset, Pipeline).
