 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
game:GetService("RunService")
local _ = game:GetService("Players").LocalPlayer
Random.new()
local v2 = {}
local _ = script
local v3 = RaycastParams.new()
v3.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
v3.FilterType = Enum.RaycastFilterType.Include
function v2.start(_, p4) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v5 = p4.Character
    local v6 = p4.ActionType
    local _ = workspace:GetServerTimeNow() - p4.serverTimeNow
    local v7 = p4.StartCFrame
    local u8 = p4.EndCFrame
    local v9 = p4.Duration
    if v6 == "Startup" then
        v5.Humanoid:LoadAnimation(script.Animation):Play(0)
        _G.PlaySound(v5.PrimaryPart, script.chargeup)
    else
        _G.PlaySound(v5.PrimaryPart, script.shoot)
        local v10 = script.Fire_Mouth:Clone()
        v10.CFrame = CFrame.new(v7.Position, u8.Position)
        v10.Parent = workspace.Effects
        _G.customEmit(v10)
        _G.destroy(v10, 4)
        local u11 = script.Projectile:Clone()
        u11.CFrame = v10.CFrame
        u11.Parent = workspace.Effects
        _G.PlaySound(u11, script.SoulMiniHomiesCakeBulletShoot).Parent = u11
        local v12 = (v7.Position - u8.Position).Magnitude
        u1:Create(u11, TweenInfo.new(v9, Enum.EasingStyle.Linear), {
            ["CFrame"] = v10.CFrame * CFrame.new(0, 0, -v12)
        }):Play()
        task.delay(v9, function() --[[ Line: 56 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u8
            --]]
            _G.particleEnabled(u11, false, true)
            _G.destroy(u11, 4)
            local v13 = script.Explode:Clone()
            v13.CFrame = u8
            v13.Parent = workspace.Effects
            _G.customEmit(v13)
            _G.destroy(v13, 4)
            _G.PlaySound(u8, script.SoulMiniHomiesCakeBulletHit)
        end)
    end
end
return v2