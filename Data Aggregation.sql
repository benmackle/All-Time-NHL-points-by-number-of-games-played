DECLARE sql STRING;

SET sql = (
  SELECT STRING_AGG(
    FORMAT("SELECT * FROM `player_stats.%s`", table_name),
    " UNION ALL "
  )
  FROM `player_stats.INFORMATION_SCHEMA.TABLES`
);

EXECUTE IMMEDIATE FORMAT("""
  CREATE OR REPLACE TABLE combined_stats.big_merge2 AS
  %s
""", sql);