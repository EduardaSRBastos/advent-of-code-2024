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
var a = payload.column_0 orderBy $
var b = payload.column_3 orderBy $
---
(0 to sizeOf(a)-1) map (abs(a[$] - b[$])) then sum($)
```
</details>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fadvent-of-code-2024&path=day1%2Fpart1">Dataweave Playground<a>

