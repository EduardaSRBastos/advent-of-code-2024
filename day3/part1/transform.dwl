//https://adventofcode.com/2024/day/3

%dw 2.0
output application/json
var matches = payload scan(/mul\((\d{1,3}),(\d{1,3})\)/)
var x = matches map ((item) -> item[1])
var y = matches map ((item) -> item[2])
var multiplication = x map ((item, index) -> item * y[index])
---
Results: sum(multiplication)
