-- 65) Books that cost exactly 59.95
SELECT book_num, book_title, book_cost
FROM book
WHERE book_cost = 59.95
ORDER BY book_num;
