-- 107) Compare each book cost vs the average cost for its subject
SELECT
  b.book_num,
  b.book_title,
  b.book_subject,
  b.book_cost,
  s.avg_cost,
  (b.book_cost - s.avg_cost) AS difference
FROM book b
JOIN (
  SELECT book_subject, AVG(book_cost) AS avg_cost
  FROM book
  GROUP BY book_subject
) s ON s.book_subject = b.book_subject
ORDER BY b.book_title;
