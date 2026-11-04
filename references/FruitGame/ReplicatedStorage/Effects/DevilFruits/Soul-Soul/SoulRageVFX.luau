 

game:GetService("TweenService")
game:GetService("Debris")
local u1 = game:GetService("RunService")
local u2 = script.VFX
return {
    ["start"] = function(_, p3, p4, p5) --[[ Name: start, Line 8 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v6 = u2.Rage
        if p5 == false then
            v6 = u2.Base
        end
        if p3 == nil or p3 and p3.PrimaryPart == nil then
            return
        elseif p4 ~= nil and (not p4 or p4.PrimaryPart ~= nil) then
            local u7 = p4.PrimaryPart.Prometheus_Root
            local u8 = p3.PrimaryPart.Center
            if p5 == true then
                local v9 = p4:WaitForChild("RageModel", 3)
                local v10 = p3:WaitForChild("RageModel", 3)
                if not (v9 and v10) then
                    return
                end
                u7 = v9.PrimaryPart.Center
                u8 = v10.PrimaryPart.CloudRoot
            end
            local u11 = v6.Sun:Clone()
            u11.CFrame = u7.TransformedWorldCFrame
            u11.Parent = workspace.Effects
            _G.customEmit(u11)
            _G.destroy(u11, 5)
            local u12 = v6.Lightning:Clone()
            u12.CFrame = u8.TransformedWorldCFrame
            u12.Parent = workspace.Effects
            _G.customEmit(u12)
            _G.destroy(u12, 5)
            local u13 = u1.RenderStepped:Connect(function(_, _) --[[ Line: 54 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u8
                    [3] = u11
                    [4] = u7
                --]]
                u12.CFrame = u8.TransformedWorldCFrame
                u11.CFrame = u7.TransformedWorldCFrame
            end)
            task.delay(5, function() --[[ Line: 59 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13:Disconnect()
                u13 = nil
            end)
        end
    end
}