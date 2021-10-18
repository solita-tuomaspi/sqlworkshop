# DEV Academy SQL and relational database workshop

## Setup

Start the database with `docker-compose up -d`.

Adminer control panel can be found at http://localhost:8088/.

![Login information](login.png)

The database can also be accessed from the command line

```
docker exec -it sqlworkshop_db_1 bash
psql -U academy -W
```
Some commands to get you started (-- is SQL comment)
```
-- Generic help, SQL help and psql help
help
\h
\?
-- Show tables, views and sequences
\d
-- Describe a single table, view, sequence or index
\d <table>
-- Quit
\q
```
