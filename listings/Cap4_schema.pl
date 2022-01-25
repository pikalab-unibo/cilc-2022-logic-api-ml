attribute(0, sl, type(double)).
attribute(1, sw, type(double)).
attribute(2, pl, type(double)).
attribute(3, pw, type(double)).
attribute(4, species, type(categorical[setosa, versicolor, virginica])).
schema_name(iris)
schema_target(iris)

iris(X).
iris(sl(7.0), sw(3.2),  pl(4.7), pw(1.4), species(versicolor)).
iris(sl(6.3), sw(3.3),  pl(6.0), pw(2.5), species(virginica)).
iris(sl(7.0), sw(3.2),  pl(4.7), pw(1.4), species(X)).
iris(sl(6.3), sw(3.3),  pl(6.0), pw(2.5), X).