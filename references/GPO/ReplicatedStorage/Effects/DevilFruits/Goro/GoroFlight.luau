 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        local v3 = p1.PrimaryPart.CFrame
        while p1.PrimaryPart ~= nil do
            _G.PlayEffect("GoroDash", nil, v3, p1.PrimaryPart.CFrame, p1)
            v3 = p1.PrimaryPart.CFrame
            task.wait(0.2)
            if p2 == nil or p2.Parent == nil then
                break
            end
        end
    end
}