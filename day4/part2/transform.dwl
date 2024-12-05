//https://adventofcode.com/2024/day/4#part2

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
