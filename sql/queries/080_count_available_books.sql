-- 80) Count books that are currently available (no current borrower)
SELECT COUNT(*) AS available_books
FROM book
WHERE pat_id IS NULL;
