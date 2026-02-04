TRUNCATE TABLE writes, checkout, book, author, patron RESTART IDENTITY CASCADE;

-- AUTHOR.csv headers:
-- AU_ID, AU_FNAME, AU_LNAME, AU_BIRTHYEAR
COPY author (au_id, au_fname, au_lname, au_birthyear)
FROM '/data/raw/author.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '', ENCODING 'UTF8');

-- PATRON.csv headers:
-- PAT_ID, PAT_FNAME, PAT_LNAME, PAT_TYPE
COPY patron (pat_id, pat_fname, pat_lname, pat_type)
FROM '/data/raw/patron.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '', ENCODING 'UTF8');

-- BOOK.csv headers:
-- BOOK_NUM, BOOK_TITLE, BOOK_YEAR, BOOK_COST, BOOK_SUBJECT, PAT_ID
COPY book (book_num, book_title, book_year, book_cost, book_subject, pat_id)
FROM '/data/raw/book.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '', ENCODING 'UTF8');

-- CHECKOUT.csv headers:
-- CHECK_NUM, BOOK_NUM, PAT_ID, CHECK_OUT_DATE, CHECK_DUE_DATE, CHECK_IN_DATE
-- Use a staging table so date formats never break the import.
DROP TABLE IF EXISTS checkout_stage;

CREATE TEMP TABLE checkout_stage (
check_num INTEGER,
book_num INTEGER,
pat_id INTEGER,
check_out_date TEXT,
check_due_date TEXT,
check_in_date TEXT
);

COPY checkout_stage (check_num, book_num, pat_id, check_out_date, check_due_date, check_in_date)
FROM '/data/raw/checkout.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '', ENCODING 'UTF8');

-- Convert to DATE safely. Handles:
-- - YYYY-MM-DD
-- - MM/DD/YYYY
INSERT INTO checkout (check_num, book_num, pat_id, check_out_date, check_due_date, check_in_date)
SELECT
check_num,
book_num,
pat_id,
CASE
WHEN check_out_date ~ '^\d{4}-\d{2}-\d{2}$' THEN check_out_date::date
WHEN check_out_date ~ '^\d{1,2}/\d{1,2}/\d{4}$' THEN to_date(check_out_date, 'MM/DD/YYYY')
ELSE NULL
END AS check_out_date,
CASE
WHEN check_due_date ~ '^\d{4}-\d{2}-\d{2}$' THEN check_due_date::date
WHEN check_due_date ~ '^\d{1,2}/\d{1,2}/\d{4}$' THEN to_date(check_due_date, 'MM/DD/YYYY')
ELSE NULL
END AS check_due_date,
CASE
WHEN check_in_date IS NULL OR trim(check_in_date) = '' THEN NULL
WHEN check_in_date ~ '^\d{4}-\d{2}-\d{2}$' THEN check_in_date::date
WHEN check_in_date ~ '^\d{1,2}/\d{1,2}/\d{4}$' THEN to_date(check_in_date, 'MM/DD/YYYY')
ELSE NULL
END AS check_in_date
FROM checkout_stage;

-- WRITES.csv headers:
-- BOOK_NUM, AU_ID
COPY writes (book_num, au_id)
FROM '/data/raw/writes.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '', ENCODING 'UTF8');

-- Sanity checks (should return 0 rows)
-- 1) Checkout rows with null parsed dates (means bad date format)
SELECT *
FROM checkout
WHERE check_out_date IS NULL OR check_due_date IS NULL;