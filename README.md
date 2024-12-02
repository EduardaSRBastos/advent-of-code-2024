# Advent of Code 2024
[Advent of Code 2024](https://adventofcode.com/2024) - Dataweave Edition

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

var differences = reports map ((report) -> 
    report[1 to -1] map ((item, index) -> item - report[index]))

var checkedReports = differences map ((difference) -> 
    (difference filter ($ >= -3 and $ <= -1)) == (difference) or 
    (difference filter ($ >= 1 and $ <= 3)) == (difference))

var safeReports = checkedReports countBy ((report) -> report)
---
"Total Safe Reports": safeReports
```
</details>
