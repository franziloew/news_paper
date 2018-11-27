Different types of media bias - compare with polls
================
Franziska Löw
2018-11-18

We use the data from the "Sonntagsumfrage" (Sunday survey) from [infratest dimap](https://www.infratest-dimap.de/umfragen-analysen/bundesweit/sonntagsfrage/). The institution regularly asks at least 1000 German citizens the question: "Which party would you choose if federal elections take place next Sunday?" The survey thus measures the current election tendencies and therefore reflects an intermediate state in the opinion-forming process of the electoral population.

To ensure comparability between different metrics, all have been standardized to range from −1 to 1.

Data Modelling
==============

*Y* = *β*<sub>0</sub> + *β*<sub>1</sub>*x*<sub>visibility bias</sub> + *β*<sub>2</sub>*x*<sub>tonality bias</sub> + *β*<sub>3</sub>*x*<sub>agenda bias</sub> + *β*<sub>4</sub>*D*<sub>AfD</sub> + *β*<sub>5</sub>*D*<sub>FDP</sub> + *β*<sub>6</sub>*D*<sub>Grüne</sub> + *β*<sub>7</sub>*D*<sub>Linke</sub> + *β*<sub>8</sub>*D*<sub>SPD</sub> + *β*<sub>9</sub>*D*<sub>Union</sub>
 where ...

-   *Y* = average monthly poll value of parties

medium-specific Fixed Effects using Dummy Variables (LSDV Model)
----------------------------------------------------------------

### Fixed effects

I use fixed-effects (FE) as I am only interested in analyzing the impact of the different biases that vary over time.

FE explore the relationship between predictor and outcome variables within an entity, in this case party. Each party has its own individual characteristics that may or may not influence the predictor variables; e.g. the communication practices of a party may influence its poll value.

When using FE I assume that something within the party may impact the outcome variables (poll value) that need to be controled for. This is the rationale behind the assumption of the correlation between entity's error term and predictor variables. FE remove the effect of those time-invariant characteristics so I can assess the net effect of the predictors on the outcome variable.

Another important assumption of the FE model is that those time-invariant characteristics are unique to the party and should not be correlated with other party characteristics. Each party is different therefore the party's error term and the constant (which captures individual characteristics) should not be correlated with the others. If the error terms are correlated, then FE is no suitable since inferences may not be correct and you need to model that relationship (probably using random-effects), this is the main rationale for the Hausman test.

*"The key insight is that if the unobserved variable does not change over time, then any changes in the dependent variable must be due to influences other than these fixed characteristics."* (Stock and Watson, 2003, p.289-290)

*"In the case of time-series cross-sectional data the interpretation of the beta coefficients would be "...for a given country, as *X* varies across time by one unit, *Y* increases or decreases by *β* units"* (Bartels, Brandom, “Beyond “Fixed Versus Random Effects”: A framework for improving substantive and statistical analysis of panel, time-series cross-sectional, and multilevel data”, Stony Brook University, working paper, 2008).

*Y*<sub>*i**t*</sub> = *β*<sub>0</sub> + *β*<sub>1</sub>*X*<sub>1*i**t*</sub> + *β*<sub>2</sub>*X*<sub>2*i**t*</sub> + *β*<sub>3</sub>*X*<sub>3*i**t*</sub> + *α*<sub>*i*</sub> + *ϵ*<sub>*i**t*</sub>

Where...

-   *α*<sub>*i*</sub> (*i* = 1, ..., *n*) is the unknown intercept for each party (7 party-specific intercepts). – *Y*<sub>*i**t*</sub> is the poll value where *i* = party and *t* = month. – *X*<sub>*j**i**t*</sub> represents the independent variables (IV) visibility bias (*j* = 1), tonality bias (*j* = 2) and agenda bias (*j* = 3) – *β*<sub>*j*</sub> is the coefficient for that IV, – *ϵ*<sub>*i**t*</sub> is the error term

How do we know when to use fixed or random effects? We can use the Hausman Test, where the null hypothesis is that the model is random effects and the alternative is that fixed effects are better fit. In this example, the p-value is below .05 so a fixed effects model is the better fit for this data.
