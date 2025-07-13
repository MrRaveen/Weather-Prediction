import mysql.connector
import json
import sys

config = {
    "host": "localhost",
    "user": "root",
    "password": "raveen007",
    "database": "weatherpredictionsource"
}
try:
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()
    cursor.execute("SHOW FULL TABLES WHERE Table_type = 'BASE TABLE';")
    
    rows = cursor.fetchall()
    table_col_name = f"Tables_in_{config['database']}"
    
    # Prepare JSON output
    result = [{"Table_name": row[0]} for row in rows]
    print(json.dumps(result))  # Output to stdout
except Exception as e:
    print(f"Error: {str(e)}", file=sys.stderr)
    sys.exit(1)
finally:
    if cursor:
        cursor.close()
    if conn:
        conn.close()
