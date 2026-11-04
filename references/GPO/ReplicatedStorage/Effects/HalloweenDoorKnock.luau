 

return {
    ["start"] = function(_, p1, u2, p3) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1, 150) ~= false then
            local v4 = workspace:GetServerTimeNow() - p3
            task.delay(0.283 - v4, function() --[[ Line: 9 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                if u2:FindFirstChild("Head") ~= nil then
                    local v5 = script.VFXRig.Head.Alert:Clone()
                    v5.Parent = u2.Head
                    _G.customEmit(v5)
                    _G.destroy(v5, 5)
                end
            end)
            task.delay(3.05 - v4, function() --[[ Line: 21 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                local v6 = u2:FindFirstChild("LeftHand")
                if v6 ~= nil then
                    local v7 = script.VFXRig.LeftHand.Attachment:Clone()
                    v7.Parent = v6
                    _G.customEmit(v7)
                    _G.destroy(v7, 5)
                end
            end)
            local u8 = script.Frame:Clone()
            u8.CFrame = p1
            u8.Parent = workspace.Effects
            task.delay(0.083 - v4, function() --[[ Line: 37 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                _G.customEmit(u8)
            end)
            task.delay(4.533 - v4, function() --[[ Line: 41 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                _G.customEmit(u8)
                _G.destroy(u8, 5)
            end)
        end
    end
}