 

local u1 = {}
game:GetService("RunService")
game:GetService("ReplicatedStorage")
local u2 = game:GetService("TweenService")
local v3 = game:GetService("ReplicatedStorage")
game:GetService("Players")
local u4 = require(v3.Modules.Client.WeaponVFXRecolor)
local u5 = Random.new()
local u6 = Random.new()
require(v3.Modules.ObjectCache)
local u7 = {
    "MochiPuddle1",
    "MochiPuddle2",
    "MochiPuddle3",
    "MochiPuddle4",
    "MochiPuddle5",
    "MochiPuddle6",
    "MochiPuddle7"
}
local u8 = {
    "MochiDroplet1",
    "MochiDroplet2",
    "MochiDroplet3",
    "MochiDroplet4"
}
local u9 = RaycastParams.new()
u9.FilterType = Enum.RaycastFilterType.Include
u9.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u9.RespectCanCollide = true
u9.IgnoreWater = true
local u10 = {}
local v11 = -workspace.Gravity * 1.5
local u12 = Vector3.new(0, v11, 0)
local u13 = game:GetService("HttpService")
function u1.Droplets(p14, p15, p16, p17, p18, p19, p20, p21) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u8
        [3] = u5
        [4] = u4
        [5] = u10
        [6] = u2
    --]]
    if _G.checkRenderDistance(p14.Position, 700) ~= false then
        local v22 = p17 or 10
        local v23 = p16 or 2
        local v24 = p19 or 2
        for _ = 1, p15 or 5 do
            local u25 = u13:GenerateGUID()
            local u26 = script.Parent.DropletAssets.Droplets[u8[u5:NextInteger(1, 4)]]:Clone()
            if p21 then
                u4.apply(u26, p21)
            end
            u26.CFrame = p14
            u26.CanCollide = false
            u26.Size = Vector3.new(1, 1, 1) * p18 * u5:NextNumber(0.75, 2)
            local v27 = u5:NextNumber(-360, 360)
            local v28 = u5:NextNumber(-360, 360)
            local v29 = u5
            u26.Orientation = Vector3.new(v27, v28, v29:NextNumber(-360, 360))
            u26.Anchored = true
            u26.Parent = workspace.Effects
            local v30 = {
                ["Width"] = u5:NextNumber(0.25, 1),
                ["Gravity"] = Vector3.new(0, 0, 0)
            }
            local v31 = u5:NextNumber(-v22, v22)
            local v32 = u5:NextNumber(-v22 / 2, v22 / 2)
            local v33 = u5
            local v34 = -v22
            v30.Velocity = Vector3.new(v31, v32, v33:NextNumber(v34, v22))
            v30.VelocityThreshold = 10
            v30.Duration = 5
            v30.Part = u26
            v30.previousPosition = u26.Position
            v30.SquishAmount = v23 or 2
            v30.OrgY = u26.Size.Y
            v30.OrgZ = u26.Size.Z
            v30.SkipFrame = true
            v30.Char = p21
            if p20 then
                v30.Velocity = v30.Velocity + p20
            end
            u10[u25] = v30
            task.delay(5 + v24 * u5:NextNumber(0.75, 1.25), function() --[[ Line: 101 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u25
                    [3] = u26
                    [4] = u2
                    [5] = u5
                --]]
                u10[u25] = nil
                if u26 then
                    u2:Create(u26, TweenInfo.new(1 * u5:NextNumber(0.5, 2), Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        ["Size"] = Vector3.new()
                    }):Play()
                    task.delay(3, function() --[[ Line: 109 ]]
                        --[[
                        Upvalues:
                            [1] = u26
                        --]]
                        u26:Destroy()
                    end)
                end
            end)
        end
    end
end
function u1.start(_, ...) --[[ Line: 117 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1.Droplets(...)
end
game["Run Service"].Stepped:Connect(function(_, p35) --[[ Line: 169 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u12
        [3] = u9
        [4] = u6
        [5] = u7
        [6] = u5
        [7] = u4
        [8] = u2
    --]]
    local v36 = {}
    local v37 = {}
    for v38, v39 in pairs(u10) do
        v39.Duration = v39.Duration - p35
        v39.Gravity = v39.Gravity + u12 * p35
        v39.Velocity = v39.Velocity + v39.Gravity * p35
        local v40 = v39.previousPosition
        local v41 = v40 + v39.Velocity * p35
        local v42 = v41 - v40
        if v42.Magnitude > 500 then
            u10[v38] = nil
        else
            local v43 = v39.Part.Size
            if v42.Magnitude > 0 and not v39.SkipFrame then
                local v44 = v42.Unit
                local v45 = workspace
                local v46 = CFrame.new(v40)
                local v47 = v43.X
                local v48 = v43.Y
                local v49 = v42.Magnitude
                local v50 = v45:Blockcast(v46, Vector3.new(v47, v48, v49), v44 * v42.Magnitude, u9)
                if not (v50 and v50.Instance) then
                    goto l6
                end
                u10[v38] = nil
                local v51 = u6
                local u52 = script.Parent.DropletAssets.MochiGround[u7[u5:NextInteger(1, 7)]]:Clone()
                if v39.Char then
                    u4.apply(u52, v39.Char)
                end
                local v53 = CFrame.new(v50.Position, v50.Position + v50.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)
                local v54 = CFrame.Angles
                local v55 = v51:NextNumber(0, 360)
                u52.CFrame = v53 * v54(3.141592653589793, math.rad(v55), 0)
                u52.Anchored = true
                u52.Parent = workspace.Effects
                local v56 = v51:NextNumber(0.75, 1.25)
                local v57 = v43.X
                local v58 = v43.Y
                local v59 = Vector3.new(v57, v58, 0).Magnitude + v43.Z / 6
                local v60 = v39.SquishAmount
                local v61 = TweenInfo.new(0.5 * v51:NextNumber(0.75, 2), Enum.EasingStyle.Exponential)
                local u62 = TweenInfo.new(1 * v51:NextNumber(0.5, 2), Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                local v63 = u2
                local v64 = {}
                local v65 = v59 * v60 * v56
                local v66 = v39.OrgY * v60 / 6 * v56 * v51:NextNumber(0.75, 2) + 0.05
                local v67 = v59 * v60 * v56
                v64.Size = Vector3.new(v65, v66, v67)
                v63:Create(u52, v61, v64):Play()
                task.delay(2, function() --[[ Line: 243 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u52
                        [3] = u62
                    --]]
                    u2:Create(u52, u62, {
                        ["Size"] = Vector3.new(0.001, 0.001, 0.001)
                    }):Play()
                    _G.destroy(u52, 2)
                end)
                v39.Part:Destroy()
            else
                ::l6::
                local v68 = v39.Part
                table.insert(v36, v68)
                local v69 = CFrame.new
                local v70 = v41 + v39.Velocity.Unit
                table.insert(v37, v69(v41, v70))
                local v71 = v39.Part
                local v72 = v43.X
                local v73 = v39.OrgY
                local v74 = v39.Velocity.Magnitude * 0.05
                local v75 = math.clamp(v74, 0, 10)
                v71.Size = Vector3.new(v72, v73, v75)
                v39.SkipFrame = false
                v39.previousPosition = v41
            end
        end
    end
    if #v36 > 0 then
        workspace:BulkMoveTo(v36, v37)
    end
end)
return u1