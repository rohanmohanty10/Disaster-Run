 

local u1 = script.HookedModel.Value
local u2 = script.Parent
_G.bindableExcu(function() --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    if u1 then
        u1.AncestryChanged:Connect(function() --[[ Line: 6 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            if u1:IsDescendantOf(workspace) ~= true then
                if u2 then
                    u2:Destroy()
                end
            end
        end)
    end
end)