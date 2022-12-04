USE fifa19;
-- 1. viewing all the data from database fifa19, player_information table
SELECT * FROM player_info;

-- 2. counting all the data in the palyer_information
SELECT COUNT(*) FROM player_info;

-- 3. getting the player names, age, club and potential form player_information
SELECT Name, 
		Club,
        Age,
        Potential
FROM 	player_info;

-- 4. checking all the data from in fifa19 database, transfer_ values table
SELECT * FROM transfer_values;

-- 5. checking first 10 the players with there ID number, Names and there wage from transfer values
SELECT ID, Name, Wage 
FROM  transfer_values
LIMIT 10;

/* 6. from palyer_info getting the Names of player whose the potential are greater than 90
and there age greater than 28, with limit of 5 */
SELECT Name, 
		Age,
        Potential
FROM 	player_info
WHERE 	potential > 90
ORDER BY Age DESC
LIMIT 10;

-- 7. GETTING THE TOTAL NUMBER OF  DISTINCT NATIONALITY
SELECT 
COUNT(DISTINCT Nationality) AS COUNT
FROM player_info; 

-- 8. GETTING THE TOTAL NUMBER OF PLAYER IN THE FOLLOWING CLUBS(CHELSEA, REAL MADRID, MACHESTER CITY, JUVENTUS AND BARCELONA)
SELECT 		Club,
			COUNT(Club) AS COUNTS 
FROM 		player_info
GROUP BY 	Club
HAVING 		Club IN ('Chelsea', 'FC Barcelona','Juventus','Machester City','Real Madrid') ; 

-- 9. GETTING PLAYER THAT ARE FROM BRAZIL OR ENGLAND THAT THERE ARE ARE BELOW 20 
SELECT * 
FROM 		player_info
WHERE 		Nationality in ('Brazil', 'England')
GROUP BY 	Potential;

-- 10. CHECKING THE ENGLAND TEENAGER THAT ARE LESSER THAN 19YR AND THERE POTENTIAL THAT ARE GREATER THAN  80,
SELECT *
FROM 
(SELECT Name, Age, Nationality, Potential  
FROM 		player_info
WHERE 		(AGE <= 19) & (Potential > 80)) teenage_age
WHERE 		(AGE<19) & (Nationality='England');

-- 11. GETTING SOME PSG PLAYERS THAT THERE ACCELERATION APPROXIMATELY 90
SELECT 		Name, 
			Club, 
            Potential
FROM 		player_info
WHERE (Club='Paris Saint-Germain') & (potential BETWEEN 85 AND 94);

-- 12.  GETTING SOME PLAYER THAT HAVE RONALDO OR FILIPE IN THERE NAME
SELECT * 
FROM 		player_info
WHERE 		Name LIKE '%Ronaldo%' OR Name LIKE '%Filipe%'
ORDER BY 	Age DESC;

-- 13. GETTING SOME CLUB TEAM THAT START FC OR AS AND CLUB TEAM THAT END WITH CITY OR CLUB
 SELECT 	Name, 
			Nationality, 
            Club, 
            Potential
 FROM 		player_info
 WHERE 		Club REGEXP '^FC|AS' OR Club REGEXP 'CITY|CLUB$'
 ORDER BY 	Potential DESC, Age;

-- 14. GETTING PLAYER INFORMATION AND  WAGES 
SELECT 		transfer_values.Name, 
			Age, 
            Potential, 
            Nationality, 
            Club, 
            Wage
FROM player_info
JOIN transfer_values ON 
player_info.ID = transfer_values.ID
ORDER BY Potential DESC;

-- 15. USING A SELF JOIN
SELECT 		ir.Name, 
			ir.Special, 
            ir.Position, 
            ir.`Jersey Number`, 
            jn.`International Reputation`
FROM player_preference ir
JOIN player_preference jn
	ON ir.`International Reputation` = jn.`Jersey Number`;

-- 16. GETTING PLAYERS ALL INFORMATIONS FROM THREE DIFFERENT TABLES
SELECT 		pi.Name, 
			Nationality, 
            Club, 
            Potential,
            tv.Special,
            Wage, 
            `Jersey Number`, 
            `Preferred Foot`,
            Position
 FROM player_info pi
JOIN transfer_values tv
	ON pi.Player_Ranks = tv.ID
JOIN player_preference pp
	ON pi.Player_Ranks = pp.Filled_No
ORDER BY tv.Special DESC;

-- 17. GETTING HOW FIT SPAINNISH PLAYERS ARE, AND THERE TRANSFER VALUES, THROUGH THERE CLUB AND AGE
SELECT  	pi.Name,
			Nationality,
            Club,
            Age,
            `Work Rate`,
            Weight,
            Value,
            Wage            
FROM player_info pi
  LEFT JOIN players_body_info pbi
	ON pi.ID = pbi.player_Ranks
 JOIN transfer_values tv
	ON pbi.player_Ranks = tv.filled_No
WHERE Nationality = 'Spain'
ORDER BY Age DESC, Club;

-- 18 GETTING PLAYER JERSEY 7 NUMBER  AND WEIGHT GREATER THAN 150LBS
SELECT pp.Name, 
		Special,
        `Jersey Number`, 
        Height, 
        Weight 
        FROM 
player_preference pp
JOIN players_body_info pbi
ON pp.Filled_No = pbi.Player_Ranks
WHERE `Jersey Number`=7
ORDER BY Weight > 150 DESC;

-- 19. GETTING HOW BETTER POTENTIAL OF BRAZIL AND ARGENTINA PLAYER WITH THERE WAGES 
SELECT * FROM
(SELECT 		transfer_values.Name, 
			Age, 
            Potential, 
            Nationality, 
            Club, 
            Wage
FROM player_info
JOIN transfer_values ON 
player_info.ID = transfer_values.ID
WHERE Nationality = 'Brazil'
UNION
SELECT 		transfer_values.Name, 
			Age, 
            Potential, 
            Nationality, 
            Club, 
            Wage
FROM player_info
JOIN transfer_values ON 
player_info.ID = transfer_values.ID
WHERE Nationality = 'Argentina') Brazil_argentina
ORDER BY Potential DESC;

-- 20. ARRANGING PLAYERS ACCORDING TO THERE AGE FOR CONTRACT RENEWER
SELECT Name, 
		Age, 
        Club, 
        Overall,
        'Almost Retiring' AS 'Age Limits'
FROM player_info
WHERE Age > 32
UNION
SELECT Name, 
		Age, 
        Club, 
        Overall,
        'Matured Players' AS 'Age Limits'
FROM player_info
WHERE Age BETWEEN 22 AND 31
UNION
SELECT Name, 
		Age, 
        Club, 
        Overall,
        'Developing Players' AS 'Age Limits'
FROM player_info
WHERE Age < 21
ORDER BY Overall DESC;