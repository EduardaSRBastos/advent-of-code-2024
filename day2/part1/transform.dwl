//https://adventofcode.com/2024/day/2

%dw 2.0
input payload application/csv separator=" ", header=false
import * from dw::core::Arrays
output application/json

var reports = payload map ((report) -> report pluck ((value) -> value as Number))

var differences = reports map ((report) -> 
    report[1 to -1] map ((item, index) -> item - report[index]))

var checkedReports = differences map ((difference) -> 
    (difference filter ($ >= -3 and $ <= -1)) == (difference) or 
    (difference filter ($ >= 1 and $ <= 3)) == (difference))

var safeReports = checkedReports countBy ((report) -> report)
---
"Total Safe Reports": safeReports