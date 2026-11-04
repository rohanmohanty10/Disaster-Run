 

local u1 = {}
local u2 = {
    { 128513, 128591 },
    { 9986, 10160 },
    { 128640, 128704 },
    { 9410, 127569 },
    { 127744, 128511 },
    { 8596, 8601 },
    { 9193, 9203 },
    { 9723, 9981 },
    { 127744, 128511 },
    { 128512, 128566 },
    { 128641, 128709 },
    { 127757, 128359 }
}
for _, v3 in {
    169,
    174,
    8252,
    8265,
    8419,
    8482,
    8505,
    8617,
    8618,
    8986,
    8987,
    9642,
    9643,
    9654,
    9664,
    10548,
    10549,
    11013,
    11014,
    11015,
    11035,
    11036,
    11088,
    11093,
    12336,
    12349,
    12951,
    12953,
    126980,
    127183
} do
    u1[v3] = true
end
return function(p4) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v5 = {}
    for _, v6 in utf8.codes(p4) do
        local v7 = true
        if u1[v6] then
            v7 = false
        else
            for _, v8 in u2 do
                if v8[1] <= v6 and v6 <= v8[2] then
                    v7 = false
                    break
                end
            end
        end
        if v7 then
            table.insert(v5, v6)
        end
    end
    return utf8.char(unpack(v5))
end