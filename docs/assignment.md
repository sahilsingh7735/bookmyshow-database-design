# Problem Solving Case - BookMyShow

## 1. Problem Statement

The system represents a simplified BookMyShow theatre listing.

For a selected theatre, the user can see the next seven dates.
After selecting a date, the system displays the movies playing in
that theatre and their available show timings.

---

## 2. Entities

### Theatre

Attributes:

- theatre_id - Primary Key
- theatre_name
- city
- address

### Screen

Attributes:

- screen_id - Primary Key
- theatre_id - Foreign Key
- screen_name
- capacity

### Movie

Attributes:

- movie_id - Primary Key
- movie_name
- language
- duration_minutes
- certificate

### Show

Attributes:

- show_id - Primary Key
- screen_id - Foreign Key
- movie_id - Foreign Key
- show_date
- show_time

---

## 3. Relationships

A Theatre can contain many Screens.

A Screen can have many Shows.

A Movie can have many Shows.

Relationship:

Theatre 1:N Screen

Screen 1:N Show

Movie 1:N Show

---

## 4. Table Structure

### theatres

| Column | Type | Constraint |
|---|---|---|
| theatre_id | INT | PK |
| theatre_name | VARCHAR(100) | NOT NULL |
| city | VARCHAR(100) | NOT NULL |
| address | VARCHAR(255) | NOT NULL |

### screens

| Column | Type | Constraint |
|---|---|---|
| screen_id | INT | PK |
| theatre_id | INT | FK |
| screen_name | VARCHAR(100) | NOT NULL |
| capacity | INT | NOT NULL |

### movies

| Column | Type | Constraint |
|---|---|---|
| movie_id | INT | PK |
| movie_name | VARCHAR(150) | NOT NULL |
| language | VARCHAR(50) | NOT NULL |
| duration_minutes | INT | NOT NULL |
| certificate | VARCHAR(10) | NOT NULL |

### shows

| Column | Type | Constraint |
|---|---|---|
| show_id | INT | PK |
| screen_id | INT | FK |
| movie_id | INT | FK |
| show_date | DATE | NOT NULL |
| show_time | TIME | NOT NULL |

---

## 5. Normalization

### 1NF

All attributes contain atomic values and there are no repeating groups.

### 2NF

All non-key attributes fully depend on their table primary key.
Movie, theatre and screen information are separated from the Show
table.

### 3NF

There are no transitive dependencies between non-key attributes.

For example:

movie_id determines movie_name, language, duration_minutes and
certificate.

theatre_id determines theatre_name, city and address.

### BCNF

Every determinant is a candidate key under the business rules.

The unique constraint:

UNIQUE(screen_id, show_date, show_time)

prevents duplicate shows on the same screen at the same date and
time.

---

## 6. Sample Data

The database contains sample:

- Theatres
- Screens
- Movies
- Shows

Multiple dates and show timings are included so that the P2 query
can be demonstrated.

---

## 7. P1

P1 is implemented in:

`sql/bookmyshow.sql`

The SQL creates the database, tables, constraints and sample data.

---

## 8. P2

Query to list all shows for a given theatre and date:

```sql
SELECT
    t.theatre_name,
    m.movie_name,
    m.language,
    s.screen_name,
    sh.show_date,
    TIME_FORMAT(sh.show_time, '%h:%i %p') AS show_timing
FROM shows sh
JOIN screens s
    ON sh.screen_id = s.screen_id
JOIN theatres t
    ON s.theatre_id = t.theatre_id
JOIN movies m
    ON sh.movie_id = m.movie_id
WHERE t.theatre_name = 'PVR Nexus'
  AND sh.show_date = '2026-04-25'
ORDER BY sh.show_time;