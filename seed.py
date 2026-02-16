import sqlite3
from faker import Faker
import random

fake = Faker()

def seed_db():
    try:
        with sqlite3.connect('tasks.db') as con:
            cur = con.cursor()

            statuses = [('new',), ('in progress',), ('completed',)]
            cur.executemany("INSERT INTO status (name) VALUES (?);", statuses)
        
            users_id = []
            for _ in range(10):
                fullname = fake.name()
                email = fake.unique.email()
                cur.execute('INSERT INTO users (fullname, email) VALUES (?, ?);', (fullname, email))
                users_id.append(cur.lastrowid)

            
            cur.execute('SELECT id FROM status;')
            status_ids = [row[0] for row in cur.fetchall()]

            for _ in range(30):
                title = fake.sentence(nb_words=3)
                description = fake.text(max_nb_chars=100)
                s_id = random.choice(status_ids)
                u_id = random.choice(users_id)
                cur.execute(
                    "INSERT INTO tasks (title, description, status_id, user_id) VALUES (?, ?, ?, ?);",
                    (title, description, s_id, u_id)
                )

            con.commit()
            print("успех")

    except sqlite3.Error as e:
        print(f"Ошибка {e}")

if __name__ == "__main__":
    seed_db()