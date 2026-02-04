-- 98) Times each book has been checked out (include zeros)
SELECT
  b.book_num,
  b.book_title,
  COALESCE(COUNT(c.check_num), 0) AS times_checked_out
FROM book b
LEFT JOIN checkout c ON c.book_num = b.book_num
GROUP BY b.book_num, b.book_title
ORDER BY times_checked_out DESC, b.book_title;
