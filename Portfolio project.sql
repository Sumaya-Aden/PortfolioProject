

Select *
From PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4


--select *
--from PortfolioProject..CovidVaccinations
--order by 3,4



Select location, date, total_cases, New_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2


-- LOOKING AT TOTAL CASES VS TOTAL DEATHS IN EGYPT
-- Shows likelihood of dying if you contract covid in Egypt

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where location like '%egypt%'

order by 1,2


-- LOOKING AT TOTAL CASES VS POPULATION IN EGYPT
-- Shows what percentage of population got covid


Select location, date, total_cases, POPULATION, (total_cases/population)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where location like '%egypt%'

order by 1,2


-- LOOKING AT COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION

Select location, POPULATION, MAX(total_cases) as HighestInfactioncount, MAX(total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--where location like '%egypt%'
Group by Location, Population
order by PercentPopulationInfected desc


-- SHOWING THE COUNTRIES WITH HUGHEST DEATH COUNT PER POPULATION 


Select location,  MAX(cast(total_deaths as int)) as Totaldeathcount
From PortfolioProject..CovidDeaths
--where location like '%egypt%'
Where continent is not null
Group by Location, Population
order by  Totaldeathcount desc




-- LET'S BREAK THINGS DOWN BY CONTINENT 

 
 -- SHOWING CONTINENTS WITH THE HIGHEST DEATH COUNT PER POPULATION 

Select continent, MAX(cast(total_deaths as int)) as Totaldeathcount
From PortfolioProject..CovidDeaths
--where location like '%egypt%'
Where continent is not NULL
Group by continent
order by  Totaldeathcount desc

 
 -- GLOBAL NUMBERS

Select  SUM(new_cases), SUM(CAST (new_deaths as int)), SUM(cast(new_deaths as int))/SUM
   (new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--where location like '%egypt%'
Where continent is not null
--Group by date
order by 1,2


--LOOKING AT POPULATION VS VACCINATION 

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int,vac.new_vaccinations)) over(partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
   on dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null
order by 2,3



