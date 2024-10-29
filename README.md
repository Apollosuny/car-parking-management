# README

## GROUP <add-group-name>

- Member 1: Trần Bảo Trung
- Member 2: Đỗ Minh Hải
- Member 3: Trần Thị Ngọc Anh
- Member 4: Phan Viết Anh Quân

## Starting server

- Run on your terminal `docker-compose up`
- Open browser at http://localhost:3000/
- Continue your work on a new terminal tab. Leave this terminal tab open until you want to stop the server.

## Stop server

`CTRL + C`

### Bundle install

Installing required libraries, you can run this command multiple time. If there is an error, let make sure this command has been executed successfully.

`bundle install`

### Migrate database

`rails db:migrate`

## Optional

### Rails console

`rails c`

### Access database

```bash
docker exec -it <container_id_or_name> bash
```

Access PostgreSQL by psql

```bash
psql -U <username> -d <database_name>
```

### Link Lecture

https://docs.google.com/presentation/d/1XLmCUvWkW7NCgQR-k5RtP6zTHQWx-RYn9Hz62kNJ_u8/edit#slide=id.g1cf26bf0732_1_59
