# ham-spam-classifier
Developed a classifier that can distinguish spam emails from non-spam emails. 
Conducted feature engineering and exploratory data analysis (EDA) using tools such as regex in pandas libraries for data cleaning and seaborn libraries for data visualization to select the best features for the model. 
Used logsitic regression to develop the classifier and achieved ~95% accuracy with the test set. 

Summary:
- feature engineering with over 8000 text data
- sklearn libraries to process data and fit models
- validating the performance of my model and minimzing overfitting
- generating and analyzing precision-recall curves. 
 
Used dataset of email messages and their labels (0 for ham, 1 for spam)
- training set = 8348 labeled examples, which i used sklearn.model_selection to split into training and validating set
- test set = 1000 unlabeled examples, which I used to test the accuracy of my classifier. 


