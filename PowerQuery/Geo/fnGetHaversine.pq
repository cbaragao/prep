(lat1 as number, long1 as number, lat2 as number, long2 as number, measure as text)=>

let
    const = Number.PI/180,
    mer_km = 6378.1,
    mer_miles = 3961,

    DTRLAT1 = lat1 * const,
    DTRLAT2 = lat2 * const,
    DTRLONG1 = long1 * const,
    DTRLONG2 = long2 * const,

    haversine = 
                    if measure = "km" then
                        mer_km * Number.Acos(
                            (Number.Sin(DTRLAT1) * Number.Sin(DTRLAT2)) +
                            (Number.Cos(DTRLAT1) * Number.Cos(DTRLAT2) * Number.Cos(DTRLONG2-DTRLONG1))
                        )
                    else  
                        mer_miles * Number.Acos(
                            (Number.Sin(DTRLAT1) * Number.Sin(DTRLAT2)) +
                            (Number.Cos(DTRLAT1) * Number.Cos(DTRLAT2) * Number.Cos(DTRLONG2-DTRLONG1))
                        )


    in   
haversine