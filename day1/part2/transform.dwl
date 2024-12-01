//https://adventofcode.com/2024/day/1#part2

%dw 2.0
input payload application/csv separator=" ", header=false
import * from dw::core::Arrays
output application/json

var left = payload.column_0
var right = payload.column_3

var similarity = left map ((item) -> 
                    (right countBy ($ ~= item) default 0) * item)
---
"Similarity Score": sum(similarity default [])
