//https://adventofcode.com/2024/day/5

%dw 2.0
import every from dw::core::Arrays
output application/json

var rules = (payload splitBy "\n\n")[0] splitBy "\n" map ((rule) -> rule splitBy "|")
var updates = (payload splitBy "\n\n")[1] splitBy "\n" map ((updateItem) -> updateItem splitBy ",")
var middleValues = updates 
    filter ((updateItem) -> 
        rules 
            filter ((pair) -> 
                (updateItem contains pair[0]) and (updateItem contains pair[1])
            )
            every ((pair) -> 
                (updateItem indexOf pair[0]) < (updateItem indexOf pair[1])
            )
    ) 
    map ((updateItem) -> updateItem[sizeOf(updateItem) / 2] as Number)
---
sum: sum(middleValues)
