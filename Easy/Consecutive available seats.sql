-- Question 37
-- Several friends at a cinema ticket office would like to reserve consecutive available seats.
-- Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
-- | seat_id | free |
-- |---------|------|
-- | 1       | 1    |
-- | 2       | 0    |
-- | 3       | 1    |
-- | 4       | 1    |
-- | 5       | 1    |
 

-- Your query should return the following result for the sample case above.
 

-- | seat_id |
-- |---------|
-- | 3       |
-- | 4       |
-- | 5       |
-- Note:
-- The seat_id is an auto increment int, and free is bool ('1' means free, and '0' means occupied.).
-- Consecutive available seats are more than 2(inclusive) seats consecutively available.

-- Solution
Select seat_id
from(
select seat_id, free,
lead(free,1) over() as next,
lag(free,1) over() as prev
from cinema) a
where a.free=True and (next = True or prev=True)
order by seat_id


#logic 2 
 With t1 as (
Select * , row_number() over ( order by seat_id) as rw,
 (seat_id - row_number() over ( order by seat_id) ) as grp from cinema where free = 1)
select seat_id from(select * , count(*) over (partition by grp) as cnt from t1) where cnt > 1

#logic 3
#using inner join
 
select distinct c1.seat_id
from cinema c1 inner join cinema c2
on (c1.seat_id+1=c2.seat_id or c1.seat_id-1=c2.seat_id)
where c1.free=1 
and c2.free=1
order by c1.seat_id
;


