//Get Difference Between Two Strings
(STRING_ONE as text, STRING_TWO as text)=>
let 
    // Split strings into list by each character
    FirstSplit = Splitter.SplitTextByRepeatedLengths(1)(STRING_ONE),
    SecondSplit = Splitter.SplitTextByRepeatedLengths(1)(STRING_TWO),

    // Count the difference using the longer string as the base
    Diff = if Text.Length(STRING_ONE) > Text.Length(STRING_TWO) then
           
                // Tally the first
                List.Count(List.Difference(FirstSplit, SecondSplit))
            else
                //Tally the second
                List.Count(List.Difference(FirstSplit, SecondSplit))
    in
Diff