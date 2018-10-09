# task-board

Task management tool

application for [TaskBoard](https://task-board-yi.herokuapp.com/tasks)

# Schema

User

| Name     | Type   | Size | Default | PK | UQ |   |
|----------|--------|------|---------|----|----|---|
| name     | string |      |         |    |    |   |
| email    | string |      |         |    |    |   |
| password | string |      |         |    |    |   |

Project

| Name        | Type   | Size | Default | PK | UQ |   |
|-------------|--------|------|---------|----|----|---|
| title       | string |      |         |    |    |   |
| description | text   |      |         |    |    |   |

Task

| Name            | Type     | Size | Default | PK | UQ |   |
|-----------------|----------|------|---------|----|----|---|
| title           | string   |      |         |    |    |   |
| description     | text     |      |         |    |    |   |
| deadline        | datetime |      |         |    |    |   |
| priority        | integer  |      |         |    |    |   |
| status          | integer  |      |         |    |    |   |
| created_user_id | integer  |      |         |    |    |   |
| project_id      | integer  |      |         |    |    |   |

Label

| Name | Type    | Size | Default | PK | UQ |   |
|------|---------|------|---------|----|----|---|
| name | integer |      |         |    |    |   |

Task_label

| Name     | Type    | Size | Default | PK | UQ |   |
|----------|---------|------|---------|----|----|---|
| task_id  | integer |      |         |    |    |   |
| label_id | integer |      |         |    |    |   |
