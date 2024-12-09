//https://adventofcode.com/2024/day/8#part2

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
