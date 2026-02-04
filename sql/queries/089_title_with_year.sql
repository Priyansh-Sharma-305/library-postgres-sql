-- 89) Build a combined display field: "Title (Year)"
SELECT
  book_num,
  (book_title || ' (' || book_year || ')') AS book,
  book_subject
FROM book
ORDER BY book_num;
