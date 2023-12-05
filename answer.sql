-- TYPE YOUR SQL QUERY BELOW

-- PART 1: Create a SQL query that maps out the daily average users before and after the feature change


-- Overall Daily Average Users
SELECT 'Overall' AS Analysis_Type,strftime('%m-%d-%Y', DATETIME(login_timestamp, 'unixepoch')) AS Day, COUNT(*) AS Daily_Users FROM login_history GROUP BY Analysis_Type, Day

UNION

-- Overall Average Daily Users
SELECT 'Overall' AS Analysis_Type, NULL AS Day, AVG(dayCount) AS Average_Daily_Users
FROM (
    SELECT COUNT(*) AS dayCount FROM login_history
    GROUP BY strftime('%m-%d-%Y', DATETIME(login_timestamp, 'unixepoch'))
)

UNION

-- Before Feature Change Daily Average Users
SELECT 'Before Feature Change' AS Analysis_Type, strftime('%m-%d-%Y', DATETIME(login_timestamp, 'unixepoch')) AS Day, COUNT(*) AS Daily_Users
FROM login_history WHERE login_timestamp < 1527898041 GROUP BY Analysis_Type, Day

UNION

-- Before Feature Change Average Daily Users
SELECT 'Before Feature Change' AS Analysis_Type, NULL AS Day, AVG(dayCount) AS Average_Daily_Users
FROM (
    SELECT COUNT(*) AS dayCount FROM login_history 
    WHERE login_timestamp < 1527898041 GROUP BY strftime('%m-%d-%Y', DATETIME(login_timestamp, 'unixepoch'))
)

UNION

-- After Feature Change Daily Average Users
SELECT 'After Feature Change' AS Analysis_Type, strftime('%m-%d-%Y', DATETIME(login_timestamp, 'unixepoch')) AS Day, COUNT(*) AS Daily_Users
FROM login_history WHERE login_timestamp > 1527898040 GROUP BY Analysis_Type, Day

UNION

-- After Feature Change Average Daily Users
SELECT 'After Feature Change' AS Analysis_Type, NULL AS Day, AVG(dayCount) AS Average_Daily_Users
FROM (
    SELECT COUNT(*) AS dayCount FROM login_history
    WHERE login_timestamp > 1527898040 GROUP BY strftime('%m-%d-%Y', DATETIME(login_timestamp, 'unixepoch'))
);



-- PART 2: Create a SQL query that indicates the number of status changes by card


-- Count the number of status changes by card
SELECT cardID, COUNT(*) AS Status_Changes FROM card_change_history 
WHERE oldStatus != newStatus GROUP BY cardID;



-- These queries provide insights into the daily average users and status changes
-- for each card in Shiptivity application.
