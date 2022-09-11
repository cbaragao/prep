// Calculate complimentary color based on hex value
(HEX as text)=>

let 
    // Split strings into list by each character, convert to upper, remove hash
    Source = if HEX <> "" then Text.Upper(Text.AfterDelimiter(Text.From(HEX), "#")) else "#000000",
    
    // Split the Source by each character
    SplitHex = Splitter.SplitTextByRepeatedLengths(1)(Source),

    GetCompColor = (hexlist)=>

        let 
            // Build the RGB list
            RGB = List.Combine({{"0".."9"},{"A".."F"}}),
            
            // Sub function to figure out complimentary color RGB value
            GetCompRGB = (cval1, cval2)=>
            let 
                RGBVal = 255-((cval1 * 16)+ cval2)
            in       
                RGBVal,
            
            // Sub function to figure out complimentary color hex value
            ConvertToHex = (val) =>
            let 
                first_digit = Number.RoundDown(val/16),
                second_digit = ((val/16) - Number.RoundDown(val/16)) * 16,
                both_hex = Text.Combine({RGB{first_digit}, RGB{second_digit}})
            in    
                both_hex,
            
            // Get positions of each digit
            r1 = List.PositionOf(RGB, hexlist{0}),
            r2 = List.PositionOf(RGB, hexlist{1}),
            g1 = List.PositionOf(RGB, hexlist{2}),
            g2 = List.PositionOf(RGB, hexlist{3}),
            b1 = List.PositionOf(RGB, hexlist{4}),
            b2 = List.PositionOf(RGB, hexlist{5}),

            // Process digit values 
            cred = GetCompRGB(r1,r2),
            cgreen = GetCompRGB(g1,g2),
            cblue = GetCompRGB(b1,b2),
            
            // Combine R,G,B hex values to one hex value
            FinalRGB = Text.Combine({
                        "#",
                        ConvertToHex(cred),
                        ConvertToHex(cgreen),
                        ConvertToHex(cblue)
            })
        in
            FinalRGB,
    
    // Process the split list from the input
    CompColor = GetCompColor(SplitHex)

    in

CompColor