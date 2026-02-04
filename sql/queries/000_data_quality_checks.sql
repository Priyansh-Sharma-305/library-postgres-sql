-- Data quality checks (should return 0 rows where noted)

-- 1) Orphaned checkout.book_num (should be 0)
SELECT c.*
FROM checkout c
LEFT JOIN book b ON b.book_num = c.book_num
WHERE b.book_num IS NULL;

-- 2) Orphaned checkout.pat_id (should be 0)
SELECT c.*
FROM checkout c
LEFT JOIN patron p ON p.pat_id = c.pat_id
WHERE p.pat_id IS NULL;

-- 3) Orphaned writes.book_num (should be 0)
SELECT w.*
FROM writes w
LEFT JOIN book b ON b.book_num = w.book_num
WHERE b.book_num IS NULL;

-- 4) Orphaned writes.au_id (should be 0)
SELECT w.*
FROM writes w
LEFT JOIN author a ON a.au_id = w.au_id
WHERE a.au_id IS NULL;

-- 5) Duplicate primary keys 
SELECT au_id, COUNT(*) AS cnt
FROM author
GROUP BY au_id
HAVING COUNT(*) > 1;

SELECT book_num, COUNT(*) AS cnt
FROM book
GROUP BY book_num
HAVING COUNT(*) > 1;

SELECT pat_id, COUNT(*) AS cnt
FROM patron
GROUP BY pat_id
HAVING COUNT(*) > 1;

SELECT check_num, COUNT(*) AS cnt
FROM checkout
GROUP BY check_num
HAVING COUNT(*) > 1;