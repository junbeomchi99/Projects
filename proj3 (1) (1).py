#!/usr/bin/env python
# coding: utf-8

# # Project: Predicting NYC Taxi Ride Duration 

# ## This Assignment
# In this project, I will create a regression model that predicts the travel time of a taxi ride in New York. 
# 
# After this project, I should feel comfortable with the following:
# 
# - The data science lifecycle: data selection and cleaning, EDA, feature engineering, and model selection.
# - Using `sklearn` to process data and fit linear regression models.
# - Embedding linear regression as a component in a more complex model.
# 
# First, let's import:

# In[1]:


import numpy as np
import pandas as pd

import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')

import seaborn as sns


# ## The Data
# Attributes of all [yellow taxi](https://en.wikipedia.org/wiki/Taxicabs_of_New_York_City) trips in January 2016 are published by the [NYC Taxi and Limosine Commission](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page).
# 
# The full data set takes a long time to download directly, so I've placed a simple random sample of the data into `taxi.db`, a SQLite database. .
# 
# Columns of the `taxi` table in `taxi.db` include:
# - `pickup_datetime`: date and time when the meter was engaged
# - `dropoff_datetime`: date and time when the meter was disengaged
# - `pickup_lon`: the longitude where the meter was engaged
# - `pickup_lat`: the latitude where the meter was engaged
# - `dropoff_lon`: the longitude where the meter was disengaged
# - `dropoff_lat`: the latitude where the meter was disengaged
# - `passengers`: the number of passengers in the vehicle (driver entered value)
# - `distance`: trip distance
# - `duration`: duration of the trip in seconds
# 
# My goal will be to predict `duration` from the pick-up time, pick-up and drop-off locations, and distance.

# ## Part 1: Data Selection and Cleaning
# 
# In this part, I will limit the data to trips that began and ended on Manhattan Island ([map](https://www.google.com/maps/place/Manhattan,+New+York,+NY/@40.7590402,-74.0394431,12z/data=!3m1!4b1!4m5!3m4!1s0x89c2588f046ee661:0xa0b3281fcecc08c!8m2!3d40.7830603!4d-73.9712488)). 

# Use a SQL query to load the `taxi` table from `taxi.db` into a Pandas DataFrame called `all_taxi`. 
# 
# Only include trips that have **both** pick-up and drop-off locations within the boundaries of New York City:
# 
# - Longitude is between -74.03 and -73.75 (inclusive of both boundaries)
# - Latitude is between 40.6 and 40.88 (inclusive of both boundaries)
# 
# 

# In[3]:


import sqlite3

conn = sqlite3.connect('taxi.db')
lon_bounds = [-74.03, -73.75]
lat_bounds = [40.6, 40.88]

sql = """
SELECT * FROM taxi
WHERE (pickup_lon >= -74.03) AND (pickup_lon <= -73.75)
AND (pickup_lat <= 40.88) AND (pickup_lat >= 40.6)
AND (dropoff_lon >= -74.03) AND (dropoff_lon <= -73.75)
AND (dropoff_lat <=40.88) AND (dropoff_lat >= 40.6)
"""


all_taxi = pd.read_sql(sql, conn)
all_taxi.head()


# A scatter plot of pickup locations shows that most of them are on the island of Manhattan. The empty white rectangle is Central Park; cars are not allowed there.

# In[5]:


def pickup_scatter(t):
    plt.scatter(t['pickup_lon'], t['pickup_lat'], s=2, alpha=0.2)
    plt.xlabel('Longitude')
    plt.ylabel('Latitude')
    plt.title('Pickup locations')
    
plt.figure(figsize=(8, 8))
pickup_scatter(all_taxi)


# The two small blobs outside of Manhattan with very high concentrations of taxi pick-ups are airports.

# Create a DataFrame called `clean_taxi` that only includes trips with a positive passenger count, a positive distance, a duration of at least 1 minute and at most 1 hour, and an average speed of at most 100 miles per hour. Inequalities should not be strict (e.g., `<=` instead of `<`) unless comparing to 0.
# 

# In[6]:


clean_taxi = all_taxi[all_taxi['passengers'] > 0]
clean_taxi = clean_taxi[clean_taxi['distance'] > 0]
clean_taxi = clean_taxi[clean_taxi['duration'].between(60,3600)]
clean_taxi = clean_taxi[clean_taxi['distance']/clean_taxi['duration'] * 3600 <= 100]
clean_taxi


# Create a DataFrame called `manhattan_taxi` that only includes trips from `clean_taxi` that start and end within a polygon that defines the boundaries of [Manhattan Island](https://www.google.com/maps/place/Manhattan,+New+York,+NY/@40.7590402,-74.0394431,12z/data=!3m1!4b1!4m5!3m4!1s0x89c2588f046ee661:0xa0b3281fcecc08c!8m2!3d40.7830603!4d-73.9712488).
# 
# The vertices of this polygon are defined in `manhattan.csv` as (latitude, longitude) pairs, which are [published here](https://gist.github.com/baygross/5430626).
# 
# An efficient way to test if a point is contained within a polygon is [described on this page](http://alienryderflex.com/polygon/). There are even implementations on that page (though not in Python). Even with an efficient approach, the process of checking each point can take several minutes. It's best to test the work on a small sample of `clean_taxi` before processing the whole thing. (To check if my code is working, draw a scatter diagram of the (lon, lat) pairs of the result; the scatter diagram should have the shape of Manhattan.)
# 
# 

# In[8]:


polygon = pd.read_csv('manhattan.csv')
def in_manhattan(x, y):
    """Whether a longitude-latitude (x, y) pair is in the Manhattan polygon."""
    lat = list(polygon['lat'])
    lon = list(polygon['lon'])
    
    j = len(lat) - 1
    oddNodes = False
    
    for i in range(0, j+1): 
        if (lon[i] + (y - lat[i]) / (lat[j] - lat[i]) * (lon[j] - lon[i])) < x:
            if ((lat[i] < y <= lat[j]) and (lon[i] <= x)):
                oddNodes = not oddNodes
            elif ((lat[i] < y <= lat[j]) and (lon[j] <= x)):
                oddNodes = not oddNodes
            elif (lat[j] < y <= lat[i]) and (lon[i] <= x):
                oddNodes = not oddNodes
            elif (lat[j] < y <= lat[i]) and (lon[j] <= x):
                oddNodes = not oddNodes       
        j = i
    return oddNodes

manhattan_taxi = clean_taxi.copy()
def dropoff(x):
    return in_manhattan(x['dropoff_lon'], x['dropoff_lat'])
manhattan_taxi['drop_off_Manhattan']  = clean_taxi.apply(dropoff, axis =1)
def pickup(x):
    return in_manhattan(x['pickup_lon'], x['pickup_lat'])
manhattan_taxi['pickup_Manhattan'] = clean_taxi.apply(pickup, axis=1)

manhattan_taxi = manhattan_taxi.loc[ (manhattan_taxi['drop_off_Manhattan'] == True) & (manhattan_taxi['pickup_Manhattan'] == True), :]

manhattan_taxi = manhattan_taxi.drop(columns=['drop_off_Manhattan', 'pickup_Manhattan'])


# In[9]:


inMan = []
for x in range(0, len(clean_taxi)):
    inMan.append(in_manhattan(clean_taxi.iloc[x]['pickup_lon'],
                             clean_taxi.iloc[x]['pickup_lat']) and
                             in_manhattan(clean_taxi.iloc[x]['dropoff_lon'], clean_taxi.iloc[x]['dropoff_lat']))
manhattan_taxi = clean_taxi.iloc[inMan]


# In[11]:


manhattan_taxi = pd.read_csv('manhattan_taxi.csv')


# A scatter diagram of only Manhattan taxi rides has the familiar shape of Manhattan Island. 

# In[12]:


plt.figure(figsize=(8, 16))
pickup_scatter(manhattan_taxi)


# 
# **In the following cell**, a summary of the data selection and cleaning performed. 

# In[13]:


original_trip = len(all_taxi)
cleaned_trip = len(clean_taxi)
removed_trip = original_trip - cleaned_trip
percentage_removed = removed_trip / original_trip *100
manhattan_trip = len(manhattan_taxi)

print(f"Of the original {original_trip} trips, {removed_trip} anomolous trips ({percentage_removed})"
      "\n"f"were removed through data cleaning, and then the {manhattan_trip} trips "
      "\n"f" within Manhattan were selected for further analysis")


# ## Part 2: Exploratory Data Analysis
# 
# In this part, I'll choose which days to include as training data in my regression model. 
# 
# my goal is to develop a general model that could potentially be used for future taxi rides. There is no guarantee that future distributions will resemble observed distributions, but some effort to limit training data to typical examples can help ensure that the training data are representative of future observations.
# 
# January 2016 had some atypical days. New Years Day (January 1) fell on a Friday. MLK Day was on Monday, January 18. A [historic blizzard](https://en.wikipedia.org/wiki/January_2016_United_States_blizzard) passed through New York that month. Using this dataset to train a general regression model for taxi trip times must account for these unusual phenomena, and one way to account for them is to remove atypical days from the training data.

# Add a column labeled `date` to `manhattan_taxi` that contains the date (but not the time) of pickup, formatted as a `datetime.date` value ([docs](https://docs.python.org/3/library/datetime.html#date-objects)). 

# In[14]:


manhattan_taxi['date'] = pd.to_datetime(manhattan_taxi['pickup_datetime']).dt.date
manhattan_taxi.head()


# Create a data visualization that allows to identify which dates were affected by the historic blizzard of January 2016. Make sure that the visualization type is appropriate for the visualized data.
# 

# In[16]:


df = manhattan_taxi.groupby('date').size()
df.plot()
plt.xticks(rotation = 45)
plt.ylabel('number of rides')
plt.title('number of rides each day of January 2016')


# Finally, I have generated a list of dates that should have a fairly typical distribution of taxi rides, which excludes holidays and blizzards. The cell below assigns `final_taxi` to the subset of `manhattan_taxi` that is on these days.

# In[17]:


import calendar
import re

from datetime import date

atypical = [1, 2, 3, 18, 23, 24, 25, 26]
typical_dates = [date(2016, 1, n) for n in range(1, 32) if n not in atypical]
typical_dates

print('Typical dates:\n')
pat = '  [1-3]|18 | 23| 24|25 |26 '
print(re.sub(pat, '   ', calendar.month(2016, 1)))

final_taxi = manhattan_taxi[manhattan_taxi['date'].isin(typical_dates)]


# Could do more EDA here but I skipped

# ## Part 3: Feature Engineering
# 
# In this part, I will create a design matrix (i.e., feature matrix) for the linear regression model. I decide to predict trip duration from the following inputs: start location, end location, trip distance, time of day, and day of the week (*Monday, Tuesday, etc.*). 
# 
# I will ensure that the process of transforming observations into a design matrix is expressed as a Python function called `design_matrix`, so that it's easy to make predictions for different samples in later parts of the project.
# 
# Because I are going to look at the data in detail in order to define features, it's best to split the data into training and test sets now, then only inspect the training set.

# In[19]:


import sklearn.model_selection

train, test = sklearn.model_selection.train_test_split(
    final_taxi, train_size=0.8, test_size=0.2, random_state=42)
print('Train:', train.shape, 'Test:', test.shape)


# Create a box plot that compares the distributions of taxi trip durations for each day **using `train` only**. Individual dates shoud appear on the horizontal axis, and duration values should appear on the vertical axis.
# 

# In[20]:


plt.figure(figsize=(10, 5))
data = train.sort_values('date')
sns.boxplot('date', 'duration', data=data)
plt.xticks(rotation = 90)
plt.title('Duration by date')


# In one or two sentences, describe the assocation between the day of the week and the duration of a taxi trip.

# For the first two week, the week follows a similar trend of each other. There seems to be shorter duration trips on the weekends than in weekdays. We see the decrease in the duration and it moves from weekday into weekend for each week. In the boxplot, Sunday seems to be the day with lowest duration (given the week starts on Monday). Moreover, duration on Thursdays are relatively higher than other days, range of duration was less during weekends compared to weekdays. 

# In[21]:


print('Typical dates:\n')
pat = '  [1-3]|18 | 23| 24|25 |26 '
print(re.sub(pat, '   ', calendar.month(2016, 1)))


# Below, the provided `augment` function adds various columns to a taxi ride dataframe. 
# 
# - `hour`: The integer hour of the pickup time. E.g., a 3:45pm taxi ride would have `15` as the hour. A 12:20am ride would have `0`.
# - `day`: The day of the week with Monday=0, Sunday=6.
# - `weekend`: 1 if and only if the `day` is Saturday or Sunday.
# - `period`: 1 for early morning (12am-6am), 2 for daytime (6am-6pm), and 3 for night (6pm-12pm).
# - `speed`: Average speed in miles per hour.

# In[22]:


def speed(t):
    """Return a column of speeds in miles per hour."""
    return t['distance'] / t['duration'] * 60 * 60

def augment(t):
    """Augment a dataframe t with additional columns."""
    u = t.copy()
    pickup_time = pd.to_datetime(t['pickup_datetime'])
    u.loc[:, 'hour'] = pickup_time.dt.hour
    u.loc[:, 'day'] = pickup_time.dt.weekday
    u.loc[:, 'weekend'] = (pickup_time.dt.weekday >= 5).astype(int)
    u.loc[:, 'period'] = np.digitize(pickup_time.dt.hour, [0, 6, 18])
    u.loc[:, 'speed'] = speed(t)
    return u
    
train = augment(train)
test = augment(test)
train.iloc[0,:] # An example row


# Use `sns.distplot` to create an overlaid histogram comparing the distribution of average speeds for taxi rides that start in the early morning (12am-6am), day (6am-6pm; 12 hours), and night (6pm-12am; 6 hours). 

# In[23]:


plt.figure(figsize=(10,5))
sns.distplot(train.loc[train['period']==1, 'speed'], kde=True, label ='Early Morning')
sns.distplot(train.loc[train['period']==2, 'speed'], kde=True, label ='Early Morning')
sns.distplot(train.loc[train['period']==3, 'speed'], kde=True, label ='Early Morning')
plt.legend()


# It looks like the time of day is associated with the average speed of a taxi ride.

# 
# Manhattan can roughly be divided into Lower, Midtown, and Upper regions. Instead of studying a map, I will approximate by finding the first principal component of the pick-up location (latitude and longitude). Before doing that, I will first take a look at a scatterplot of trips in Manhattan:

# In[24]:


plt.figure(figsize=(3, 6))
pickup_scatter(manhattan_taxi)


# Add a `region` column to `train` that categorizes each pick-up location as 0, 1, or 2 based on the value of each point's first principal component, such that an equal number of points fall into each region. 
# 
# Read the documentation of [`pd.qcut`](https://pandas.pydata.org/pandas-docs/version/0.23.4/generated/pandas.qcut.html), which categorizes points in a distribution into equal-frequency bins.

# In[25]:


# Find the first principal component
D = train[['pickup_lon', 'pickup_lat']].values
pca_n = D.shape[0]
pca_means = np.mean(D, axis=0)
X = (D - pca_means) / np.sqrt(pca_n)
u, s, vt = np.linalg.svd(X, full_matrices=False)

def add_region(t):
    """Add a region column to t based on vt above."""
    D = t[['pickup_lon', 'pickup_lat']].values
    assert D.shape[0] == t.shape[0], 'You set D using the incorrect table'
    # Always use the same data transformation used to compute vt
    X = (D - pca_means) / np.sqrt(pca_n) 
    first_pc = X@vt.T[:,0]
    t.loc[:,'region'] = pd.qcut(first_pc, 3, labels=[0, 1, 2])
    
add_region(train)
add_region(test)


# Let's see how PCA divided the trips into three groups. These regions do roughly correspond to Lower Manhattan (below 14th street), Midtown Manhattan (between 14th and the park), and Upper Manhattan (bordering Central Park). No prior knowledge of New York geography was required!

# In[27]:


plt.figure(figsize=(8, 16))
for i in [0, 1, 2]:
    pickup_scatter(train[train['region'] == i])


# Finally, I create a design matrix that includes many of these features. Quantitative features are converted to standard units, while categorical features are converted to dummy variables using one-hot encoding. The `period` is not included because it is a linear combination of the `hour`. The `weekend` variable is not included because it is a linear combination of the `day`.  The `speed` is not included because it was computed from the `duration`; it's impossible to know the speed without knowing the duration, given that I know the distance.

# In[29]:


from sklearn.preprocessing import StandardScaler

num_vars = ['pickup_lon', 'pickup_lat', 'dropoff_lon', 'dropoff_lat', 'distance']
cat_vars = ['hour', 'day', 'region']

scaler = StandardScaler()
scaler.fit(train[num_vars])

def design_matrix(t):
    """Create a design matrix from taxi ride dataframe t."""
    scaled = t[num_vars].copy()
    scaled.iloc[:,:] = scaler.transform(scaled) # Convert to standard units
    categoricals = [pd.get_dummies(t[s], prefix=s, drop_first=True) for s in cat_vars]
    return pd.concat([scaled] + categoricals, axis=1)

design_matrix(train).iloc[0,:]  


# ## Part 4: Model Selection
# 
# In this part, I will select a regression model to predict the duration of a taxi ride.
# 

# Assign `constant_rmse` to the root mean squared error on the test set for a constant model that always predicts the mean duration of all training set taxi rides.
# 

# In[30]:


def rmse(errors):
    """Return the root mean squared error."""
    return np.sqrt(np.mean(errors ** 2))

mean = np.mean(train['duration'])
constant_rmse = rmse(mean - test['duration'])
constant_rmse


# Assign `simple_rmse` to the root mean squared error on the test set for a simple linear regression model that uses only the distance of the taxi ride as a feature (and includes an intercept).
# 

# In[32]:


from sklearn.linear_model import LinearRegression

model = LinearRegression()
model.fit(pd.DataFrame(train['distance']), train['duration'])
prediction = model.predict(pd.DataFrame(test['distance']))
simple_rmse = rmse(test['duration'] - prediction)
simple_rmse


# Assign `linear_rmse` to the root mean squared error on the test set for a linear regression model fitted to the training set without regularization, using the design matrix defined by the `design_matrix` function from Part 3.

# In[34]:


from sklearn.linear_model import LinearRegression
model = LinearRegression()
model.fit(pd.DataFrame(design_matrix(train)), train['duration'])
prediction = model.predict(pd.DataFrame(design_matrix(test)))
linear_rmse = rmse(test['duration'] - prediction)
linear_rmse


# For each possible value of `period`, fit an unregularized linear regression model to the subset of the training set in that `period`.  Assign `period_rmse` to the root mean squared error on the test set for a model that first chooses linear regression parameters based on the observed period of the taxi ride, then predicts the duration using those parameters. Again, fit to the training set and use the `design_matrix` function for features.

# In[36]:


model = LinearRegression()
errors = []

for v in np.unique(train['period']):
    model.fit(design_matrix(train.loc[train['period']==v, :]), train.loc[train['period']==v, 'duration'])
    predictions = np.array(model.predict(design_matrix(test.loc[test['period']==v, :])))
    e = ((predictions - test.loc[test['period']==v, 'duration']).values).tolist()
    errors = errors + e
period_rmse = rmse(np.array(errors))
period_rmse


# This approach is a simple form of decision tree regression, where a different regression function is estimated for each possible choice among a collection of choices. In this case, the depth of the tree is only 1.

# In one or two sentences, explain how the `period` regression model could possibly outperform linear regression model, even when the design matrix of the latter includes one feature for each possible hour.
# 

# For the period regression model, what we are doing is essentially iterating through each unique values that are in train['period']. This creates multiple regression lines rather than ust fitting the entire data in one plance, hence allowing us better fit the data. This makes the period regression model outperform the linear regression. 

# Instead of predicting duration directly, an alternative is to predict the average *speed* of the taxi ride using linear regression, then compute an estimate of the duration from the predicted speed and observed distance for each ride.
# 
# Assign `speed_rmse` to the root mean squared error in the **duration** predicted by a model that first predicts speed as a linear combination of features from the `design_matrix` function, fitted on the training set, then predicts duration from the predicted speed and observed distance.
# 

# In[38]:


model = LinearRegression()
model.fit(design_matrix(train), train['speed'])
speed_prediction = np.array(model.predict(design_matrix(test)))
speed_rmse = rmse((((test['distance']*3600) /speed_prediction)-test['duration']))
speed_rmse


# At this point, think about why predicting speed leads to a more accurate regression model than predicting duration directly.

# Finally, complete the function `tree_regression_errors` (and helper function `speed_error`) that combines the ideas from the two previous models and generalizes to multiple categorical variables.
# 
# The `tree_regression_errors` should:
# - Find a different linear regression model for each possible combination of the variables in `choices`;
# - Fit to the specified `outcome` (on train) and predict that `outcome` (on test) for each combination (`outcome` will be `'duration'` or `'speed'`);
# - Use the specified `error_fn` (either `duration_error` or `speed_error`) to compute the error in predicted duration using the predicted outcome;
# - Aggregate those errors over the whole test set and return them.
# 
# I should find that including each of `period`, `region`, and `weekend` improves prediction accuracy, and that predicting speed rather than duration leads to more accurate duration predictions.

# In[40]:


model = LinearRegression()
choices = ['period', 'region', 'weekend']

def duration_error(predictions, observations):
    """Error between predictions (array) and observations (data frame)"""
    return predictions - observations['duration']

def speed_error(predictions, observations):
    """Duration error between speed predictions and duration observations"""
    duration_predictions = (observations['distance']*3600) / predictions
    speed_error = duration_predictions - observations['duration']
    return speed_error

def tree_regression_errors(outcome='duration', error_fn=duration_error):
    """Return errors for all examples in test using a tree regression model."""
    errors = []
    for vs in train.groupby(choices).size().index:
        v_train, v_test = train, test
        for v, c in zip(vs, choices):
            v_train = v_train.loc[v_train[c] == v, :]
            v_test = v_test.loc[v_test[c] == v, :]
            print(v_train.shape, v_test.shape)
        model.fit(design_matrix(v_train), v_train.loc[:, outcome])
        predictions=np.array(model.predict(design_matrix(v_test)))
        e=error_fn(predictions, v_test).tolist()
        errors=errors+e
    return errors

errors = tree_regression_errors()
errors_via_speed = tree_regression_errors('speed', speed_error)
tree_rmse = rmse(np.array(errors))
tree_speed_rmse = rmse(np.array(errors_via_speed))
print('Duration:', tree_rmse, '\nSpeed:', tree_speed_rmse)


# Here's a summary of my results:

# In[42]:


models = ['constant', 'simple', 'linear', 'period', 'speed', 'tree', 'tree_speed']
pd.DataFrame.from_dict({
    'Model': models,
    'Test RMSE': [eval(m + '_rmse') for m in models]
}).set_index('Model').plot(kind='barh');


# ## Conclusion 
# 
# I've carried out the entire data science lifecycle for a challenging regression problem. 
# 
# In Part 1 on data selection, I solved a domain-specific programming problem relevant to the analysis when choosing only those taxi rides that started and ended in Manhattan.
# 
# In Part 2 on EDA, I used the data to assess the impact of a historical event---the 2016 blizzard---and filtered the data accordingly.
# 
# In Part 3 on feature engineering, I used PCA to divide up the map of Manhattan into regions that roughly corresponded to the standard geographic description of the island.
# 
# In Part 4 on model selection, I found that using linear regression in practice can involve more than just choosing a design matrix. Tree regression made better use of categorical variables than linear regression. The domain knowledge that duration is a simple function of distance and speed allowed I to predict duration more accurately by first predicting speed.
# 
# Hopefully, it is apparent that all of these steps are required to reach a reliable conclusion about what inputs and model structure are helpful in predicting the duration of a taxi ride in Manhattan. 

# ## Future Work
# 
# Here are some questions to ponder:
# 
# - The regression model would have been more accurate if we had used the date itself as a feature instead of just the day of the week. Why didn't we do that?
# - Does collecting this information about every taxi ride introduce a privacy risk? The original data also included the total fare; how could someone use this information combined with an individual's credit card records to determine their location?
# - Why did we treat `hour` as a categorical variable instead of a quantitative variable? Would a similar treatment be beneficial for latitude and longitude?
# - Why are Google Maps estimates of ride time much more accurate than our estimates?
# 
# 
# Here are some possible extensions to the project:
# 
# - An alternative to throwing out atypical days is to condition on a feature that makes them atypical, such as the weather or holiday calendar. How would you do that?
# - Training a different linear regression model for every possible combination of categorical variables can overfit. How would you select which variables to include in a decision tree instead of just using them all?
# - Your models use the observed distance as an input, but the distance is only observed after the ride is over. How could you estimate the distance from the pick-up and drop-off locations?
# - How would you incorporate traffic data into the model?

# In[ ]:




