DROP TABLE IF EXISTS TimePeriods;


CREATE TEMP TABLE TimePeriods
(
StartDate  DATE,
EndDate    DATE,
PRIMARY KEY (StartDate, EndDate)
);


INSERT INTO TimePeriods (StartDate, EndDate) VALUES
('1/1/2018','1/5/2018'),
('1/3/2018','1/9/2018'),
('1/10/2018','1/11/2018'),
('1/12/2018','1/16/2018'),
('1/15/2018','1/19/2018');

WITH cte AS 
(	SELECT t1.StartDate AS startA,
			t1.EndDate AS endA,
			t2.StartDate AS startB,
			t2.EndDate AS endB
	FROM TimePeriods t1
	LEFT JOIN TimePeriods t2 
	ON t1.EndDate > t2.StartDate AND t1.EndDate <= t2.EndDate AND t1.StartDate <> t2.StartDate
)
select * FROM cte 

 