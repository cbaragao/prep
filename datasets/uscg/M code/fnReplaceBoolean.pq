// Author: Chris Aragao
// Date: 8.31.2022
// Purpose: Replace Y, N, X and nulls with numbers for easier filtering
// Notes:   A lot of columns have Y/N values, or X if it is true.
//          This function replaces Y or X with 1,
//          N with 0
//          and null/blank with -1

// CHANGELOG
//----------------
// 8.31.2022: Initial documentation provided.

(STRING as text, TRUE_VALUE as text, optional FALSE_VALUE as text)=>

let
    Source = if STRING = null then "-1" else Text.From(STRING),
    ReplaceVals = 
    
                if STRING = TRUE_VALUE
                    then Text.Replace(Source, TRUE_VALUE, "1")
                else if STRING = FALSE_VALUE and FALSE_VALUE <> null
                    then Text.Replace(Source, FALSE_VALUE, "0")
                else
                    -1   
in
    ReplaceVals