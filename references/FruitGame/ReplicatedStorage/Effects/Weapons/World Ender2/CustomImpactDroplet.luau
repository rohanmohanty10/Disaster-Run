 

local u1 = {}
game:GetService("RunService")
game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local u2 = Random.new()
local u3 = Random.new()
local u4 = RaycastParams.new()
u4.FilterType = Enum.RaycastFilterType.Include
u4.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u4.RespectCanCollide = true
u4.IgnoreWater = true
local u5 = {}
local v6 = -workspace.Gravity * 1.5
local u7 = Vector3.new(0, v6, 0)
local u8 = game:GetService("HttpService")
function u1.Droplets(p9) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u2
        [3] = u7
        [4] = u5
    --]]
    local v10 = p9.origin
    local v11 = p9.Amount
    local v12 = p9.Velocity
    local v13 = p9.TimeUntilDelete
    local v14 = p9.CustomVelocity
    local v15 = p9.Projectile
    local v16 = p9.HitVFX
    local v17 = p9.CustomHitFunction
    if _G.checkRenderDistance(v10.Position, 700) ~= false then
        local v18 = v12 or 10
        local v19 = v13 or 2
        for _ = 1, v11 or 5 do
            local u20 = u8:GenerateGUID()
            local u21 = v15:Clone()
            u21.CFrame = v10
            u21.CanCollide = false
            local v22 = u2:NextNumber(-360, 360)
            local v23 = u2:NextNumber(-360, 360)
            local v24 = u2
            u21.Orientation = Vector3.new(v22, v23, v24:NextNumber(-360, 360))
            u21.Anchored = true
            u21.Parent = workspace.Effects
            local v25 = {
                ["Width"] = u2:NextNumber(0.25, 1),
                ["Gravity"] = Vector3.new(0, 0, 0)
            }
            local v26 = u2:NextNumber(-v18, v18)
            local v27 = u2:NextNumber(-v18 / 2, v18 / 2)
            local v28 = u2
            local v29 = -v18
            v25.Velocity = Vector3.new(v26, v27, v28:NextNumber(v29, v18))
            v25.VelocityThreshold = 10
            v25.Duration = 5
            v25.Part = u21
            v25.previousPosition = u21.Position
            v25.OrgY = u21.Size.Y
            v25.OrgZ = u21.Size.Z
            v25.CustomGravity = p9.CustomGravity or u7
            v25.SkipFrame = true
            v25.HitVFX = v16
            v25.CustomHitFunction = v17
            v25.UseRaycast = p9.UseRaycast
            if v14 then
                v25.Velocity = v25.Velocity + v14
            end
            u5[u20] = v25
            task.delay(5 + v19 * u2:NextNumber(0.75, 1.25), function() --[[ Line: 73 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u20
                    [3] = u21
                --]]
                u5[u20] = nil
                if u21 then
                    u21:Destroy()
                end
            end)
        end
    end
end
function u1.start(_, ...) --[[ Line: 82 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1.Droplets(...)
end
game["Run Service"].Stepped:Connect(function(_, p30) --[[ Line: 134 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u3
    --]]
    local v31 = {}
    local v32 = {}
    for v33, v34 in pairs(u5) do
        v34.Duration = v34.Duration - p30
        v34.Gravity = v34.Gravity + v34.CustomGravity * p30
        v34.Velocity = v34.Velocity + v34.Gravity * p30
        local v35 = v34.previousPosition
        local v36 = v35 + v34.Velocity * p30
        local v37 = v36 - v35
        if v37.Magnitude > 500 then
            u5[v33] = nil
        else
            local v38 = v34.Part.Size
            if v37.Magnitude > 0 and not v34.SkipFrame then
                local v39 = v37.Unit
                local v40
                if v34.UseRaycast == nil then
                    local v41 = workspace
                    local v42 = CFrame.new(v35)
                    local v43 = v38.X
                    local v44 = v38.Y
                    local v45 = v37.Magnitude
                    v40 = v41:Blockcast(v42, Vector3.new(v43, v44, v45), v39 * v37.Magnitude, u4)
                else
                    v40 = workspace:Raycast(v35, v39 * v37.Magnitude, u4)
                end
                if not (v40 and v40.Instance) then
                    goto l6
                end
                u5[v33] = nil
                local v46 = u3
                if v34.HitVFX then
                    local v47 = v34.HitVFX:Clone()
                    local v48 = CFrame.new(v40.Position, v40.Position + v40.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)
                    local v49 = CFrame.Angles
                    local v50 = v46:NextNumber(0, 360)
                    v47.CFrame = v48 * v49(3.141592653589793, math.rad(v50), 0)
                    v47.Parent = workspace.Effects
                    _G.customEmit(v47)
                    _G.destroy(v47, 5)
                end
                if v34.CustomHitFunction then
                    local v51 = v34.CustomHitFunction
                    local v52 = CFrame.new(v40.Position, v40.Position + v40.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)
                    local v53 = CFrame.Angles
                    local v54 = v46:NextNumber(0, 360)
                    v51(v52 * v53(3.141592653589793, math.rad(v54), 0))
                end
                _G.particleEnabled(v34.Part, false, true)
                _G.destroy(v34.Part, 5)
            else
                ::l6::
                local v55 = v34.Part
                table.insert(v31, v55)
                local v56 = CFrame.new
                local v57 = v36 + v34.Velocity.Unit
                table.insert(v32, v56(v36, v57))
                local v58 = v34.Part
                local v59 = v38.X
                local v60 = v34.OrgY
                local v61 = v34.Velocity.Magnitude * 0.05
                local v62 = math.clamp(v61, 0, 10)
                v58.Size = Vector3.new(v59, v60, v62)
                v34.SkipFrame = false
                v34.previousPosition = v36
            end
        end
    end
    if #v31 > 0 then
        workspace:BulkMoveTo(v31, v32)
    end
end)
return u1