 

game:GetService("RunService")
local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v2 = {}
local function u6(p3, p4) --[[ Line: 5 ]]
    for _, v5 in p3:GetDescendants() do
        if (v5:IsA("ParticleEmitter") or (v5:IsA("BasePart") or (v5:IsA("PointLight") or v5:IsA("Trail")))) and v5:GetAttribute("recolorable") then
            if v5:IsA("Trail") or v5:IsA("ParticleEmitter") then
                v5.Color = ColorSequence.new(p4)
            else
                v5.Color = p4
            end
        end
    end
end
function v2.start(_, p7, p8, p9, p10) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    if _G.checkRenderDistance(p7.PrimaryPart.Position) ~= false then
        local v11 = p7.PrimaryPart
        local v12 = script.fire:Clone()
        v12.CFrame = v11.CFrame * CFrame.new(0, 0, -5)
        v12.Parent = workspace.Effects
        u6(v12, p9)
        u1.apply(v12, p7)
        _G.customEmit(v12)
        _G.destroy(v12, 5)
        local v13 = script.Projectile:Clone()
        v13.CFrame = v11.CFrame * CFrame.new(0, 0, -1)
        v13.Parent = workspace.Effects
        u6(v13, p9)
        u1.apply(v13, p7)
        local v14 = p8 * CFrame.Angles(0, 3.141592653589793, 0)
        local v15 = v13.CFrame
        local v16 = v14.Position
        local v17 = (v15.Position - v16).Magnitude / p10
        _G.tween(v13, {
            v17,
            "Linear",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v14
        })
        _G.PlaySound(v12, script.CyMachineGunShoot, {
            ["Pitch"] = math.random(90, 110) / 100
        })
        task.wait(v17)
        v13.Transparency = 1
        _G.particleEnabled(v13, false)
        local v18 = script.explosion:Clone()
        v18.CFrame = v13.CFrame
        v18.Parent = workspace.Effects
        u6(v18, p9)
        u1.apply(v18, p7)
        _G.PlaySound(v18, script["CyMachineGunBoom" .. math.random(1, 3)], {
            ["Pitch"] = math.random(90, 110) / 100
        })
        _G.customEmit(v18)
        _G.destroy(v18, 7)
        _G.destroy(v13, 4)
    end
end
return v2