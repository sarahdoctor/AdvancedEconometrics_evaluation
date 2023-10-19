# Comparative study on Regression, Randomized Control Trial and Propensity Score Matching

Several studies have claimed that smoking during pregnancy harms the growth of the fetus, thereby affecting the birthweight of the newborn child. 
This study analyzes this exact impact through Regression, Randomized Control Trial and Propensity Score Matching and determines which method is most fit for this case.

# variables used

1. Mother_smoking: a dummy variable that takes
the value 1 if the mother smoked during pregnancy and 0 if the mother did not smoke
during pregnancy.
2. Child_weight: the child’s birth weight in grams.
3. Mother_ed: the education level of the mother expressed in years.
4. Father_ed: the education level of the father expressed in years.
5. Father_smoking: a dummy variable that takes the value 1 if the Father smokes and 0 otherwise.
6. MHI: The mother’s health index during pregnancy with 100 as the base.

# findings
Linear Regression: A relationship between the Child_weight and Mother_smoking is established, but it does not tell us its exact impact 
it has on the child’s weight. It must be noted that the model may suffer from heteroscedasticity or multicollinearity between the independent variables. 

RCT: The treatment effect in both the groups shows that the child’s weight in the treatment
group is 66 grams less than a child in the control group. However, the variables were not completely balanced in the two groups. 

Propensity Score Matching: Scores are matched using the nearest neighbor method, giving us 178 results. 
Unlike regression, matching controls the characteristics that control the treatment. Upon estimating the treatment effect, the difference between the two groups is found
to be 66.6 with a selection bias of 6.9. However, the probability of the scores vary largely between the groups, showing are not balanced. 

# conclusion
We can see that all the methods have their benefits and shortcomings. If more data was available, RCT would be the best estimator for this dataset. 
But in this case regression would provide us with an accurate representation of the causalrelationship between a mother smoking during pregnancy and the child’s weight.
