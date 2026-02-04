-- 72) Patrons who are students (case-insensitive)
SELECT pat_id, pat_fname, pat_lname
FROM patron
WHERE LOWER(pat_type) = 'student'
ORDER BY pat_id;
