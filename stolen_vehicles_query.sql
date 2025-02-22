use stolen_vehicles_db;

select * from stolen_vehicles;
select * from make_details;
select * from locations;

-- Add day_name column

alter table stolen_vehicles add column day_name varchar(10);

update stolen_vehicles
set day_name = dayname(date_stolen);
select * from stolen_vehicles;

-- What day of the week are vehicles most often and least often stolen?

select count(*) as total_vehicles , day_name from stolen_vehicles
group by day_name
order by total_vehicles desc;

-- Monday is the day when vehicles are stolen the most often and Saturday is the day when vehicles are stolen the least often.


-- What types of vehicles are most often and least often stolen? Does this vary by region?

select count(*) as total_vehicles, vehicle_type from stolen_vehicles
group by vehicle_type
order by total_vehicles desc;

-- The most often stolen vehicle type is Statiowagon and the least often stolen vehicle type is Articulated Truck.

select  region, vehicle_type, count(*) as total_vehicles  from stolen_vehicles sv
left join locations lo
	on sv.location_id = lo.location_id
group by region, vehicle_type
order by total_vehicles desc;

-- Vehicle type doesn't vary very much between different regions. 

-- What is the average age of the vehicles that are stolen? Does this vary based on the vehicle type?

select round(avg(model_year)) as averge_year from stolen_vehicles;

-- The average age of the stolen vehicles is of 2005 model year.

select vehicle_type, round(avg(model_year)) as averge_year from stolen_vehicles
group by vehicle_type
order by averge_year desc;

-- Each vehicle type has different average age than other vehicle types.


-- Which regions have the most and least number of stolen vehicles? What are the characteristics of the regions?

select region, count(*) as total_vehicles  from stolen_vehicles sv
left join locations lo
	on sv.location_id = lo.location_id
group by region
order by total_vehicles desc;

-- Auckland has the most number of stolen vehicles, where Southland has the least number of stolen vehicles.

select * from locations
where region in ('Auckland', 'Southland');