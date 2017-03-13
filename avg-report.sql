/* Tiempo promedio que toma en reportar cada sensor */

select sensor_serial,avg(diff) 
from (select sensor_serial,plate,tire_position,
             datediff(minutes,sensor_date,lead(sensor_date) over (partition by sensor_serial order by sensor_date)) as diff
      from phase1_sensor_measurements
      where sensor_serial <> ''
      order by sensor_serial,sensor_date,plate,tire_position)
group by sensor_serial


