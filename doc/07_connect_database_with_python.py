import psycopg2
from psycopg2 import sql
import os
from dotenv import load_dotenv
# from sqlalchemy import create_engine

def check_database(database_name, username, password, host, port):
  try:
    conn = psycopg2.connect(
      dbname="postgres", #default database
      user = username,
      password = password,
      host = host,
      port = port
    )

    conn.autocommit = True
    with conn.cursor() as cur:
      cur.execute(f"SELECT 1 FROM pg_database WHERE datname='{database_name}'")
      res = cur.fetchone()
      if res is None: # database has not been created:
        query = sql.SQL(f"CREATE DATABASE {database_name}")
        cur.execute(query)
        print(f"Database '{database_name}' created successfully!")
      # else:
      #   print(f"Database {database_name} exists!")
      
  except Exception as e:
    print("ERROR: ", e)
  return True

def connect_to_database(database_name, username, password, host, port):
  try:
    conn = psycopg2.connect(
      dbname=database_name,
      user = username,
      password = password,
      host = host,
      port = port
    )
    conn.autocommit = True
    print("Successfully connected to the PostgreSQL database!")
    return conn, conn.cursor()
    # engine = create_engine(f"postgresql://{username}:{password}@{host}:{port}/{database_name}")
    # return engine
  except Exception as e:
    print("ERROR: ", e)


def close_db(conn,cursor):
  conn.commit()
  cursor.close()
  conn.close()
  
if __name__=="__main__":
  check_database()