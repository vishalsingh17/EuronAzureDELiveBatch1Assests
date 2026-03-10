# Databricks notebook source
# MAGIC %md
# MAGIC ## Join in pyspark

# COMMAND ----------

from pyspark.sql import Row
from pyspark.sql import functions as F

df1 = spark.createDataFrame([Row(name="Alice", age=25), Row(name="Bob", age=30), Row(name="Charlie", age=35)])
df2 = spark.createDataFrame([Row(age=25, city="New York"), Row(age=30, city="San Francisco"), Row(age=40, city="Chicago")])

display(df1)
display(df2)

# COMMAND ----------

# inner join
df1.join(df2, "age").show()

# COMMAND ----------

# outer/full
df3 = df1.join(df2, df1.age == df2.age, "outer")
display(df3)

# COMMAND ----------

df3 = df1.join(df2, on=df1.age == df2.age, how="left")
display(df3)

# COMMAND ----------

# cross join in pyspark
df3 = df1.join(df2, how="cross")
display(df3)

# COMMAND ----------

display(df1.crossJoin(df2))

# COMMAND ----------

# broadcast join

from pyspark.sql.functions import broadcast

small = spark.createDataFrame([Row(k=1, v="a")])
large = spark.range(1_000_000).selectExpr("id as k", "id as val")

display(small)
display(large)

# COMMAND ----------

display(large.join(small, "k", "left"))

# COMMAND ----------

display(large.join(broadcast(small), "k", "left"))

# COMMAND ----------

# MAGIC %md
# MAGIC ## Window functions

# COMMAND ----------

from pyspark.sql import Window, Row

from pyspark.sql.functions import col, row_number, rank, dense_rank, percent_rank, ntile, lag, lead, first, last, nth_value

data = [
  Row(tx_id=1, store="StoreA", product="p1", dt="2025-01-01", amount=100, qty=2),
  Row(tx_id=2, store="StoreB", product="p2", dt="2025-01-02", amount=120, qty=1),
  Row(tx_id=3, store="StoreA", product="p1", dt="2025-01-03", amount=150, qty=3),
  Row(tx_id=4, store="StoreB", product="p2", dt="2025-01-01", amount=120, qty=2),
  Row(tx_id=5, store="StoreA", product="p3", dt="2025-01-02", amount=300, qty=3),
  Row(tx_id=6, store="StoreB", product="p2", dt="2025-01-03", amount=80, qty=1),
  Row(tx_id=7, store="StoreC", product="p1", dt="2025-01-01", amount=90, qty=2),
  Row(tx_id=8, store="StoreC", product="p3", dt="2025-01-02", amount=110, qty=4),
  Row(tx_id=9, store="StoreC", product="p1", dt="2025-01-03", amount=110, qty=2),
  Row(tx_id=10, store="StoreC", product="p3", dt="2025-01-03", amount=500, qty=3),
]

df_win = spark.createDataFrame(data)
display(df_win)



# COMMAND ----------

# row_number

## partition is created on store column
w_store_amount = Window.partitionBy("store").orderBy(col("amount"))

## added a new column, for row_number function
df_win1 = df_win.withColumn("row_number", row_number().over(w_store_amount))

display(df_win1)


# COMMAND ----------


display(df_win.withColumn("row_number", row_number().over(Window.partitionBy("store").orderBy(col("amount")))))



# COMMAND ----------

# rank

## partition is created on store column
w_store_amount = Window.partitionBy("store").orderBy(col("amount"))

## added a new column, for row_number function
df_win1 = df_win.withColumn("rank", rank().over(w_store_amount))

display(df_win1)

# COMMAND ----------

# dense rank

## partition is created on store column
w_store_amount = Window.partitionBy("store").orderBy(col("amount"))

## added a new column, for row_number function
df_win1 = df_win.withColumn("dense_rank", dense_rank().over(w_store_amount))

display(df_win1)

# COMMAND ----------

# percent_rank (  (rank -1 )/ (total_row_in_partition-1)   )

## partition is created on store column
w_store_amount = Window.partitionBy("store").orderBy(col("amount"))

## added a new column, for row_number function
df_win1 = df_win.withColumn("percent_rank", percent_rank().over(w_store_amount))

display(df_win1)

# COMMAND ----------

# cume_dist (no_of_rows_with_value_less_than_or_equal_to_current_row / total_row_in_partition)

from pyspark.sql.functions import cume_dist
## partition is created on store column
w_store_amount = Window.partitionBy("store").orderBy(col("amount"))

## added a new column, for row_number function
df_win1 = df_win.withColumn("cume_dist", cume_dist().over(w_store_amount))

display(df_win1)

# COMMAND ----------

# n_tile

## partition is created on store column
w_store_amount = Window.partitionBy("store").orderBy(col("amount"))

## added a new column, for row_number function
df_win1 = df_win.withColumn("n_tile", ntile(2).over(w_store_amount))

display(df_win1)

# COMMAND ----------

# lead

w_store_dt_asc = Window.partitionBy("store").orderBy(col("dt").asc())

df_win1 = df_win.withColumn("lead", lead("amount", 1).over(w_store_dt_asc))

display(df_win1)

# COMMAND ----------

w_store_dt_asc = Window.partitionBy("store").orderBy(col("dt").asc())

df_win1 = df_win.withColumn("lead", lead("amount", 2).over(w_store_dt_asc))

display(df_win1)

# COMMAND ----------

w_store_dt_asc = Window.partitionBy("store").orderBy(col("dt").asc())

df_win1 = df_win.withColumn("lag", lag("amount", 2).over(w_store_dt_asc))

display(df_win1)

# COMMAND ----------

#nth value

df_win1 = df_win.withColumn("nth_value", nth_value("amount", 2).over(Window.partitionBy("store").orderBy(col("dt").asc())))
display(df_win1)

# COMMAND ----------

df_win1 = df_win.withColumn("nth_value", nth_value("amount", 3).over(Window.partitionBy("store").orderBy(col("dt").asc())))
display(df_win1)

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

