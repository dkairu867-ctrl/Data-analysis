USE TravelCx_Analytics;
GO
SELECT 
    c.CountryName,
    c.Continent,
    c.Region,
    COUNT(DISTINCT d.BookingID) AS TotalVisits,
    SUM(d.AccommodationCost) AS TotalAccommodationRevenue,
    CAST(AVG(d.AccommodationCost) AS DECIMAL(10,2)) AS AvgAccommodationCost,
    MIN(d.AccommodationCost) AS MinCost,
    MAX(d.AccommodationCost) AS MaxCost,
    CAST(STDEV(d.AccommodationCost) AS DECIMAL(10,2)) AS CostStdDeviation,
    AVG(DATEDIFF(DAY, d.ArrivalDate, d.DepartureDate)) AS AvgLengthOfStayDays,
    CAST( COUNT(DISTINCT d.BookingID) * 100.0 / (SELECT COUNT(*) FROM dbo.Destination) 
    AS DECIMAL(5,2)) AS MarketSharePct
FROM dbo.Destination d
JOIN dbo.Country c ON d.CountryID = c.CountryID
JOIN dbo.Booking b ON d.BookingID = b.BookingID
WHERE b.BookingStatus = 'Completed'
GROUP BY c.CountryName, c.Continent, c.Region
HAVING COUNT(DISTINCT d.BookingID) >=5
ORDER BY TotalVisits DESC;
