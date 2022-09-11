// Remove chars by feeding a list of chars we want to remove
(STRING as text, LIST as list) =>

let
    Source = if STRING = null then "" else Text.From(STRING),

    // Split by each position, put in list
    SplitText = Splitter.SplitTextByRepeatedLengths(1)(Source),

    // Remove items using the incoming list
    RemoveChars = List.RemoveItems(SplitText, LIST),

    //After removal, combine the remaining chars
    Removed = Text.Combine(RemoveChars, "")

    in

Removed