
//Calculate font color based on hex value
let fnGetFontColor = 
(HEX as text)=>
let 
    // Split strings into list by each character, convert to upper, remove hash
    Source = if HEX <> "" then Text.Upper(Text.AfterDelimiter(Text.From(HEX), "#")) else "#000000",
    
    // Set gamma
    gamma= 2.2,

    //Get srgb sunfunction
    GetSRGB = (cval1, cval2)=>
    let 
        SRGB = ((cval1 * 16)+ cval2)/255
    in       
        SRGB,
    // Build the RGB list
    RGB = List.Combine({{"0".."9"},{"A".."F"}}),

    // Split the Source by each character
    SplitHex = Splitter.SplitTextByRepeatedLengths(1)(Source),

    // Each value is essentially the index position of the RGB list
    r1 = List.PositionOf(RGB, SplitHex{0}),
    r2 = List.PositionOf(RGB, SplitHex{1}),
    g1 = List.PositionOf(RGB, SplitHex{2}),
    g2 = List.PositionOf(RGB, SplitHex{3}),
    b1 = List.PositionOf(RGB, SplitHex{4}),
    b2 = List.PositionOf(RGB, SplitHex{5}),

    // Calculate rnum, gnum, bnum
    rnum = GetSRGB(r1,r2),
    gnum = GetSRGB(g1,g2),
    bnum = GetSRGB(b1,b2),

    // Calculate luminance
    luminance = (0.2126 * Number.Power(rnum, gamma)) + 
                (0.7152 * Number.Power(gnum, gamma)) + 
                (0.0722 * Number.Power(bnum, gamma)),

    // Determine font color
    fontcolor = if luminance > 0.5 then "Black" else "White"
in 
    fontcolor,


fnType = type function (HEX as text) as text meta 
[Documentation.Name = "fnGetFontColor",
Documentation.LongDescription = "This function takes a hex code and returns whether the font should be black or white for readability.",
Documentation.Examples = {
    [Description = "This gets the font color for #666A86.",
    Code = "fnCheckColorContrast(""#666A86"")",
    Result="White"]
}]
    in  
Value.ReplaceType(fnGetFontColor, fnType)