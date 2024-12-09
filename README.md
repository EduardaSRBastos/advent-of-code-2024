<div align="center">

# [Advent of Code 2024](https://adventofcode.com/2024) - Dataweave Edition

</div>

## Table of Contents

| Day 1 | Day 2 | Day 3 | Day 4 | Day 5 |
|-------|-------|-------|-------|-------|
| <p align="center">[⭐](#day-1)</p> | <p align="center">[⭐](#day-2)</p> | <p align="center">[⭐](#day-3)</p> | <p align="center">[⭐](#day-4)</p> | <p align="center">[⭐](#day-5)</p> |
|  | **Day 7** | **Day 8** |  |  |
|  | <p align="center">[⭐](#day-7)</p> | <p align="center">[⭐](#day-8)</p> |  |  |

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

<br>

## ⭐Day 3

### Part 1

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos/advent-of-code-2024&path=day3/part1">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
output application/json
var matches = payload scan(/mul\((\d{1,3}),(\d{1,3})\)/)
var x = matches map ((item) -> item[1])
var y = matches map ((item) -> item[2])
var multiplication = x map ((item, index) -> item * y[index])
---
Results: sum(multiplication)
```
</details>

### Part 2

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos/advent-of-code-2024&path=day3/part2">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
output application/json

var matches = payload scan(/mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)/)

var result = matches reduce ((item, accumulator = { result: 0, enabled: true }) -> 
    if (item[0] startsWith "mul(")
        if (accumulator.enabled)
            { 
                result: accumulator.result + ((item[1] as Number) * (item[2] as Number)), 
                enabled: accumulator.enabled 
            }
        else 
            { result: accumulator.result, enabled: accumulator.enabled }
    else if (item[0] == "do()")
        { result: accumulator.result, enabled: true }
    else if (item[0] == "don't()")
        { result: accumulator.result, enabled: false }
    else 
        { result: accumulator.result, enabled: accumulator.enabled }
)
---
Results: result.result
```
</details

<br>

## ⭐Day 4

### Part 1

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos/advent-of-code-2024&path=day4/part1">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
input payload application/csv separator="\n", header=false
import every from dw::core::Arrays
output application/json

var words = ["XMAS", "SAMX"]
var data = flatten(payload map ((item) -> item pluck ((value) -> value)))

var columns = (0 to sizeOf(data[0]) - 1) as Array map ((index) -> 
    data map ((row) -> row[index] as String) joinBy "")

fun findMatches(line) =
    words flatMap ((word) -> 
        (0 to sizeOf(line) - sizeOf(word)) filter ((i) -> line[i to i + sizeOf(word) - 1] == word) map ((i) -> word))

fun isDiagonalMatch(row, col, word) =
    (0 to sizeOf(word) - 1) every ((i) -> data[row + i][col + i] == word[i])

fun findDiagonalMatches() =
    words flatMap ((word) -> 
        (0 to sizeOf(data) - sizeOf(word)) flatMap ((row) -> 
            (0 to sizeOf(data[row]) - sizeOf(word)) filter ((col) ->
                isDiagonalMatch(row, col, word)
            ) map ((i) -> word)
        )
    )

fun isDiagonalReverseMatch(row, col, word) =
    (0 to sizeOf(word) - 1) every ((i) -> data[row + i][col - i] == word[i])

fun findReverseDiagonalMatches() =
    words flatMap ((word) ->
        (0 to sizeOf(data) - sizeOf(word)) flatMap ((row) -> 
            (0 to sizeOf(data[row]) - 1) filter ((col) ->
                (col - sizeOf(word) >= -1) and 
                (row + sizeOf(word) <= sizeOf(data)) and 
                isDiagonalReverseMatch(row, col, word)
            ) map ((i) -> word)
        )
    )

var horizontal = flatten(data map ((row) -> findMatches(row)))
var vertical = flatten(columns map ((col) -> findMatches(col)))
var diagonal = findDiagonalMatches()
var reverseDiagonal = findReverseDiagonalMatches()
---
total: (sizeOf(horizontal) + sizeOf(vertical) + sizeOf(diagonal) + sizeOf(reverseDiagonal))
```
</details>

### Part 2

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos/advent-of-code-2024&path=day4/part2">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
input payload application/csv separator="\n", header=false
output application/json

var data = flatten(payload map ((item) -> item pluck ((value) -> value)))
var size = sizeOf(data)

fun isXMasPattern(x, y) =
  (data[x+1][y+1] == 'A' and
    (
      (data[x][y] == 'M' and data[x+2][y+2] == 'S') or
      (data[x][y] == 'S' and data[x+2][y+2] == 'M')
    ) and
    (
      (data[x][y+2] == 'M' and data[x+2][y] == 'S') or
      (data[x][y+2] == 'S' and data[x+2][y] == 'M')
    ))

var matches = flatten(
  (0 to size - 1) as Array map (i) -> 
    (0 to sizeOf(data[i]) - 1)
      map (j) -> if (isXMasPattern(i, j)) { x: i, y: j } else null
) filter($ != null)
---
total: sizeOf(matches)
```
</details

<br>

## ⭐Day 5

### Part 1

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos/advent-of-code-2024&path=day5/part1">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
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
```
</details>

<br>

## ⭐Day 7

### Part 1

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos/advent-of-code-2024&path=day7/part1">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
output application/json

var data = payload 
    splitBy("\n")
    map ((line) -> {
        total: (line splitBy ":")[0] as Number,
        numbers: trim((line splitBy ":")[1])
            splitBy(" ") 
            map ((num) -> num as Number)
    })

var results = (nums) -> 
    do {
        var calculate = (pos, acc) -> 
            if (pos == sizeOf(nums)) acc
            else
                flatten(
                    [
                        calculate(pos + 1, acc map ((value) -> value + nums[pos])),
                        calculate(pos + 1, acc map ((value) -> value * nums[pos]))
                    ]
                )
        ---
        calculate(1, [nums[0]])
    }

var totalResults = data map ((item) -> 
    if (results(item.numbers) contains item.total)
        item.total
    else
        0
)
---
total: sum(totalResults filter ($ != 0))
```
</details>

### Part 2

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos/advent-of-code-2024&path=day7/part2">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
output application/json

var data = payload 
    splitBy("\n")
    map ((line) -> {
        total: (line splitBy ":")[0] as Number,
        numbers: trim((line splitBy ":")[1])
            splitBy(" ") 
            map ((num) -> num as Number)
    })

var results = (nums) -> 
    do {
        var calculate = (pos, acc) -> 
            if (pos == sizeOf(nums)) acc
            else
                flatten(
                    [
                        calculate(pos + 1, acc map ((value) -> value + nums[pos])),
                        calculate(pos + 1, acc map ((value) -> value * nums[pos])),
                        calculate(pos + 1, acc map ((value) ->
                            ((value as String) ++ (nums[pos] as String)) as Number
                        ))
                    ]
                )
        ---
        calculate(1, [nums[0]])
    }

var totalResults = data map ((item) -> 
    if (results(item.numbers) contains item.total)
        item.total
    else
        0
)
---
total: sum(totalResults filter ($ != 0))
```
</details>

<br>

## ⭐Day 8

### Part 1

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos/advent-of-code-2024&path=day8/part1">Dataweave Playground<a>

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
import some from dw::core::Arrays
output application/json

var rows = payload replace "\r\n" with "\n" splitBy "\n"
var cells = rows map ((row) -> row splitBy "")

var frequencies = flatten(
    rows map (
        (row, rowIndex) ->
            row splitBy "" 
                map (
                    (cell, cellIndex) ->
                        if (cell != ".") 
                            { x: rowIndex, y: cellIndex, frequency: cell }
                        else null
                ) filter ($ != null)
    )
) groupBy $.frequency

var antinodes = flatten(
    frequencies pluck ((antennas, frequency) -> 
        antennas 
            flatMap ((antenna1, idx1) -> 
                antennas[(idx1 + 1) to -1] 
                    flatMap ((antenna2) -> 
                        do {
                            var dx = antenna2.x - antenna1.x
                            var dy = antenna2.y - antenna1.y
                            ---
                            [
                                { x: antenna1.x - dx, y: antenna1.y - dy },
                                { x: antenna2.x + dx, y: antenna2.y + dy }
                            ] 
                        }
                    )
            )
    )
) filter ((antinode) -> 
        antinode != null and 
        antinode.x >= 0 and antinode.x < sizeOf(cells) and 
        antinode.y >= 0 and antinode.y < sizeOf(cells[0])
    )  distinctBy ($)
---
  total: sizeOf(antinodes)
```
</details>

### Part 2

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos/advent-of-code-2024&path=day8/part2">Dataweave Playground<a>

<details>
  <summary>Script</summary>
  
```dataweave
%dw 2.0
import some from dw::core::Arrays
output application/json

var rows = payload replace "\r\n" with "\n" splitBy "\n"
var cells = rows map ((row) -> row splitBy "")

var frequencies = flatten(
    rows map (
        (row, rowIndex) ->
            row splitBy "" 
                map (
                    (cell, cellIndex) ->
                        if (cell != ".") 
                            { x: rowIndex, y: cellIndex, frequency: cell }
                        else null
                ) filter ($ != null)
    )
) groupBy $.frequency

var antinodes = flatten(
    frequencies pluck ((antennas, frequency) -> 
        antennas 
            flatMap ((antenna1, idx1) -> 
                antennas[(idx1 + 1) to -1] 
                    flatMap ((antenna2) -> 
                        do {
                            var dx = antenna2.x - antenna1.x
                            var dy = antenna2.y - antenna1.y
                            ---
                            flatten(
                                [
                                    (0 to sizeOf(cells)) map ((step) -> { 
                                        x: antenna1.x - step * dx, 
                                        y: antenna1.y - step * dy 
                                    }),
                                    (0 to sizeOf(cells)) map ((step) -> { 
                                        x: antenna2.x + step * dx, 
                                        y: antenna2.y + step * dy 
                                    })
                                ]
                            )
                        }
                    )
            )
    )
) filter ((antinode) -> 
        antinode != null and 
        antinode.x >= 0 and antinode.x < sizeOf(cells) and 
        antinode.y >= 0 and antinode.y < sizeOf(cells[0])
    )  distinctBy ($)

var grid = 
    cells map ((row, rowIndex) -> 
        row map ((cell, cellIndex) -> 
            if (cell != "." ) cell
            else if (antinodes some (antinode) -> antinode.x == rowIndex and antinode.y == cellIndex) "#" 
            else "."
        ) joinBy ""
    )
---
{
  //map: grid,
  total: sizeOf(antinodes)
}
```
</details>

<br>

‎<h2 align="right">[▲](#advent-of-code-2024---dataweave-edition)</h2>