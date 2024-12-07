//https://adventofcode.com/2024/day/7#part2

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
