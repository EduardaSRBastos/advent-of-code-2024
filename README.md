# advent-of-code-2024
Advent of Code 2024 ([adventofcode.com](https://adventofcode.com/)) - Dataweave

## Day 1

### Part 1

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
"Total Distance: ": sum(distances default [])
```
</details>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fadvent-of-code-2024&path=day1%2Fpart1">Dataweave Playground<a>

