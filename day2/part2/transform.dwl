//https://adventofcode.com/2024/day/2#part2

%dw 2.0
input payload application/csv separator=" ", header=false
import * from dw::core::Arrays
output application/json

var reports = payload map ((report) -> report pluck ((value) -> value as Number))

var differences = (report) -> 
    report[1 to -1] map ((item, index) -> item - report[index])

var checkedReports = (differences) -> 
    (differences filter ($ >= -3 and $ <= -1)) == differences or 
    (differences filter ($ >= 1 and $ <= 3)) == differences

var safeReportsWithLevelRemoved = (report) -> 
    (0 to sizeOf(report) - 1) map ((i) -> 
        checkedReports(differences(report filter ((item, index) -> index != i)))
    ) filter ((safe) -> safe) 

var safeReports = reports filter ((report) -> 
    checkedReports(differences(report)) or 
    !isEmpty(safeReportsWithLevelRemoved(report)))
---
"Total Safe Reports": sizeOf(safeReports)
