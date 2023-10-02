#!/usr/bin/python3
"""Exports to-do list information for a given employee ID to CSV format."""
import csv
import requests
import sys

def get_user(user_id):
    url = "https://jsonplaceholder.typicode.com/users/"
    return requests.get(f"{url}{user_id}").json()

def get_todos(user_id):
    url = "https://jsonplaceholder.typicode.com/todos"
    return requests.get(url, params={"userId": user_id}).json()

def export_to_csv(user_id, username, todos):
    with open(f"{user_id}.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        for todo in todos:
            writer.writerow([user_id, username, todo.get("completed"), todo.get("title")])

if __name__ == "__main__":
    user_id = sys.argv[1]
    user = get_user(user_id)
    todos = get_todos(user_id)
    export_to_csv(user_id, user.get("username"), todos)
