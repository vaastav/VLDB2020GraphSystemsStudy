--Trust Triangle Count
select count(*)
  from dataset e1
  join dataset e2 on e1.dst = e2.src 
  join dataset e3 on e2.dst = e3.dst and e3.src = e1.src 

--Cycle Triangle Count
select count(*)
  from dataset e1
  join dataset e2 on e1.dst = e2.src and e1.src < e2.src
  join dataset e3 on e2.dst = e3.src and e3.dst = e1.src and e2.src < e3.src;

