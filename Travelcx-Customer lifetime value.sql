SELECT 
    t.LoyaltyTier,
    COUNT(DISTINCT t.TravelerID) AS TotalTravelers,
    COUNT(b.BookingID) AS TotalBookings,
    SUM(CASE WHEN b.BookingStatus = 'Completed' THEN b.TotalCost ELSE 0 END) AS TotalRevenue,
    AVG(CASE WHEN b.BookingStatus = 'Completed' THEN b.TotalCost ELSE 0 END) AS AvgBookingValue
FROM dbo.Traveler t
LEFT JOIN dbo.Booking b ON t.TravelerID = b.TravelerID
GROUP BY t.LoyaltyTier
ORDER BY TotalRevenue DESC;
