let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WcsopTVXSUfLKz8hTitVB8BOzU8H8oNQUINc3sagSmZsJlfUvSsxLB6l3zcnJzC9BFfMqzclMzEMV8yxOTExWio0FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Color = _t, Person = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Color", type text}, {"Person", type text}}),
    #"Grouped Rows" = Table.Group(#"Changed Type", {"Color"}, {{"Concat", each Text.Combine([Color], ", "), type nullable text}})
in
    #"Grouped Rows"