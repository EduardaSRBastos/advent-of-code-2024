//https://adventofcode.com/2024/day/3#part2

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
