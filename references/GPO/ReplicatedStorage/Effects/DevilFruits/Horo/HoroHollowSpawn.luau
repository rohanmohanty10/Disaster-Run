 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        if p1 == nil then
            return
        elseif p1.PrimaryPart == nil then
            return
        else
            local v3 = p1.PrimaryPart:FindFirstChild("Head", true)
            if v3 ~= nil then
                local v4 = script.Model:Clone()
                v4:ScaleTo(p2 or 1)
                v4:setPrimaryPartCFrame(v3.TransformedWorldCFrame)
                v4.Parent = workspace.Effects
                _G.customEmit(v4)
                _G.destroy(v4, 4)
            end
        end
    end
}