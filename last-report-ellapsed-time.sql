/* Tiempo sin reportar desde el último reporte, 
ojo: getDate da la hora gmt */

select sensor_serial,datediff(minutes, max(sensor_date),convert_timezone('America/Bogota',getDate())) as diff
from phase1_sensor_measurements
where sensor_serial <> ''
group by sensor_serial;
