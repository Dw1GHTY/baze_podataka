 --b):
--select ks.naziv, kp.naziv, kodob.dat_kreiranja 
--from 
--racun r inner join kompanija ks on r.komp_salje = ks.id
--inner join kompanija kp on r.komp_prima = kp.id
--inner join knjiznoodobrenje kodob on r.id = kodob.id_racuna
--where r.iznos > 50000
--order by kodob.dat_kreiranja desc



--d):
--select ks.id, count(*), sum(ks.id)
----from racun r
--inner join kompanija ks on r.komp_salje = ks.id
--inner join knjiznoodobrenje k_odob on k_odob.id_racuna = r.id
--group by ks.id

--select valuta, to_char(dat_placanja, 'MON'), sum(iznos + porez) as Zbir, count(*) as BrRedova

--from racun
-- by valuta, to_char(dat_placanja, 'MON')

--select id, valuta, dat_placanja, dat_kreiranja, porez
--from racun
--where porez >
--(
--    select round(avg(porez)) 
--    from racun)

--select * 
--from racun r
--join knjiznoodobrenje ko on r.id = ko.id_racuna
--join kompanija ks on r.komp_salje = ks.id



--select r.komp_salje as SaljeID, ks.naziv as Salje, kp.naziv as Prima, count(*)
--from racun r
--join kompanija ks on r.komp_salje = ks.id
--join kompanija kp on r.komp_prima = kp.id
--join knjiznoodobrenje ko on ko.id_racuna = r.id
--where kp.naziv like '%ace%' and ko.um_iznos>6300
--group by r.komp_salje, ks.naziv, kp.naziv
--having count(*)>1


--select k.naziv, k.id, count(*)
--from kompanija k
--join racun r on r.komp_salje = k.id
--join knjiznoodobrenje o on o.id_racuna = r.id
--where (o.dat_kreiranja - r.dat_kreiranja) > 10
--group by k.id, k.naziv
--order by count(*) desc


--DRAZA
select *
from(
    select kl.id, kl.naziv, kl.lokacija, cl.tim, count(*), avg(s.plata) as AvgPlata
    FROM klub kl
    inner join clan cl on cl.id_kluba=kl.id
    inner join sportista s on cl.id_sportiste = s.id
    --where kl.sport='Fudbal'
    GROUP BY kl.id, kl.naziv, kl.lokacija, cl.tim
    );

--having  count(cl.tim)>1 



select k.naziv, k.lokacija, count(*) --count se ne trazi na prikazu pa se brise
from clan c
join klub k on k.id = c.id_kluba
join sportista s on s.id = c.id_sportiste
where k.sport = 'Fudbal' and c.tim = 'mladi' and s.plata > 
    (
        select avg(plata)
        from 
        (
            select * 
            from sportista s
            join clan c on c.id_sportiste = s.id
            where not (s.grad = 'Novi Sad' and s.plata > 20000) and c.tim = 'prvi'
        )
        where datum_do is not null and c.tim = 'prvi'
    )
group by k.naziv, k.lokacija
having count(*) > 1;




select k.naziv, k.lokacija, count(*) --count se ne trazi na prikazu pa se brise
from clan c
join klub k on k.id = c.id_kluba
join sportista s on s.id = c.id_sportiste
where k.sport = 'Vaterpolo' and c.tim = 'mladi' 
and s.plata 
    >(select avg(plata)
     from clan c
     join sportista s on s.id = c.sportista_id
     where c.tim = 'prvi' and datum_do is null and 
        (select * from  klub k
         join clan c on c.id_kluba = k.id
         join sportista s on s.id = c.id_sportiste
         where not (s.grad = 'Novi Sad' and s.plata > 2000)
        )     
group by k.naziv, k.lokacija
having count(*) > 1;

--view:
create view igrac_stat as
    (select s.ime, s.prezime, extract(year from sysdate)-s.god_rod as starost, s.plata, count(k.id) as broj_klubova
    from sportista s
    join clan c on c.id_sportiste = s.id
    join klub k on k.id = c.id_kluba
    group by s.id, s.ime, s.prezime, extract(year from sysdate)-s.god_rod, s.plata)
    
select  ime, prezime, starost, plata, broj_klubova
from igrac_stat
where broj_klubova > 1


--update:
update sportista 
set plata = plata*0.97
where id in (select sportista.id from
            sportista, klub, clan
            where sportista.id = clan.id_sportiste
            and klub.id = clan.id_kluba
            and klub.lokacija = 'Minhen' 
            and clan.tim = 'prvi'               
            );
--delete:
delete from sportista
where id in (
            select sportista.id from
            sportista, klub, clan
            where sportista.id = clan.id_sportiste
            and klub.id = clan.id_kluba
            and (extract(year from sysdate) - klub.god_osnivanja)>20
            and clan.tim = 'skola'
            and not (exists clan.tim = 'mladi')
            )

update knjiznoodobrenje
set um_iznos = um_iznos * 1.05
where id in (select knjiznoodobrenje.id
             from knjiznoodobrenje, racun, kompanija
             where knjiznoodobrenje.id_racuna = racun.id
             and racun.komp_prima = kompanija.id
             and racun.valuta = 'RSD'
             and kompanija.grad = 'Nis'
            );
            
delete from knjiznoodobrenje
where id in (select knjiznoodobrenje.id
             from knjiznoodobrenje, racun, kompanija
             where knjiznoodobrenje.id_racuna = racun.id
             and racun.komp_salje = kompanija.id
             and kompanija.grad = 'Nis'
             and (sysdate - racun.dat_kreiranja) < 6
            )
            
--OKT18):
--2):
select distinct u.naziv, count(*) as sa_preko_1000
from ucesnik u
join rezultati r on r.id_ucesnik = u.id
join biracko_mesto b on b.id = r.id_biracko_mesto
where r.broj_glasova > 1000
group by u.id, u.naziv
having count(*) > 0;

--3):
select b.id, b.opstina, b.adresa, sum(r.broj_glasova)
from biracko_mesto b
join rezultati r on r.id_biracko_mesto = b.id
join ucesnik u on u.id = r.id_ucesnik
group by b.id, b.opstina, b.adresa
having sum(r.broj_glasova) > 5000
order by b.adresa asc;

--4):



--5):
select u.naziv, sum(r.broj_glasova) as ukupno_glasova
from biracko_mesto b
join rezultati r on r.id_biracko_mesto = b.id
join ucesnik u on u.id = r.id_ucesnik
where rownum = 1
group by u.id, u.naziv
order by sum(r.broj_glasova) desc;


--6):
create view UCESNIK_STATISTIKA
as
(
    select u.naziv, u.redni_broj, sum(r.broj_glasova) as ukupno, avg(r.broj_glasova) as prosecno
    from ucesnik u
    join rezultati r on r.id_ucesnik = u.id
    join biracko_mesto b on b.id = r.id_biracko_mesto
    where u.naziv like '%Srbija%'
    group by b.id, u.naziv, u.redni_broj
);
select naziv, redni_broj
from ucesnik_statistika
where rownum = 1
order by prosecno desc;


--7):
update ucesnik u
set u.redni_broj = 1000
where id in 
(
    select ucesnik.id , count(*)
    from ucesnik, biracko_mesto, rezultati
    where ucesnik.id = rezultati.id_ucesnik
    and biracko_mesto.id = rezultati.id_biracko_mesto
    group by ucesnik.id
    having count(*) > 0
);

--8):

