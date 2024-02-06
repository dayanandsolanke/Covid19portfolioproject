
select * from 
portfolioproject ..CovidDeaths
order by 3,4

select * from 
portfolioproject ..covidvaccination
order by 3,4

select Location,date, total_cases, new_cases, total_deaths, population
 from portfolioproject ..CovidDeaths
 order by 1,2

 -- Looking at Total cases vs total deaths
 -- shows likelihood of dying if you contract covid in your country

select location , date,total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
 from portfolioproject..CovidDeaths
 where location like '%india%'
 order by 1,2

 -- Looking at total cases vs population
 -- shows what percentage of population got covid

 select location , date, population,total_cases,(total_cases/population)*100 as Infectedpercent
 from portfolioproject..CovidDeaths
 where location like '%india%'
 order by 1 ,2
 
 --Looking at the countries with Highest Infection Rate compared to population

 select  location , population,MAX(total_cases)as HighestInfectionCount,MAX((total_cases/population))*100 as Infectedpercentage
 from portfolioproject..CovidDeaths
 Group by location , population
 order by Infectedpercentage DESC

 -- Showing countries with highest death count per population

 select Location, MAX(cast(Total_deaths as int)) as TotalDeathcount
 from portfolioproject..CovidDeaths
 where continent is not null
 group by location
 order by TotalDeathcount desc

 -- Lets break things down ny continent

 select continent, MAX(cast(Total_deaths as int)) as TotalDeathcount
 from portfolioproject..CovidDeaths
 where continent is not null
 group by continent
 order by TotalDeathcount desc

 -- showing the continent with highest deat count per population
 
 select continent , max(cast(total_deaths as int)) as totaldeathcount
 from portfolioproject..CovidDeaths
 where continent is not null 
 group by continent
 order by  totaldeathcount desc

-- Global numbers

select sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_deaths,sum(cast(new_deaths as int))/sum(new_cases) *100 as deathpercentage
From portfolioproject..CovidDeaths
where continent is not null
--group by date
order by 1,2



-- joining the two tables
-- looking at total population vs vaccinations

select  dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations)) OVER (partition by dea.Location ORDER BY dea.location, dea.date)
from portfolioproject..CovidDeaths dea
join portfolioproject..covidvaccination vac
    on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 2,3

	
