DROP TABLE IF EXISTS writes CASCADE;
DROP TABLE IF EXISTS checkout CASCADE;
DROP TABLE IF EXISTS book CASCADE;
DROP TABLE IF EXISTS author CASCADE;
DROP TABLE IF EXISTS patron CASCADE;

CREATE TABLE author (
au_id INTEGER PRIMARY KEY,
au_fname VARCHAR(50) NOT NULL,
au_lname VARCHAR(50) NOT NULL,
au_birthyear INTEGER
);

CREATE TABLE patron (
pat_id INTEGER PRIMARY KEY,
pat_fname VARCHAR(50) NOT NULL,
pat_lname VARCHAR(50) NOT NULL,
pat_type VARCHAR(20) NOT NULL
);

-- book.pat_id is the current borrower (nullable)
CREATE TABLE book (
book_num INTEGER PRIMARY KEY,
book_title VARCHAR(200) NOT NULL,
book_year INTEGER,
book_cost NUMERIC(8,2) NOT NULL,
book_subject VARCHAR(50) NOT NULL,
pat_id INTEGER NULL REFERENCES patron(pat_id)
);

CREATE TABLE checkout (
check_num INTEGER PRIMARY KEY,
book_num INTEGER NOT NULL REFERENCES book(book_num),
pat_id INTEGER NOT NULL REFERENCES patron(pat_id),
check_out_date DATE NOT NULL,
check_due_date DATE NOT NULL,
check_in_date DATE NULL,
CONSTRAINT chk_checkout_dates
CHECK (check_due_date >= check_out_date AND (check_in_date IS NULL OR check_in_date >= check_out_date))
);

CREATE TABLE writes (
book_num INTEGER NOT NULL REFERENCES book(book_num),
au_id INTEGER NOT NULL REFERENCES author(au_id),
PRIMARY KEY (book_num, au_id)
);

CREATE INDEX idx_book_subject ON book(book_subject);
CREATE INDEX idx_book_pat_id ON book(pat_id);
CREATE INDEX idx_checkout_book_num ON checkout(book_num);
CREATE INDEX idx_checkout_pat_id ON checkout(pat_id);
CREATE INDEX idx_writes_au_id ON writes(au_id);