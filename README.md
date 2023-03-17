# Reproduction of issue

1. Clone this repository
2. Run `docker compose build` followed by `docker compose up`
3. To get an SQL terminal, run ` docker exec -it mobilitydb-docker-mobilitydb-1 psql -h localhost -U docker -d mobilitydb`
4. Execute the query `SELECT astext(unnest(sequences(atGeometry(
  tgeompoint 'SRID=3034;[POINT(4000057.578 3446790.129)@2021-03-30 18:09:30+00,
  POINT(4000057.579 3446699.798)@2021-03-30 18:09:36+00, POINT(4000057.579 3446663.579)@2021-03-30 18:09:40+00,
  POINT(4000057.581 3446573.248)@2021-03-30 18:09:46+00, POINT(4000057.581 3446537.137)@2021-03-30 18:09:50+00,
  POINT(4000057.582 3446500.918)@2021-03-30 18:09:52+00, POINT(4000057.582 3446464.807)@2021-03-30 18:09:56+00,
  POINT(4000057.584 3446356.368)@2021-03-30 18:10:04+00]',
  ST_MakeEnvelope(4000000, 3445000, 4005000, 3450000, 3034)))));`, expected result is one row resturned, issue is present if three rows are returned.