//https://adventofcode.com/2024/day/1

%dw 2.0
input payload application/csv separator=" ", header=false
output application/json

var leftOrdered = payload.column_0 orderBy ((item) -> item)
var rightOrdered = payload.column_3 orderBy ((item) -> item)
var distances = leftOrdered map ((item, index) -> 
                        abs(item - rightOrdered[index]))
---
"Total Distance": sum(distances default [])
