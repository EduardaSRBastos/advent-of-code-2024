# Advent of Code 2024
[Advent of Code 2024](https://adventofcode.com/2024) - Dataweave Edition

<br>

## ⭐Day 1

### Part 1

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fadvent-of-code-2024&path=day1%2Fpart1">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
input payload application/csv separator=" ", header=false
output application/json

var leftOrdered = payload.column_0 orderBy ((item) -> item)
var rightOrdered = payload.column_3 orderBy ((item) -> item)
var distances = leftOrdered map ((item, index) -> 
                        abs(item - rightOrdered[index]))
---
"Total Distance": sum(distances default [])
```
</details>

### Part 2

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fadvent-of-code-2024&path=day1%2Fpart2">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
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
```
</details>

<br>

## ⭐Day 2

### Part 1

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fadvent-of-code-2024&path=day2%2Fpart1">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
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

var safeReports = reports filter ((report) -> 
    checkedReports(differences(report)))
---
"Total Safe Reports": sizeOf(safeReports)
```
</details>

### Part 2

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fadvent-of-code-2024&path=day2%2Fpart2">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
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

```
</details>