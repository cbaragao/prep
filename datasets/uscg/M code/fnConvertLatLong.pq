(coordinate as number, multiply as number, direction_column as text)=>

let
    Source =  try if coordinate <> null then coordinate else coordinate otherwise 0,
    MultiplyBy = try Source * multiply otherwise Source,
    Final = try
                if direction_column = "S" 
            
                then -1 * MultiplyBy

                else if direction_column = "W" 
                
                then -1 * MultiplyBy
            
                else MultiplyBy
            
            otherwise Source
in 
    Final