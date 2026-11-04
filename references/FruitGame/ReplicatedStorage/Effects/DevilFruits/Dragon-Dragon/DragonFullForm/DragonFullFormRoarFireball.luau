 

game:GetService("TweenService")
game:GetService("RunService")
local v1 = {}
require(script.Parent.Parent.SharedForms.DragonLightningStrikeEffect)
local v2 = game:GetService("ReplicatedStorage")
require(v2.Modules.BezierFormula)
CFrame.new(0, 0, -0)
CFrame.new(0, 0, -0)
Random.new()
local v3 = RaycastParams.new()
local v4 = { workspace.Islands, workspace.Env, workspace.Ships }
local v5 = Enum.RaycastFilterType.Include
v3.FilterDescendantsInstances = v4
v3.FilterType = v5
local u6 = RaycastParams.new()
u6.FilterType = Enum.RaycastFilterType.Include
u6.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
function v1.start(_, p7, u8, u9, p10) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local _ = workspace:GetServerTimeNow() - u9
    local v11 = p10:FindFirstChild("LowerJaw_3", true)
    if v11 then
        p7 = CFrame.new(v11.WorldPosition)
    end
    local u12 = script.Fireball:Clone()
    u12.CFrame = p7
    u12.Parent = workspace.Effects
    _G.PlaySound(u12, script.Fire["DragonRoarFireballShoot" .. math.random(1, 4)], {
        ["RandomPitch"] = true
    }).Parent = u12
    local v13 = game:GetService("RunService")
    local u14 = game:GetService("TweenService")
    local v15 = -workspace.Gravity
    local u16 = Vector3.new(0, v15, 0) * 1.3
    local v17 = -u16.Y
    local u18 = p7.Position
    local v19 = u8.Position
    local v20 = v19.X - u18.X
    local v21 = v19.Z - u18.Z
    local v22 = Vector3.new(v20, 0, v21).Magnitude
    local v23 = u8.Distance * 0.5
    local v24 = math.clamp(v23, 25, 150)
    local v25 = u18.Y
    local v26 = v19.Y
    local v27 = math.max(v25, v26) + v24
    local v28 = v17 * 2 * (v27 - u18.Y)
    local v29 = math.max(0, v28)
    local v30 = math.sqrt(v29) / v17
    local v31 = 2 * (v27 - v19.Y) / v17
    local v32 = math.max(0, v31)
    local v33 = v30 + math.sqrt(v32)
    local v34 = math.max(v33, 0.016666666666666666) * 0.7
    local v35 = math.max(v34, 0.016666666666666666)
    local v36 = (v19.Y - u18.Y + v17 * 0.5 * v35 * v35) / v35 * 1.35
    local v37 = u18.Y
    local v38 = v19.Y
    local v39 = v36 * v36 + 2 * v17 * (v37 - v38)
    local v40 = math.max(0, v39)
    local v41 = (v36 + math.sqrt(v40)) / v17
    local u42 = math.max(v41, 0.016666666666666666)
    local v43 = v19.X
    local v44 = v19.Z
    local v45 = Vector3.new(v43, 0, v44)
    local v46 = u18.X
    local v47 = u18.Z
    local u48 = (v45 - Vector3.new(v46, 0, v47)).Unit * (v22 / u42) + Vector3.new(0, v36, 0)
    local u49 = u18
    local u50 = nil
    local function u59(p51, p52) --[[ Line: 78 ]]
        --[[
        Upvalues:
            [1] = u50
            [2] = u12
            [3] = u14
        --]]
        if u50 then
            u50:Disconnect()
            u50 = nil
        end
        local v53 = script.FireballHit:Clone()
        v53.CFrame = CFrame.lookAt(p51, p51 + (p52 or Vector3.new(0, 1, 0)))
        local v54, _, _ = _G.getRayFloor(CFrame.new(p51), 25)
        if v54 then
            _G.recolorParticles(v53, v54.Color)
        end
        v53.Parent = workspace.Effects
        u12.PointLight.Enabled = false
        u12.Transparency = 1
        _G.PlaySound(v53, script.Fire["DragonRoarFireballGroundBoom" .. math.random(1, 4)], {
            ["RandomPitch"] = true
        })
        _G.particleEnabled(u12, false)
        _G.customEmit(v53)
        _G.destroy(v53, 6)
        _G.destroy(u12, 4.5)
        u14:Create(v53.PointLight, TweenInfo.new(0.25), {
            ["Range"] = 55,
            ["Brightness"] = 0
        }):Play()
        local v55 = v53.Position + Vector3.new(0, 3, 0)
        local _ = v53.CFrame
        _G.shakenear(v53.Position, 60, 75, 75, -1)
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 16,
            ["Position"] = v55,
            ["DistanceRandomness"] = Vector2.new(0.5, 1),
            ["Duration"] = 2,
            ["TweenDuration"] = 1,
            ["Radius"] = 20,
            ["Direction"] = Vector3.new(0, -15, 0)
        })
        local v56 = _G.PlayEffect
        local v57 = {
            ["PartCount"] = 5,
            ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * 1,
            ["Position"] = v55
        }
        local v58 = math.random(55, 80)
        v57.Direction = Vector3.new(0, v58, 0)
        v57.RaycastDirection = Vector3.new(0, -15, 0)
        v57.Size = Vector3.new(0.8, 0.8, 0.8)
        v57.TrailEnabled = true
        v56("RockDebris", nil, v57)
    end
    u50 = v13.Heartbeat:Connect(function(_) --[[ Line: 135 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u42
            [3] = u18
            [4] = u48
            [5] = u16
            [6] = u49
            [7] = u6
            [8] = u12
            [9] = u59
            [10] = u8
        --]]
        local v60 = workspace:GetServerTimeNow() - u9
        local v61 = u42
        local v62 = math.clamp(v60, 0, v61)
        local v63 = u18 + u48 * v62 + u16 * 0.5 * v62 * v62
        local v64 = u48 + u16 * v62
        local v65 = v64.Magnitude > 1e-6 and v64.Unit or Vector3.new(0, 0, 1)
        local v66 = v63 - u49
        local v67 = workspace:Raycast(u49, v66, u6)
        if v67 then
            u12.CFrame = CFrame.lookAt(v67.Position, v67.Position + v65)
            u59(v67.Position, v67.Normal)
            return
        else
            u12.CFrame = CFrame.lookAt(v63, v63 + v65)
            if u42 <= v62 then
                u59(u8.Position, u8.Normal)
            else
                u49 = v63
            end
        end
    end)
end
return v1