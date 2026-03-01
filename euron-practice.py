# Databricks notebook source
df = spark.read.table("euron_db.default.life_expectancy")

# COMMAND ----------

display(df)

# COMMAND ----------

df.show()

# COMMAND ----------

df.printSchema()

# COMMAND ----------

# temp view 
temp_table_name = "temp_life"

df.createTempView(temp_table_name)

# COMMAND ----------

# MAGIC %sql
# MAGIC select * from temp_life;

# COMMAND ----------

# temp view 
temp_table_name = "temp_life"

df.createOrReplaceTempView(temp_table_name)

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC select country, avg(life_expectancy) from temp_life group by country; 

# COMMAND ----------

## renaming columns using pyspark

df1 = df.withColumnRenamed("infant_deaths", "child_deaths")
display(df1)

# COMMAND ----------

display(df)

# COMMAND ----------

df1 = df.withColumnRenamed("infant_deaths", "child_death").withColumnRenamed("year", "saal")
display(df1)

# COMMAND ----------

df2 = df.selectExpr("infant_deaths as child_deaths", "year as saal")
display(df2)

# COMMAND ----------

from pyspark.sql.functions import col
df3 = df.select(col("infant_deaths").alias("child_deaths"), col("year"), col("country").alias("nation"))
display(df3)

# COMMAND ----------

from pyspark.sql.functions import col
df3 = df.select(col("infant_deaths").alias("child_deaths"), *df.columns[1:])
display(df3)

# COMMAND ----------

## add new column in pyspark

from pyspark.sql.functions import lit

df3 = df.withColumn("health_check", lit("done"))
display(df3)

# COMMAND ----------

df3 = df.withColumn("weight", col("bmi")+col("polio"))
display(df3)

# COMMAND ----------

df4 = df.withColumn("weight", col("bmi")+col("polio")).withColumn("health_checkup", lit("done"))
display(df4)


# COMMAND ----------

## Filter data using pyspark

df1 = df.filter(df.country == "India")
display(df1)

# COMMAND ----------

df1 = df.filter(col("country") == "India")
display(df1)

# COMMAND ----------

df1 = df.filter((df.country == "India") | (df.country == "China"))
display(df1)

# COMMAND ----------

df1 = df.filter((col("country") == "India") | (col("country") == "China"))
display(df1)

# COMMAND ----------

df1 = df.filter((col("country")== "India") & (col("year") == 2004))
display(df1)

# COMMAND ----------

df1 = df.filter((col("country") != "India") & (col("year") == 2004))
display(df1)

# COMMAND ----------

## sort data in pyspark

df1 = df.sort(col("year"))
display(df1)

# COMMAND ----------

df1 = df.sort(col("year").desc())
display(df1)

# COMMAND ----------

df2 = df.orderBy(col("year").desc())
display(df2)

# COMMAND ----------

df2 = df.orderBy(df.year.desc())
display(df2)

# COMMAND ----------

df2 = df.orderBy(df.year.desc(), df.country)
display(df2)

# COMMAND ----------

df2 = df.orderBy(col("year").desc(), col("country"))
display(df2)

# COMMAND ----------

## remove duplicates

from pyspark.sql.functions import *

df_duplicates = df.groupBy(*df.columns).count().filter("count>1")
display(df_duplicates)
display(df.join(df_duplicates, on=df.columns, how="inner"))

# COMMAND ----------

from pyspark.sql import Row

data = [
    Row(country="A", year=2020, adult_mortality=100),
    Row(country="A", year=2020, adult_mortality=100),
    Row(country="B", year=2021, adult_mortality=150),
    Row(country="B", year=2021, adult_mortality=150), 
    Row(country="C", year=2022, adult_mortality=200),
    Row(country="C", year=2022, adult_mortality=300),
]

df_dummy = spark.createDataFrame(data)
display(df_dummy)

# COMMAND ----------

df_duplicates1 = df_dummy.groupBy(*df_dummy.columns).count().filter("count>1")
display(df_duplicates1)
display(df_dummy.join(df_duplicates1, on=df_dummy.columns, how="inner"))

# COMMAND ----------

df1 = df_dummy.distinct()
display(df1)

# COMMAND ----------

df1 = df_dummy.dropDuplicates()
display(df1)

# COMMAND ----------

df1 = df_dummy.dropDuplicates(["country"])
display(df1)

# COMMAND ----------

df1 = df_dummy.dropDuplicates(["adult_mortality"])
display(df1)

# COMMAND ----------

df1 = df_dummy.dropDuplicates(["country", "year"])
display(df1)

# COMMAND ----------

df1 = df_dummy.dropDuplicates(["country", "adult_mortality"])
display(df1)

# COMMAND ----------

## group by in pyspark

from pyspark.sql import Row

data = [
    Row(id=1, name="John", marks=90),
    Row(id=2, name="Jane", marks=80),
    Row(id=3, name="Bob", marks=70),
    Row(id=1, name="John", marks=90),
    Row(id=2, name="Jane", marks=80),
    Row(id=3, name="Bob", marks=70),
    Row(id=1, name="John", marks=25),
    Row(id=2, name="Jane", marks=30),
]

df_marks = spark.createDataFrame(data)
display(df_marks)

# COMMAND ----------

df1 = df_marks.groupBy("id").sum("marks").alias("total_marks")
display(df1)

# COMMAND ----------

df1 = df_marks.groupBy("id").min("marks")
display(df1)

# COMMAND ----------

df1 = df_marks.groupBy("id").max("marks")
display(df1)

# COMMAND ----------

display(df)

# COMMAND ----------

df1 = df.groupBy("year").sum("adult_mortality").alias("total_adult_mortality")
display(df1)

# COMMAND ----------

df1 = df.groupBy("year").min("adult_mortality").alias("min_adult_mortality").max("adult_mortality").alias("max_adult_mortality")
display(df1)

# COMMAND ----------

df1 = df.groupBy("year").agg(
    min("adult_mortality").alias("min_adult_mortality"), 
    max("adult_mortality").alias("max_adult_mortality"))
display(df1)

# COMMAND ----------

df1 = df.groupBy("year", "country").agg(
    avg("life_expectancy").alias("avg_life_expectancy"), 
    min("adult_mortality").alias("min_adult_mortality"), 
    max("adult_mortality").alias("max_adult_mortality"),
    sum("infant_deaths").alias("total_infant_deaths")
)
display(df1)

# COMMAND ----------

## write a dataframe to a table

from pyspark.sql.functions import col

df_filter = df.filter((col("country") == "India") | (col("country") == "China") | (col("country") == "Thailand"))
display(df_filter)


# COMMAND ----------

df_filter.write.mode("overwrite").saveAsTable("life_india_china")

# COMMAND ----------

from pyspark.sql.functions import col

df_filter1 = df.filter((col("country") == "India") | (col("country") == "China") | (col("country") == "Thailand"))
display(df_filter1)

# COMMAND ----------

df_filter1.write.mode("append").saveAsTable("life_india_china1")

# COMMAND ----------

## merge dataframes

from pyspark.sql import Row

data1 = [Row(id=1, name="Alice"), Row(id=2, name="Bob")]
data2 = [Row(id=3, name="Charlie"), Row(id=4, name="David")]

df1 = spark.createDataFrame(data1)
df2 = spark.createDataFrame(data2)

display(df1)
display(df2)

# COMMAND ----------

df_merged = df1.union(df2)
display(df_merged)

# COMMAND ----------

from pyspark.sql import Row

data1 = [Row(id=1, name="Alice"), Row(id=2, name="Bob")]
data2 = [Row(ID=3, NAME="Charlie"), Row(ID=4, NAME="David")]

df1 = spark.createDataFrame(data1)
df2 = spark.createDataFrame(data2)

display(df1)
display(df2)

# COMMAND ----------

df_merged = df1.union(df2)
display(df_merged)

# COMMAND ----------

df_merged = df2.union(df1)
display(df_merged)

# COMMAND ----------

data1 = [Row(id=1, name="Alice"), Row(id=2, name="Bob")]
data2 = [Row(NAME="Charlie", ID=3), Row(NAME="David", ID=4)]

df1 = spark.createDataFrame(data1)
df2 = spark.createDataFrame(data2)

display(df1)
display(df2)

# COMMAND ----------

df_merged = df1.union(df2)
display(df_merged)

# COMMAND ----------

## when and otherwise (if, else/ case statement)

from pyspark.sql.functions import when, col

display(df)

# COMMAND ----------

df_flag = df.withColumn("high_adult_mortality", when(col("adult_mortality")> 200, "High").otherwise("Low"))
display(df_flag)

# COMMAND ----------

df_exp = df.withColumn("life_category", 
                       when(col("life_expectancy") > 80, "High").when(col("life_expectancy") > 60, "Medium").otherwise("Low"))
display(df_exp)

# COMMAND ----------

display(df.withColumn("country-status", when(col("gdp")>20000, "RICH").otherwise("POOR")))

# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------



# COMMAND ----------

