//https://adventofcode.com/2024/day/11

%dw 2.0
output application/json

var data = payload replace "\r\n" with "\n" splitBy " "

var blinkings = (data, times) ->
    if (times ~= 0) 
        data
    else
        blinkings(
            flatten(data map ((item) -> 
                if(item as Number == 0)
                    1 
                else if((sizeOf(item) mod 2) == 0) do {
                    var mid = sizeOf(item) / 2
                    ---
                    [item[0 to mid -1] as Number, item[mid to -1] as Number]}
                else item as Number * 2024)), 
            times - 1)
---
"Number of Stones": sizeOf(blinkings(data, 25))
