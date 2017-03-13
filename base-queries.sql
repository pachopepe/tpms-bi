/* Select sensor_date with next sensor date pairs */
select sensor_serial,plate,tire_position,sensor_date,lead(sensor_date) over (partition by sensor_serial order by sensor_date)  as next_date
from phase1_sensor_measurements
where sensor_serial <> ''
order by sensor_serial,sensor_date,plate,tire_position


/* Select sensor_date with next sensor date pairs, with current date when null
   -- in postgresql use clock_timestamp instead of getdate
 */
select sensor_serial,plate,tire_position,sensor_date,coalesce(lead(sensor_date) over (partition by sensor_serial order by sensor_date),getdate())  as next_date
from phase1_sensor_measurements
where sensor_serial <> ''
order by sensor_serial,sensor_date,plate,tire_position


/* Select sensor_date with next sensor date pairs, 
   with current date when next sensor date is null
   -- in postgresql use clock_timestamp instead of getdate
 */
select sensor_serial,plate,tire_position,coalesce(lead(sensor_date) over (partition by sensor_serial order by sensor_date),getdate()) - sensor_date  as next_date
from phase1_sensor_measurements
where sensor_serial <> ''
order by sensor_serial,sensor_date,plate,tire_position

/* Select diff times of sensor_date with next sensor date, 
   current date when nest date is null
   -- in postgresql use clock_timestamp instead of getdate
 */
select sensor_serial,plate,tire_position,datediff(minutes,sensor_date,coalesce(lead(sensor_date) over (partition by sensor_serial order by sensor_date),getdate()) as diff
from phase1_sensor_measurements
where sensor_serial <> ''
order by sensor_serial,sensor_date,plate,tire_position
