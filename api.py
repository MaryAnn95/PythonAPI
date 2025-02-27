#Importing Modules
import numpy
import requests
import os
from dotenv import load_dotenv
import pandas
import sqlalchemy

#Loading .env Data
load_dotenv()

#API information
url = 'https://datausa.io/api/data?drilldowns=Nation&measures=Population'
header = {}
response = requests.get(url)
responseData = response.json()
df = pandas.json_normalize(responseData,'data')

#Database Information
user = os.getenv('user')
password = os.getenv('password')
host = '127.0.0.1'
port = 3306
database = 'population'

#Connecting our API data to MYSQL database and creating a table if one does not exist
engine = sqlalchemy.create_engine(url="mysql+pymysql://{0}:{1}@{2}:{3}/{4}".format(
            user, password, host, port, database
        ))
df.to_sql(name='CensusData', con=engine, index=False, if_exists='append')



