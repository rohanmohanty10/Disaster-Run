 

game:GetService("ReplicatedStorage")
return {
    ["start"] = function(_, p1) --[[ Name: start, Line 5 ]]
        if p1 == nil then
            return
        elseif p1.PrimaryPart == nil then
            return
        else
            local v2 = p1.PrimaryPart:FindFirstChild("Head", true)
            if v2 ~= nil then
                local v3 = script.SummonVFX:Clone()
                v3:setPrimaryPartCFrame(v2.TransformedWorldCFrame)
                v3.Parent = workspace.Effects
                _G.customEmit(v3)
                _G.destroy(v3, 5)
            end
        end
    end
}