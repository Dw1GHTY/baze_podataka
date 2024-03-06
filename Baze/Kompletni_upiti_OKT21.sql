--2):
select k.naziv ||' '|| k.lokacija as Naziv_i_Lokacija, k.god_osnivanja
from klub k 
where (extract(year from sysdate) - k.god_osnivanja) > 20
order by god_osnivanja desc;
--3):
select s.ime, s.prezime, c.tim
from sportista s
join clan c on c.id_sportiste = s.id
join klub k on k.id = c.id_kluba
where (extract(year from sysdate) - s.god_rod)<30 and c.datum_do is null and s.grad != k.lokacija;
--4):
select * from
(
select k.naziv, k.sport, count(*) as broj_clanova
from klub k
join clan c on c.id_kluba = k.id
join sportista s on s.id = c.id_sportiste
where (extract(year from sysdate) - s.god_rod)<15 and c.tim = 'skola'
group by k.id, k.naziv, k.sport
order by count(*) desc
) where rownum = 1;
--5):
select k.naziv, k.lokacija
from klub k
join clan c on c.id_kluba = k.id
join sportista s on s.id = c.id_sportiste
where k.sport like 'Vaterpolo';

--6):view
create view igrac_stat
as
(
    select s.ime, s.prezime, (extract(year from sysdate)-s.god_rod) as starost, s.plata, count(distinct k.id) as broj_klubova
    from sportista s
    join clan c on c.id_sportiste = s.id
    join klub k on k.id = c.id_kluba
    group by s.id, s.ime, s.prezime, (extract(year from sysdate)-s.god_rod), s.plata
);
select *
from igrac_stat
where broj_klubova > 1;
--7):
update sportista s
set s.plata = s.plata*0.97
where s.id in (select *
               from sportista, clan, klub
               where sportista.id = clan.id_sportiste 
               and klub.id = clan.id_kluba
               and clan.tim like 'prvi' and klub.sport like 'Odbojka');
--8):
delete 
from sportista
where sportista.id in 
      (select sportista.id
       from sportista, klub, clan
       where sportista.id = clan.id_sportiste
       and klub.id = clan.id_kluba
       and (extract(year from sysdate)- klub.god_osnivanja > 20
       and clan.tim like 'skola'
       and not exists(clan.tim like 'mladi')
       );




