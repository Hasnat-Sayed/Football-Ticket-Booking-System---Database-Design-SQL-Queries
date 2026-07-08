# Football Ticket Booking System — Database Design & SQL Queries

A simplified relational database for a football ticket booking platform, covering user
management, match scheduling, and ticket booking transactions. Built as part of a database
design assignment focused on ERD modeling and intermediate-to-advanced SQL.

## Overview

The system manages three core entities:

- **Users** — fans and staff who use the platform
- **Matches** — tournament fixtures, pricing, and ticket availability
- **Bookings** — individual ticket purchase transactions linking users to matches

## Entity Relationship Diagram

![Football Ticket Booking System ERD](/A3ERD.drawio.png)

**Relationships:**

- One `User` → Many `Bookings` (a fan can book tickets for multiple matches)
- One `Match` → Many `Bookings` (a match can have thousands of bookings)
- Each row in `Bookings` maps exactly one user to one match for a specific seat

## Schema

### Users Table

| Field          | Type         | Constraints        | Description                                  |
|----------------|--------------|---------------------|-----------------------------------------------|
| `user_id`      | INT          | PK                  | Unique identifier for each registered user     |
| `full_name`    | VARCHAR(100) | NOT NULL            | First and last name of the user                |
| `email`        | VARCHAR(100) | NOT NULL, UNIQUE    | Login email address                            |
| `role`         | VARCHAR(20)  | CHECK (Ticket Manager / Football Fan) | Access permission level      |
| `phone_number` | VARCHAR(20)  | Nullable            | Contact mobile number                          |

### Matches Table

| Field                 | Type          | Constraints                                                    | Description                              |
|-----------------------|---------------|------------------------------------------------------------------|--------------------------------------------|
| `match_id`            | INT           | PK                                                                | Unique identifier for each match            |
| `fixture`             | VARCHAR(150)  | NOT NULL                                                          | Competing teams (e.g. Real Madrid vs Barcelona) |
| `tournament_category` | VARCHAR(100)  | NOT NULL                                                          | League or cup title                         |
| `base_ticket_price`   | NUMERIC(10,2) | NOT NULL, CHECK (>= 0)                                            | Base price for a standard seat               |
| `match_status`        | VARCHAR(20)   | CHECK (Available / Selling Fast / Sold Out / Postponed)           | Current ticket availability state            |

### Bookings Table

| Field            | Type          | Constraints                                              | Description                                   |
|------------------|---------------|-------------------------------------------------------------|--------------------------------------------------|
| `booking_id`     | INT           | PK                                                           | Unique transaction number for the ticket purchase  |
| `user_id`        | INT           | FK → Users(user_id)                                          | Links the booking to the purchasing user           |
| `match_id`       | INT           | FK → Matches(match_id)                                       | Links the booking to the match                     |
| `seat_number`    | VARCHAR(10)   | Nullable                                                     | Allocated stadium seat (e.g. A-12)                 |
| `payment_status` | VARCHAR(20)   | CHECK (Pending / Confirmed / Cancelled / Refunded)           | Financial resolution of the transaction            |
| `total_cost`     | NUMERIC(10,2) | NOT NULL, CHECK (>= 0)                                       | Final invoice price                                |

## Sample Data

### Users

| user_id | full_name       | email               | role            | phone_number     |
|---------|-----------------|---------------------|------------------|--------------------|
| 1       | Tanvir Rahman   | tanvir@mail.com      | Football Fan     | +8801711111111      |
| 2       | Asif Haque      | asif@mail.com        | Football Fan     | +8801722222222      |
| 3       | Sajjad Rahman   | sajjad@mail.com      | Ticket Manager   | +8801733333333      |
| 4       | Jannat Ara      | jannat@mail.com      | Football Fan     | NULL                |

### Matches

| match_id | fixture                  | tournament_category | base_ticket_price | match_status  |
|----------|---------------------------|-----------------------|----------------------|-----------------|
| 101      | Real Madrid vs Barcelona   | Champions League      | 150                  | Available       |
| 102      | Man City vs Liverpool      | Premier League         | 120                  | Selling Fast    |
| 103      | Bayern Munich vs PSG       | Champions League      | 130                  | Available       |
| 104      | AC Milan vs Inter Milan    | Serie A                | 90                   | Sold Out        |
| 105      | Juventus vs Roma           | Serie A                | 80                   | Available       |

### Bookings

| booking_id | user_id | match_id | seat_number | payment_status | total_cost |
|------------|---------|----------|--------------|------------------|--------------|
| 501        | 1       | 101      | A-12         | Confirmed        | 150          |
| 502        | 1       | 102      | B-04         | Confirmed        | 120          |
| 503        | 2       | 101      | A-13         | Confirmed        | 150          |
| 504        | 2       | 101      | NULL         | NULL             | 150          |
| 505        | 3       | 102      | C-20         | Pending          | 120          |

## SQL Queries

All queries live in [`QUERY.sql`](./QUERY.sql). Summary of what each one does:

| # | Description | Concepts Used |
|---|---------------|------------------|
| 1 | Champions League matches with status `Available` | `WHERE` |
| 2 | Users named `Tanvir%` or containing `Haque` (case-insensitive) | `LIKE`, `ILIKE` |
| 3 | Bookings with missing payment status, labeled `Action Required` | `IS NULL`, `COALESCE` |
| 4 | Booking details joined with user name and match fixture | `INNER JOIN` |
| 5 | All users and their bookings, including fans with none | `LEFT JOIN` |
| 6 | Bookings priced above the average booking cost | Subquery, `AVG` |
| 7 | Top 2 most expensive matches, skipping the highest | `ORDER BY`, `LIMIT`, `OFFSET` |

## How to Run

1. Load `QUERY.sql` into your PostgreSQL (or compatible) database client.
2. Run the `DROP TABLE` / `CREATE TABLE` statements to set up the schema.
3. Run the `INSERT` statements to seed sample data.
4. Run each numbered query section individually to see its output.

## Project Structure

```
├── README.md
├── QUERY.sql
└── erd.png
```

## Author

Hasnat Bin Sayed — B.Sc. in Computer Science and Engineering, International Islamic University Chittagong (IIUC)