Library Database (PostgreSQL) — Access → Postgres Migration



Overview

This repository migrates a small relational “library” database originally created in Microsoft Access into PostgreSQL. It includes a reproducible Docker setup, a schema with constraints, a CSV-based data loader, data quality checks, and a query library (organized by problem number).



What this demonstrates



Relational data modeling (PK/FK constraints, many-to-many via junction table)



Data migration from Access-exported CSVs into PostgreSQL



SQL querying: filtering, sorting, DISTINCT, aggregation, joins, anti-joins (NOT EXISTS), derived metrics



Reproducible environment with Docker Compose



Data integrity checks (orphans, duplicate keys)



Repository structure



docker-compose.yml — local Postgres environment



sql/00\_schema.sql — schema + indexes



sql/01\_load\_data.sql — CSV load pipeline (includes date parsing)



sql/queries/ — query library mapped to problem numbers



scripts/run\_all.sql — creates schema, loads data, runs checks + sample queries



scripts/export\_results.sql — exports sample report outputs to CSV



data/raw/ — source CSV exports (Access → CSV)



docs/erd.png — ERD diagram



results/ — exported report outputs (CSV)



Prerequisites

Option A (recommended): Docker Desktop + Docker Compose

Option B: Local PostgreSQL + psql client



Quickstart (Docker)



Start Postgres



Run: docker compose up -d



Create schema + load data + run sample queries



Run: docker compose exec db psql -U postgres -d library -f /scripts/run\_all.sql



Export example “report” outputs



Run: docker compose exec db psql -U postgres -d library -f /scripts/export\_results.sql

Note: By default this script may export to /data. Recommended improvement is to mount ./results to /results and export there (see “Recommended improvements”).



Data import notes (Access → CSV)

This repo expects CSVs in data/raw/:



author.csv: AU\_ID, AU\_FNAME, AU\_LNAME, AU\_BIRTHYEAR



patron.csv: PAT\_ID, PAT\_FNAME, PAT\_LNAME, PAT\_TYPE



book.csv: BOOK\_NUM, BOOK\_TITLE, BOOK\_YEAR, BOOK\_COST, BOOK\_SUBJECT, PAT\_ID



checkout.csv: CHECK\_NUM, BOOK\_NUM, PAT\_ID, CHECK\_OUT\_DATE, CHECK\_DUE\_DATE, CHECK\_IN\_DATE



writes.csv: BOOK\_NUM, AU\_ID



Important: Some fields are blank (e.g., BOOK.PAT\_ID for available books; AUTHOR.AU\_BIRTHYEAR may be missing).



Query library

All queries live in sql/queries/ and are named by problem number. Highlights:



090\_author\_book\_join.sql — many-to-many join via writes



098\_times\_checked\_out\_per\_book.sql — LEFT JOIN + aggregation + COALESCE



106\_authors\_without\_programming.sql — NOT EXISTS anti-join



107\_book\_vs\_subject\_avg\_cost.sql — compares each book to subject average


License

MIT License (see LICENSE file).

