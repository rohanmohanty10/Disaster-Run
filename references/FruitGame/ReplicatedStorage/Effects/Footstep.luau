 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 4 ]]
        if p1 == game.Players.LocalPlayer then
            return
        elseif p2 == nil then
            return
        elseif p2.PrimaryPart == nil then
            return
        elseif _G.checkRenderDistance(p2.PrimaryPart.Position, 300) == false then
            return
        elseif p3 == nil then
            _G.footstep(nil, nil, p2)
        else
            _G.footstep("land", nil, p2)
        end
    end
}