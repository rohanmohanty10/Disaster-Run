 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
Random.new()
require(script.Parent.Shared)
local u2 = script.VFX
local u3 = RaycastParams.new()
u3.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
u3.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p4) --[[ Name: start, Line 14 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u1
        --]]
        local v5 = p4.RootPart
        local v6 = p4.CloudModel.PrimaryPart.RealRoot.Value
        local u7 = u2.Ground_Charge:Clone()
        u7.Parent = workspace.Effects
        _G.PlaySound(v6, script.SoulZeusUltStart).Parent = v6
        local u8 = script.SoulZeusUltHoldLoop:Clone()
        u8.Parent = u7
        u8:Play()
        while v5.Parent and v5:GetAttribute("RaigekiCharge") do
            local v9 = workspace:Raycast(v5.Position, Vector3.new(-0, -250, -0), u3)
            _G.particleEnabled(u7, v9 ~= nil)
            if v9 then
                u7.CFrame = CFrame.new(v9.Position, v9.Position + v9.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)
            end
            task.wait()
        end
        task.delay(1, function() --[[ Line: 40 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u1
                [3] = u8
            --]]
            _G.particleEnabled(u7, false)
            u1:Create(u7.PointLight, TweenInfo.new(1), {
                ["Range"] = 1,
                ["Brightness"] = 0
            }):Play()
            u1:Create(u8, TweenInfo.new(1), {
                ["Volume"] = 0
            }):Play()
            task.wait(1)
            u7:Destroy()
        end)
    end
}