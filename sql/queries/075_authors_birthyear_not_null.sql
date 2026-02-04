-- 75) Authors with known birth year
SELECT au_id, au_fname, au_lname
FROM author
WHERE au_birthyear IS NOT NULL
ORDER BY au_id;
