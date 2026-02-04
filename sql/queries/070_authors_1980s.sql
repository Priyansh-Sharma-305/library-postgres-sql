-- 70) Authors born in the 1980s (1980–1989)
SELECT au_id, au_fname, au_lname, au_birthyear
FROM author
WHERE au_birthyear BETWEEN 1980 AND 1989
ORDER BY au_id;
