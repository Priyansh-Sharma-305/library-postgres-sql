-- 83) Number of distinct patrons who have checkout records
SELECT COUNT(DISTINCT pat_id) AS different_patrons
FROM checkout;
