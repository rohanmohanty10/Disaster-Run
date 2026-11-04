 

return function() --[[ Line: 3 ]]
    local v1 = Random.new()
    local v2 = tostring(v1:NextNumber())
    local v3 = string.sub(v2, 3, 8)
    return tonumber(v3)
end