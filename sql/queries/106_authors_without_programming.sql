-- 106) Authors who have NOT written a book in the 'Programming' subject
SELECT a.au_id, a.au_fname, a.au_lname
FROM author a
WHERE NOT EXISTS (
  SELECT 1
  FROM writes w
  JOIN book b ON b.book_num = w.book_num
  WHERE w.au_id = a.au_id
    AND b.book_subject = 'Programming'
)
ORDER BY a.au_lname, a.au_fname;
