\set ON_ERROR_STOP on

\echo 'Creating schema...'
\i /sql/00_schema.sql

\echo 'Loading data...'
\i /sql/01_load_data.sql

\echo 'Running data quality checks...'
\i /sql/queries/000_data_quality_checks.sql

\echo 'Running sample queries...'
\pset pager off
\x off
\timing on

\echo '--- 056_books_sorted ---'
\i /sql/queries/056_books_sorted.sql

\echo '--- 090_author_book_join ---'
\i /sql/queries/090_author_book_join.sql

\echo '--- 098_times_checked_out_per_book ---'
\i /sql/queries/098_times_checked_out_per_book.sql

\echo '--- 106_authors_without_programming ---'
\i /sql/queries/106_authors_without_programming.sql

\echo '--- 107_book_vs_subject_avg_cost ---'
\i /sql/queries/107_book_vs_subject_avg_cost.sql