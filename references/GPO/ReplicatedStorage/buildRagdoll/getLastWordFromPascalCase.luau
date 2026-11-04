 

return function(p1) --[[ Line: 12 ]]
    local v2 = #p1 - ((string.find(string.reverse(p1), "%u") or #p1 + 1) - 1)
    local v3 = string.sub(p1, v2)
    return string.gsub(v3, "%d+$", "")
end