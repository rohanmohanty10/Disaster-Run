 

return {
    ["Play"] = function(_, p1, p2) --[[ Name: Play, Line 4 ]]
        if not (p2 or {}).Position then
            Vector3.new()
        end
        p1:Clone()
    end,
    ["FadeOut"] = function(_, _, _) --[[ Name: FadeOut, Line 11 ]] end
}