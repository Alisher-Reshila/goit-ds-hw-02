--1. Получить все задания определенного пользователя по user_id
SELECT * FROM tasks WHERE user_id = 1;

--2. Выбрать задания по определенному статусу 
SELECT * FROM tasks 
WHERE status_id = (SELECT id FROM status WHERE name = 'new');

--3. Обновить статус конкретного задния на 'in progress'
UPDATE tasks 
SET status_id = (SELECT id FROM status WHERE name = 'in progress') WHERE id = 1;

--4.Получить список пользователей у которыз нет заданияю.
SELECT * FROM users 
WHERE id NOT IN (SELECT DISTINCT user_id FROM tasks);

--5.Добавить новое задание для конкретного пользователя.
INSERT INTO tasks (title,description, status_id, user_id)
VALUES ('New tasks', 'Tasks description', 1,1);

--6. получить все незавершенные задачи.
SELECT * FROM tasks 
WHERE status_id != (SELECT id FROM status WHERE name = 'completed');

-- 7. Удалить задание по id.
DELETE FROM tasks WHERE id = 3;

-- 8. найти пользователя по email почте.
SELECT * FROM users WHERE email LIKE '%@example.com';

-- 9. Обновить имя пользователя 
UPDATE users SET fullname = 'New Name' WHERE id = 1;

-- 10. Получить количество задачь для каждого статуса. 
SELECT s.name, COUNT(t.id) as total FROM status s 
LEFT JOIN tasks t ON s.id = t.status_id GROUP BY s.name;

-- 11. Получить задиния пользователя по доменной части почты.
SELECT t.* FROM tasks t 
JOIN users u ON t.user_id = u.id WHERE u.email LIKE '%@example.org';

-- 12. Список задачь, в которых нет описанияю
SELECT * FROM tasks WHERE description IS NULL OR description = '';

--13. Пользователи и их задачи в статуве "in progress"
SELECT u.fullname, t.title FROM users u 
INNER JOIN tasks t ON u.id = t.user_id 
INNER JOIN status s ON t.status_id = s.id WHERE s.name = 'in progress';

-- 14. Пользователи и количество из задачь
SELECT u.fullname, COUNT(t.id) as task_count FROM users u 
LEFT JOIN tasks t ON u.id = t.user_id GROUP BY u.id, u.fullname;