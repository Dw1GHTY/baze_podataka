--VKLUB JEDNOSTAVNI UPITI-------------------------------------------------------------------------------------------------------------------
--1):
select tip from film;
--2):
select * from glumac
where broj = 38;
--3):
select broj, naslov from film
where godina between 1965 and 1975;
--4):
select ime, godina_rod, mesto_rod
from glumac where godina_sm is null;
--5):
select ime, (godina_sm - godina_rod) as godine
from reziser
where godina_sm is not null;
--6):
select broj, naslov
from film 
where aa_nominacije > 0;
--7):
select sum(aa_nagrade) ukupno_nagrada
from film
where tip = 'comedy';
--8):
select count(*) as broj_igranih_filmova
from igra 
where glumac = 50;
--9):
select distinct clan
from iznajmljivanje
where datum_vracanja is null;
--10):
select max(broj_diskova), min(broj_diskova), avg(broj_diskova)
from film;
--11):
select broj, naslov 
from film
where naslov like '%bird%';
--12):
select ime ||' '|| prezime as IME, godina_rod
from glumac
where broj = 50;
--1.1):
select ime ||' '|| prezime as IME
from glumac
where godina_rod > 1920;
--1.2):
select glumac 
from igra
where film between 85 and 91;
--1.3):
select broj, naslov
from film
where tip like 'comedy' and aa_nagrade is not null;
--1.4):
select count(*) as broj_filmova
from iznajmljivanje
where clan = 3;
--1.5):
select broj, naslov
from film
where tip like 'comedy' and (aa_nagrade is not null) and naslov not like '%uncle%' and godina > 1970;

--VKLUB SLOZENI UPITI-------------------------------------------------------------------------------------------------------------------------------------------------
--1):
select g.ime
from glumac g
join igra i on i.glumac = g.broj
join film f on f.broj = i.film
where uloga like 'Vronsky' and f.naslov like 'Ana karenina';
--2):
select tip, count(*) as broj_filmova
from film 
group by tip
having count(*) > 5
order by count(*) desc;
--3):
select f.broj, f.naslov
from film f
join igra i on i.film = f.broj
join glumac g on g.broj = i.glumac
join reziser r on r.broj = f.reziser
where r.ime like 'Emir' and r.prezime like 'Kusturica' and g.ime like 'Slavko' and g.prezime like 'Stimac';
--4):
select r.broj, r.ime ||' '|| r.prezime as IME, r.godina_rod, r.godina_sm  
from film f
join reziser r on r.broj = f.reziser
where f.tip like 'comedy' 
INTERSECT
select r.broj, r.ime ||' '|| r.prezime as IME, r.godina_rod, r.godina_sm  
from film f
join reziser r on r.broj = f.reziser
where f.tip like 'drama';
--5):
select broj, naslov
from film
MINUS
select f.broj, f.naslov
from film f
join iznajmljivanje i on i.film = f.broj;
--7):
select r.ime ||' '|| r.prezime as IME, count(*) as broj_filmova
from reziser r 
join film f on f.reziser = r.broj
group by r.broj, r.ime ||' '|| r.prezime
having count(*) = (select count(*) as broj_filmova
                   from reziser r join film f on f.reziser = r.broj
                   where r.broj = 15);
--8):
select * from(
select r.broj, r.ime, r.prezime, f.tip, count(*) as broj_drama
from reziser r 
join film f on f.reziser = r.broj
where f.tip like 'drama'
group by r.broj, r.ime, r.prezime, f.tip
order by count(*) desc
)
where rownum = 1;

--8):
select f.naslov, r.ime ||' '|| r.prezime as IME
from film f
join reziser r on r.broj = f.reziser;

--1.2)
select distinct f.broj, f.naslov  --distinct zbog joinova mrzelo te da prepravljas
from film f
join igra i on i.film = f.broj
join glumac g on g.broj = i.glumac
join reziser r on r.broj = f.reziser
where r.ime like 'Emir' and r.prezime like 'Kusturica' and not(g.ime like 'Mira' and g.prezime like 'Banjac');
--1.3):
select broj, ime, prezime 
from clan
where broj not in(select clan.broj 
                  from clan, iznajmljivanje
                  where clan.broj = iznajmljivanje.clan);
                  
                  
                  
                  
                  
            
                  
                  
                  
                  
                  

