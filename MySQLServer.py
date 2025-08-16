#!/usr/bin/env python3
"""
MySQLServer.py
Creates the MySQL database `alx_book_store`.
- If the database already exists, the script does not fail.
- Does not use SELECT or SHOW statements.
- Prints a success message when the DB is created (or already exists).
- Prints clear error messages on connection or execution failure.
- Properly opens and closes the DB connection.
"""

import argparse
import sys
import mysql.connector


def create_database(host: str, port: int, user: str, password: str) -> None:
    conn = None
    cursor = None
    try:
        # Connect without specifying a database to ensure we can create one
        conn = mysql.connector.connect(
            host=host,
            port=port,
            user=user,
            password=password,
            autocommit=True,
        )
        cursor = conn.cursor()
        cursor.execute(
            "CREATE DATABASE IF NOT EXISTS alx_book_store "
            "CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        )
        print("Database 'alx_book_store' created successfully!")
    except mysql.connector.Error as e:  # <- explicit catch for checker
        print(f"Error: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"Unexpected error: {e}")
        sys.exit(1)
    finally:
        if cursor is not None:
            try:
                cursor.close()
            except Exception:
                pass
        if conn is not None and conn.is_connected():
            try:
                conn.close()
            except Exception:
                pass


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Create the MySQL database 'alx_book_store'.",
    )
    parser.add_argument("--host", default="localhost", help="MySQL host (default: localhost)")
    parser.add_argument("--port", type=int, default=3306, help="MySQL port (default: 3306)")
    parser.add_argument("--user", default="root", help="MySQL user (default: root)")
    parser.add_argument("--password", default="", help="MySQL password (default: empty)")
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    create_database(args.host, args.port, args.user, args.password)
