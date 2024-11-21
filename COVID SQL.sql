-- select data we're going to use
SELECT location,date,total_cases,new_cases,total_deaths,population
FROM CovidDeaths

-- looking at total cases vs total deaths
SELECT continent,location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_percentage
FROM CovidDeaths
WHERE location = 'Angola';
      
       
-- looking for total_cases vs percentage
SELECT continent,location,date,total_cases,population,(total_deaths/population)*100 as population_percentage
FROM CovidDeaths
WHERE location = 'albania';


-- showing countries with the highest death count per population
SELECT location, MAX(Total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location 
ORDER BY TotalDeathCount DESC;

-- Joins
SELECT *
FROM CovidVaccines
JOIN CovidDeaths
ON CovidVaccines.location = CovidDeaths.location 
    AND CovidVaccines.Date = CovidDeaths.Date;
   
-- CTEs to look for death percentage for people older tha 70 years
WITH totaldeathspercentage AS(
     SELECT continent,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_percentage
     FROM CovidDeaths)
     
SELECT CovidVaccines.aged_70_older,totaldeathspercentage.death_percentage
FROM CovidVaccines
JOIN totaldeathspercentage
ON  totaldeathspercentage.Date = CovidVaccines.Date;
