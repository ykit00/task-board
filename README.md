# task-board

Task management tool

# Schema

User
name: string
email: string
password: string

Project
title: integer
description: text

Task
title: string
description: text
deadline: datetime
priority: integer
status: integer
created_user_id: integer
project_id: integer

Label
name: integer

Task_label
task_id: integer
label_id: integer
