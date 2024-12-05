//https://adventofcode.com/2024/day/4

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
