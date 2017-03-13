/* Tiempo máximo sin reportar */

select sensor_serial,max(diff) 
from  (select sensor_serial,plate,tire_position,
       datediff(minutes,sensor_date,coalesce(lead(sensor_date) over (partition by sensor_serial order by sensor_date),convert_timezone('America/Bogota',getDate()))) as diff
       from phase1_sensor_measurements
       where sensor_serial <> ''
       order by sensor_serial,sensor_date,plate,tire_position)
group by sensor_serial

