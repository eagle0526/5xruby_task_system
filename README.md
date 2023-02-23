## 想像網站成品會是什麼樣子

> ---    
> **任務功能**   
> 1. 可新增自己的任務。   
> 2. 使用者登入後，只能看見自己建立的任務。   
> 3. 可設定任務的開始及結束時間。     
> 4. 可設定任務的優先順序（高、中、低）。     
> 5. 可設定任務目前的狀態（待處理、進行中、已完成）。     
> 6. 可依狀態篩選任務。   
> 7. 可以任務的標題、內容進行搜尋。   
> 8. 可為任務加上分類標籤。   
> 9. 任務列表，並可依優先順序、開始時間及結束時間等進行排序。     
> 
> ---    

-------------

### Model有哪些

1. 有使用者有一定有user的model -> User
2. 要可以CURD任務 -> Task

Ps. 一個使用者會有很多的任務，因爲使用者只會看見自己的任務，所以兩者關係是一對多(一個任務只會有一個使用者)

-------------

### 欄位有哪些

* User的欄位 - 順便舉個例子
  - id: 1
  - Email: tasksystem@gmail.com
  - password: good123task


* Task的欄位 - 順便舉個例子
  - id: 1
  - title: 做使用者系統(任務名稱) - string
  - content: 純手刻，不使用devise做出使用者系統(任務內容) - text
  - priority: high、medium、low(任務優先順序) - string
  - state: 待處理、進行中、已完成(任務狀態) - string
  - classification: 軟體、後端、前端(任務標籤) - string
  - start＿time: "2023-02-18T14:30:00+08:00"(任務開始時間) - datetime
  - end＿time: "2023-02-28T19:30:00+08:00"(任務結束時間) - datetime
  - deleted_at: "2023-02-25T19:30:00+08:00"(任務假刪除) - datetime:index
  - user_id: 1(屬於使用者1的任務) - integer


### 觀察搜尋欄位LOG變化

在搜尋欄位打上 `任務` 後，可以篩選出 `title` 或是 `state` 兩個欄位，有任務這個字串的task   
```sql
SELECT DISTINCT "tasks".* FROM "tasks" WHERE "tasks"."deleted_at" IS NULL AND ("tasks"."title" ILIKE '%任務%' OR "tasks"."state" ILIKE '%任務%') ORDER BY "tasks"."created_at" DESC
```

可以看到終端機的SQL指令，可以看到
```md
(1) "tasks"."deleted_at" IS NULL -> 因為我們有使用軟刪除，如果沒有deleted_at is NULL的話，會順便把被軟刪除掉的資料一起搜尋出來

(2) "tasks"."title" ILIKE '%任務%' OR "tasks"."state" ILIKE '%任務%' -> 這一段是用篩選出 title or state 有任務關鍵字的task

(3) 最後我們根據 "created_at" 的 "DESC" 來排列任務
```




## 2、數據查看，4項任務，搜尋標題"任務"，跑出3項任務 

### 2-1、explain 數據

#### 2-1-1、加上index前


```md
 :042 > Task.where("title ILIKE ? OR state ILIKE ?", "%任務%", "%任務%").explain
  Task Load (3.0ms)  SELECT "tasks".* FROM "tasks" WHERE "tasks"."deleted_at" IS NULL AND (title ILIKE '%任務%' OR state ILIKE '%任務%')
 => 
EXPLAIN for: SELECT "tasks".* FROM "tasks" WHERE "tasks"."deleted_at" IS NULL AND (title ILIKE '%任務%' OR state ILIKE '%任務%')
                                       QUERY PLAN
----------------------------------------------------------------------------------------
 Bitmap Heap Scan on tasks  (cost=4.16..9.51 rows=1 width=216)
   Recheck Cond: (deleted_at IS NULL)
   Filter: (((title)::text ~~* '%任務%'::text) OR ((state)::text ~ ~* '%任務%'::text))
   ->  Bitmap Index Scan on index_tasks_on_deleted_at  (cost=0.00..4.16 rows=2 width=0)
         Index Cond: (deleted_at IS NULL)
```

#### 2-1-2、加上index後

```md
 :047 > Task.where("title ILIKE ? OR state ILIKE ?", "%任務%", "%任務%").explain
  Task Load (1.6ms)  SELECT "tasks".* FROM "tasks" WHERE "tasks"."deleted_at" IS NULL AND (title ILIKE '%任務%' OR state ILIKE '%任務%')
 => 
EXPLAIN for: SELECT "tasks".* FROM "tasks" WHERE "tasks"."deleted_at" IS NULL AND (title ILIKE '%任務%' OR state ILIKE '%任務%')
                                                 QUERY PLAN
-------------------------------------------------------------------------------------------------------------
 Seq Scan on tasks  (cost=0.00..1.17 rows=1 width=216)
   Filter: ((deleted_at IS NULL) AND (((title)::text ~~* '%任務%'::text) OR ((state)::text ~~* '%任務%'::text)))
(2 rows)
```




### 2-2、log/development.log 數據

#### 2-2-1、加上title index後前

```md
Started GET "/tasks?q%5Btitle_or_state_cont%5D=%E4%BB%BB%E5%8B%99&commit=%E6%A8%99%E9%A1%8C%E7%AF%A9%E9%81%B8" for ::1 at 2023-02-23 18:28:43 +0800
Processing by TasksController#index as HTML
  Parameters: {"q"=>{"title_or_state_cont"=>"任務"}, "commit"=>"標題篩選"}
  Rendering layout layouts/application.html.erb
  Rendering tasks/index.html.erb within layouts/application
  [1m[36mTask Load (5.1ms)[0m  [1m[34mSELECT DISTINCT "tasks".* FROM "tasks" WHERE "tasks"."deleted_at" IS NULL AND ("tasks"."title" ILIKE '%任務%' OR "tasks"."state" ILIKE '%任務%') ORDER BY "tasks"."created_at" DESC[0m
  ↳ app/views/tasks/index.html.erb:43
  Rendered tasks/index.html.erb within layouts/application (Duration: 10.7ms | Allocations: 2416)
  Rendered shared/_flash.html.erb (Duration: 0.1ms | Allocations: 57)
  Rendered layout layouts/application.html.erb (Duration: 26.7ms | Allocations: 6806)

> Completed 200 OK in 78ms (Views: 22.0ms | ActiveRecord: 25.9ms | Allocations: 12666)
```


#### 2-2-2、加上title index後
```md
Started GET "/tasks?q%5Btitle_or_state_cont%5D=%E4%BB%BB%E5%8B%99&commit=%E6%A8%99%E9%A1%8C%E7%AF%A9%E9%81%B8" for ::1 at 2023-02-23 18:36:49 +0800
Processing by TasksController#index as HTML
  Parameters: {"q"=>{"title_or_state_cont"=>"任務"}, "commit"=>"標題篩選"}
  Rendering layout layouts/application.html.erb
  Rendering tasks/index.html.erb within layouts/application
  [1m[36mTask Load (1.8ms)[0m  [1m[34mSELECT DISTINCT "tasks".* FROM "tasks" WHERE "tasks"."deleted_at" IS NULL AND ("tasks"."title" ILIKE '%任務%' OR "tasks"."state" ILIKE '%任務%') ORDER BY "tasks"."created_at" DESC[0m
  ↳ app/views/tasks/index.html.erb:43
  Rendered tasks/index.html.erb within layouts/application (Duration: 8.4ms | Allocations: 2304)
  Rendered shared/_flash.html.erb (Duration: 0.1ms | Allocations: 57)
  Rendered layout layouts/application.html.erb (Duration: 15.9ms | Allocations: 6692)

> Completed 200 OK in 31ms (Views: 15.3ms | ActiveRecord: 1.8ms | Allocations: 7933)
```



