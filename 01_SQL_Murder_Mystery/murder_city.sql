SELECT *
FROM crime_scene_report
WHERE type='murder' AND city='SQL City' AND date="20180115"
--AND city ='SQL city'
              
              
"Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave"."

SELECT *
FROM person 
JOIN interview ON interview.person_id = person.id
WHERE 
	address_street_name LIKE '%Northwestern Dr%' AND address_number IN (
	  SELECT MAX(address_number) FROM person WHERE address_street_name ='Northwestern Dr')
   OR (address_street_name LIKE '%Franklin Ave%' AND name like '%Annabel%' )
id	name	license_id	address_number	address_street_name	ssn
14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949
16371	Annabel Miller	490173	103	Franklin Ave	318771143


Morty: I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W"

I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

SELECT * 
FROM get_fit_now_member  AS gf
WHERE membership_status="gold" AND id like '48Z%'

id	person_id	name	membership_start_date	membership_status
48Z7A	28819	Joe Germuska	20160305	gold
48Z55	67318	Jeremy Bowers	20160101	gold

SELECT * 
FROM get_fit_now_member  AS gf
JOIN person ON person.id=gf.person_id 
JOIN drivers_license ON drivers_license.id = person.license_id
WHERE membership_status="gold" AND gf.id like '48Z%' AND plate_number LIKE '%H42W%'

SELECT *
FROM get_fit_now_check_in 
JOIN get_fit_now_member ON get_fit_now_member.id=get_fit_now_check_in.membership_id
JOIN person ON person.id = get_fit_now_member.person_id
WHERE check_in_date LIKE '%0109' AND person.name='Annabel Miller'
90081	20180109	1600	1700	90081	16371	Annabel Miller	20160208	gold	16371	Annabel Miller	490173	103	Franklin Ave	318771143
