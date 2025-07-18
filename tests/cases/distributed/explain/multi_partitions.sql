CREATE TABLE multi_partitions_test_table (
    host STRING,
    ts TIMESTAMP,
    cpu DOUBLE NULL,
    memory DOUBLE NULL,
    disk_util DOUBLE DEFAULT 9.9,
    TIME INDEX (ts),
    PRIMARY KEY(host)
)
PARTITION ON COLUMNS (host) (
    host < '550-A',
    host >= '550-A' AND host < '550-W',
    host >= '550-W'
);

-- SQLNESS REPLACE (-+) -
-- SQLNESS REPLACE (\s\s+) _
-- SQLNESS REPLACE (peers.*) REDACTED
explain SELECT * FROM multi_partitions_test_table WHERE ts > cast(1000000000 as timestamp) ORDER BY host;

drop table multi_partitions_test_table;
