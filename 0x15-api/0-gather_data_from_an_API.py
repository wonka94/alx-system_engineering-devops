#!/usr/bin/python3
"""Returns to-do list information for a given employee ID."""
import requests
import sys

def get_user(user_id):
    url = "https://jsonplaceholder.typicode.com/users/"
    return requests.get(f"{url}{user_id}").json()

def get_todos(user_id):
    url = "https://jsonplaceholder.typicode.com/todos"
    return requests.get(url, params={"userId": user_id}).json()

def print_completed_tasks(user, todos):
    completed = [t.get("title") for t in todos if t.get("completed") is True]
    print(f"Employee {user.get('name')} is done with tasks({len(completed)}/{len(todos)}):")
    for task in completed:
        print(f"\t {task}")

if __name__ == "__main__":
    user = get_user(sys.argv[1])
    todos = get_todos(sys.argv[1])
    print_completed_tasks(user, todos)
