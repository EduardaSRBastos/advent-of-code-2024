//https://adventofcode.com/2024/day/10#part2

%dw 2.0
output application/json

var data = payload replace "\r\n" with "\n" splitBy "\n" map((line) -> 
    line splitBy "" map ((item) -> item as Number))

var trailhead = data flatMap ((line, x) -> 
    line flatMap ((item, y) -> 
        if (item == 0) [{x: x, y: y}] else []))

var trails = (data, x, y, currentNumber) ->
    if (data[x][y] == 9) 
        [{x: x, y: y}]
    else do {
        var directions = [
            {x: x - 1, y: y},
            {x: x + 1, y: y},
            {x: x, y: y - 1},
            {x: x, y: y + 1}]
        ---
        directions flatMap ((pos) -> 
            if (pos.x >= 0 and pos.x < sizeOf(data) and 
            pos.y >= 0 and pos.y < sizeOf(data[0]) and 
            data[pos.x][pos.y] == currentNumber + 1) 
                trails(data, pos.x, pos.y, currentNumber + 1) 
            else [])}
---
sum: sum(trailhead map ((trail) -> 
    sizeOf(trails(data, trail.x, trail.y, 0))
))
