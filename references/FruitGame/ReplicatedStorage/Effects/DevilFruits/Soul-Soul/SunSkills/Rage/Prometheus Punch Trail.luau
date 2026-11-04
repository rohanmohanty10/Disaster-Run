 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
local u2 = game:GetService("RunService")
Random.new()
require(script.Parent.Shared)
local u3 = script.VFX
local u4 = RaycastParams.new()
u4.FilterDescendantsInstances = {
    workspace.Islands,
    workspace.Env,
    workspace.NPCs,
    workspace.PlayerCharacters
}
u4.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p5) --[[ Name: start, Line 16 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
            [3] = u4
            [4] = u2
        --]]
        local v6 = p5.Cloud
        local v7 = p5.BodyRoot
        local v8 = u3.FX:Clone()
        v8:PivotTo(v7.CFrame)
        v8.Parent = workspace.Effects
        local v9 = u3.Charge:Clone()
        v9.CFrame = v7.CFrame
        v9.Parent = workspace.Effects
        _G.customWeld(v9, v7, CFrame.new(), v9)
        _G.customWeld(v8.PrimaryPart, v7, CFrame.new(), v8)
        local v10 = {}
        local v11 = _G.PlaySound(v7, script.SoulPrometheusDrillBlastShoot)
        local v12 = _G.PlaySound(v7, script.SoulPrometheusDrillBlastTravel)
        table.insert(v10, v11)
        table.insert(v10, v12)
        local v13 = v7
        for v14 = 1, #v10 do
            v10[v14].Parent = v7
        end
        local v15 = u3.Floor:Clone()
        v15.CFrame = v13.CFrame
        v15.Parent = workspace.Effects
        local _ = v15.Attachment
        local v16 = u1:Create(v7, TweenInfo.new(p5.Duration, Enum.EasingStyle.Linear), {
            ["CFrame"] = p5.EndCFrame
        })
        v16:Play()
        local v17 = v15.Attachment
        local v18 = nil
        while v6:GetAttribute("PunchTrail") do
            local v19 = workspace:Raycast(v7.Position, Vector3.new(-0, -35, -0), u4)
            if v19 and v19.Instance then
                v15.CFrame = CFrame.new(v19.Position, v19.Position + v19.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                _G.recolorParticles(v15, v19.Instance.Color)
                if v18 ~= nil and v18 ~= v19.Instance.Color then
                    local v20 = v17.WorldCFrame
                    _G.particleEnabled(v17, false)
                    v17.Parent = workspace.Effects
                    v17.WorldCFrame = v20
                    _G.destroy(v17, 3)
                    v17 = script.VFX.Floor.Attachment:Clone()
                    v17.Parent = v15
                    _G.recolorParticles(v15, v19.Instance.Color)
                end
                v18 = v19.Instance.Color
            end
            v8:PivotTo(v7.CFrame)
            _G.particleEnabled(v15, v19 ~= nil)
            u2.RenderStepped:Wait()
        end
        v16:Pause()
        v16:Destroy()
        _G.particleEnabled(v15, false)
        _G.particleEnabled(v9, false)
        _G.particleEnabled(v8, false, true)
        _G.destroy(v8, 3)
        for v21 = 1, #v10 do
            _G.tween(v10[v21], {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.destroy(v10[v21], 0.25)
        end
        local v22 = v8:GetDescendants()
        for v23 = 1, #v22 do
            if v22[v23]:IsA("Beam") then
                _G.tween(v22[v23], {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Width0"] = 0,
                    ["Width1"] = 0
                })
            end
        end
        task.wait(1)
        _G.destroy({ v15, v9 }, 5)
    end
}