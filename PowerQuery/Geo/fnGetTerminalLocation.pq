(tbl as table, latitude as number, longitude as number, bearing as number, distance as number) as list=>

//Note: This example is using kilometers

// Implementation: 
// On the query click the fx button ("Add Step") on the formula bar and write this after adding this as a function.
// e.g. --> Table.AddColumn({TABLE}, "Destination", each fngetTerminalLocation(QueryFolding, [lat], [long], [bearing], [distance]))
let
    Const_Radius = 6378.1,
    Lat_Radians = latitude/(180/Number.PI),
    Long_Radians = longitude/(180/Number.PI),
    Bearing_Radians = bearing/(180/Number.PI),
    Dest_Latitude = Number.Asin(
                        (
                            Number.Sin(Lat_Radians) *
                            Number.Cos(distance/Const_Radius)
                        )
                        +
                        (
                            Number.Cos(Lat_Radians) *
                            Number.Sin(distance/Const_Radius) *
                            Number.Cos(Bearing_Radians)
                        )
                ),
    Lat_Degrees = Dest_Latitude * (180/Number.PI),
    Dest_Longitude = Long_Radians + 
                        (
                            Number.Atan2(
                                Number.Sin(Bearing_Radians) *
                                Number.Sin(distance/Const_Radius) *
                                Number.Cos(Lat_Radians),
                                Number.Cos(distance/Const_Radius) -
                                Number.Sin(Lat_Radians) *
                                Number.Sin(Dest_Latitude)

                            )
                        ),
    Long_Degrees = Dest_Longitude * (180/Number.PI),
    Results = {Lat_Degrees,Long_Degrees}
in
    Results