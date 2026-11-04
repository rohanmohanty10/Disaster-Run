 

game:GetService("RunService")
local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v2 = {}
local v3 = RaycastParams.new()
v3.FilterType = Enum.RaycastFilterType.Whitelist
v3.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function v2.start(_, p4, p5, p6, p7, p8) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v9 = p8 or game.Players.LocalPlayer.Character
    if _G.checkRenderDistance(p4.Position) ~= false then
        local v10 = script.Fire:Clone()
        u1.apply(v10, v9)
        v10.CFrame = p4 * CFrame.new(0, 0, -3)
        v10.Parent = workspace.Effects
        _G.tween(v10.SurfaceLight, {
            0.4,
            "Quad",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0
        })
        _G.customEmit(v10)
        _G.destroy(v10, 5)
        _G.PlaySound(p4, script["shoot" .. p7])
        local v11 = script.IceProjectile:Clone()
        u1.apply(v11, v9)
        v11:PivotTo(p4 * CFrame.new(0, 0, -2))
        v11:PivotTo(CFrame.new(v11.PrimaryPart.Position, p5.Position))
        v11.Main.Anchored = true
        v11.Parent = workspace.Effects
        local v12 = (p5.Position - v11.PrimaryPart.Position).Magnitude
        _G.tween(v11.PrimaryPart, {
            p6,
            "Linear",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v11.PrimaryPart.CFrame * CFrame.new(-v12, 0, 0)
        })
        task.wait(p6)
        for _, v13 in v11:GetDescendants() do
            if v13:IsA("ParticleEmitter") then
                v13.Enabled = false
            end
        end
        _G.PlaySound(p5, script["hit" .. p7])
        for _, v14 in v11:GetChildren() do
            if v14:IsA("BasePart") then
                v14.Transparency = 1
            end
        end
        local v15 = script.Explosion:Clone()
        u1.apply(v15, v9)
        v15.CFrame = p5 * CFrame.Angles(1.5707963267948966, 0, 0)
        v15.Parent = workspace.Effects
        _G.tween(v15.PointLight, {
            0.4,
            "Quad",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0
        })
        _G.customEmit(v15)
        _G.destroy(v15, 8)
    end
end
return v2