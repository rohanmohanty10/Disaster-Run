 

return {
    ["RandomValueFromRange"] = function(p1) --[[ Line: 3 ]]
        if p1.Min == p1.Max then
            return p1.Min
        else
            return p1.Min + (p1.Max - p1.Min) * math.random()
        end
    end
}