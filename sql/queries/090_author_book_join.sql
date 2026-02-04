-- 90) Author + Book join (many-to-many via writes)
SELECT
  a.au_lname,
  a.au_fname,
  b.book_num
FROM author a
JOIN writes w ON w.au_id = a.au_id
JOIN book b ON b.book_num = w.book_num
ORDER BY a.au_lname, a.au_fname, b.book_num;
