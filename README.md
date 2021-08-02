# NYC-taxi-ride-duration-prediction

In this project, I will create a regression model that predicts the travel time of a taxi ride in New York from the dataset of 97692 trips published by the NYC Taxi and Limosine Commission (https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page). 

After this project, I wish to feel comfortable with the following:

The data science lifecycle: data selection and cleaning, EDA, feature engineering, and model selection.
Using sklearn to process data and fit linear regression models.
Embedding linear regression as a component in a more complex model.

## Conclusion 

I've carried out the entire data science lifecycle for a challenging regression problem. 

In Part 1 on data selection, I solved a domain-specific programming problem relevant to the analysis when choosing only those taxi rides that started and ended in Manhattan.

In Part 2 on EDA, I used the data to assess the impact of a historical event---the 2016 blizzard---and filtered the data accordingly.

In Part 3 on feature engineering, I used PCA to divide up the map of Manhattan into regions that roughly corresponded to the standard geographic description of the island.

In Part 4 on model selection, I found that using linear regression in practice can involve more than just choosing a design matrix. Tree regression made better use of categorical variables than linear regression. The domain knowledge that duration is a simple function of distance and speed allowed I to predict duration more accurately by first predicting speed.

