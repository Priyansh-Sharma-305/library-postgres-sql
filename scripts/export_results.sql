\pset pager off
\set ON_ERROR_STOP on

\copy (SELECT book_subject, ROUND(AVG(book_cost), 2) AS avg_cost FROM book GROUP BY book_subject ORDER BY avg_cost DESC) TO '/results/subject_avg_cost.csv' CSV HEADER;

\copy (SELECT b.book_num, b.book_title, COALESCE(COUNT(c.check_num), 0) AS times_checked_out FROM book b LEFT JOIN checkout c ON c.book_num = b.book_num GROUP BY b.book_num, b.book_title ORDER BY times_checked_out DESC, b.book_title) TO '/results/times_checked_out.csv' CSV HEADER;