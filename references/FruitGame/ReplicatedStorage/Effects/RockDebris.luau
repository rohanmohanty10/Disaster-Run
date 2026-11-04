 

local v1 = workspace.Effects
game:GetService("RunService")
local u2 = game:GetService("TweenService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = Random.new()
local v5 = require(v3.Modules.ObjectCache)
local u8 = v5.new(script.Rock, 100, v1, {
    ["ReturnFunction"] = function(p6) --[[ Name: ReturnFunction, Line 10 ]]
        local v7 = p6:FindFirstChild("Trail")
        if v7 then
            v7:Clear()
            v7.Enabled = false
        end
    end
})
local u9 = v5.new(script.Dust, 50, v1)
local u10 = RaycastParams.new()
u10.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u10.FilterType = Enum.RaycastFilterType.Include
local function u13(p11, p12) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    return workspace:Raycast(p11, p12, u10)
end
function CreateRock(u14)
    --[[
    Upvalues:
        [1] = u8
        [2] = u4
        [3] = u10
        [4] = u13
        [5] = u9
        [6] = u2
    --]]
    local v15 = u14.Position
    local u16 = u14.Velocity
    local v17 = u14.AngularVelocity
    if not v17 then
        local v18 = math.random(-3, 3)
        local v19 = math.random(-3, 3)
        local v20 = math.random
        v17 = Vector3.new(v18, v19, v20(-3, 3))
    end
    local v21 = u14.Color
    local v22 = u14.Size
    local v23 = u14.Material
    local v24 = u14.Duration or 3
    local u25 = 4
    local u26 = u8:GetPart(CFrame.Angles(6.283185307179586 * math.random(), 6.283185307179586 * math.random(), 6.283185307179586 * math.random()) + v15)
    u26.Transparency = 0
    u26.CanCollide = true
    u26.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    u26.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    u26.Material = v23
    u26.Size = v22
    u26.Massless = true
    _G.matchMaterial(u26, u14.HitPart)
    if u26:FindFirstChild("Att1") then
        local v27 = u26.Att1
        local v28 = v22.Magnitude / 2
        v27.Position = Vector3.new(v28, 0, 0)
        local v29 = u26.Att2
        local v30 = v22.Magnitude / 2
        v29.Position = -Vector3.new(v30, 0, 0)
    end
    local u31 = 15
    u26.Color = v21
    u26.Massless = true
    u26.CollisionGroup = "Players"
    local u32 = u26:FindFirstChild("Trail")
    if u32 then
        u32.Enabled = u14.TrailEnabled
        u32.Color = ColorSequence.new(v21)
    end
    u26.AssemblyLinearVelocity = u16
    u26.AssemblyAngularVelocity = v17
    u26.Anchored = false
    if u14.customFunction then
        task.spawn(u14.customFunction, u26)
    end
    local u33 = os.clock()
    local u34 = nil
    task.delay(0.1, function() --[[ Line: 91 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u34
            [3] = u26
            [4] = u33
            [5] = u25
            [6] = u4
            [7] = u31
            [8] = u10
            [9] = u13
            [10] = u9
            [11] = u32
            [12] = u16
        --]]
        if u14.Extra ~= nil then
            u34 = u26.Touched:Connect(function(_) --[[ Line: 95 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u25
                    [3] = u26
                    [4] = u34
                    [5] = u4
                    [6] = u31
                    [7] = u10
                    [8] = u13
                    [9] = u9
                    [10] = u32
                    [11] = u14
                    [12] = u16
                --]]
                if os.clock() - u33 < 0.1 then
                    return
                end
                u33 = os.clock()
                u25 = u25 - 1
                if u25 <= 0 or u26.Size.Magnitude <= 2 then
                    u34:Disconnect()
                    u34 = nil
                    return
                end
                u26.AssemblyLinearVelocity = (u26.AssemblyLinearVelocity + u4:NextUnitVector() * Vector3.new(1, 0, 1)).Unit * u26.AssemblyLinearVelocity.Magnitude
                u31 = u31 / 3
                u26.CustomPhysicalProperties = PhysicalProperties.new(0.3, 0.1, 1, 1, u31)
                local v35 = {}
                local v36 = u26.Position
                local v37 = u26.CFrame.LookVector * (u26.Size.Z + 1)
                local v38 = workspace:Raycast(v36, v37, u10)
                local v39 = u26.Position
                local v40 = u26.CFrame.LookVector * -(u26.Size.Z + 1)
                local v41 = workspace:Raycast(v39, v40, u10)
                local v42 = u26.Position
                local v43 = u26.CFrame.RightVector * (u26.Size.X + 1)
                local v44 = workspace:Raycast(v42, v43, u10)
                local v45 = u26.Position
                local v46 = u26.CFrame.RightVector * -(u26.Size.X + 1)
                local v47 = workspace:Raycast(v45, v46, u10)
                local v48 = u26.Position
                local v49 = u26.CFrame.UpVector * (u26.Size.Y + 1)
                __set_list(v35, 1, {v38, v41, v44, v47, workspace:Raycast(v48, v49, u10), u13(u26.Position, u26.CFrame.UpVector * -(u26.Size.Y + 1))})
                for _, v50 in v35 do
                    if v50 then
                        local u51 = u9:GetPart(CFrame.new(v50.Position, v50.Position + v50.Normal) * CFrame.Angles(1.5707963267948966, 0, 0))
                        u51.Transparency = 1
                        u51.CanCollide = false
                        u51.Anchored = true
                        for _, v52 in u51:GetDescendants() do
                            if v52:IsA("ParticleEmitter") then
                                v52.Color = ColorSequence.new(v50.Instance.Color)
                            end
                        end
                        u51:ScaleTo(u26.Size.Magnitude)
                        u26.Trail.Enabled = false
                        _G.customEmit(u51)
                        task.delay(2, function() --[[ Line: 146 ]]
                            --[[
                            Upvalues:
                                [1] = u51
                                [2] = u32
                                [3] = u9
                            --]]
                            u51:ScaleTo(1)
                            if u32 then
                                u32.Enabled = false
                            end
                            u9:ReturnPart(u51)
                        end)
                        if u14.Extra then
                            _G.PlayEffect("RockDebris", nil, {
                                ["PartCount"] = 1,
                                ["RandomVelocityMagnitude"] = Vector2.new(-25, 25),
                                ["Position"] = v50.Position + Vector3.new(0, 1, 0),
                                ["Direction"] = u16,
                                ["RaycastDirection"] = Vector3.new(0, -5, 0),
                                ["Size"] = u26.Size / 4
                            }, true)
                            return
                        end
                        break
                    end
                end
            end)
        end
    end)
    task.delay(v24 * (math.random(90, 110) / 100), function() --[[ Line: 174 ]]
        --[[
        Upvalues:
            [1] = u34
            [2] = u32
            [3] = u2
            [4] = u26
            [5] = u8
        --]]
        if u34 then
            u34:Disconnect()
            u34 = nil
        end
        if u32 then
            u32.Enabled = false
        end
        u2:Create(u26, TweenInfo.new(1), {
            ["Size"] = Vector3.new(0, 0, 0)
        }):Play()
        task.wait(1)
        u26.Anchored = true
        if u32 then
            u32.Enabled = false
        end
        u8:ReturnPart(u26)
    end)
end
return {
    ["start"] = function(_, p53, p54) --[[ Name: start, Line 203 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u4
        --]]
        if _G.checkRenderDistance(p53.Position) == false then
            return
        else
            local v55 = p53.Position - p53.RaycastDirection.Unit
            local v56 = p53.RaycastDirection or Vector3.new(0, -25, 0)
            local v57 = workspace:Raycast(v55, v56, u10)
            if v57 then
                if v57.Instance ~= nil then
                    p53.PartCount = _G.ScaleWithBaseFPS(p53.PartCount)
                    for _ = 1, p53.PartCount do
                        local v58 = u4:NextNumber(-(p53.RandomVelocityMagnitude.X or 25), p53.RandomVelocityMagnitude.Y or 25)
                        local v59 = CreateRock
                        local v60 = {}
                        local v61 = p53.Direction
                        local v62 = u4:NextUnitVector()
                        local v63 = math.abs(v58)
                        v60.Velocity = v61 + v62 * Vector3.new(v58, v63, v58)
                        v60.Position = p53.Position
                        v60.Duration = p53.Duration
                        v60.Color = p53.Color or v57.Instance.Color
                        v60.Material = p53.Material or v57.Material
                        local v64 = p53.Size
                        local v65 = u4:NextNumber(0.85, math.random(3) == 1 and 1.5 or 1.25)
                        local v66 = u4:NextNumber(0.85, math.random(3) == 1 and 1.5 or 1.25)
                        local v67 = u4
                        local v68 = math.random(3) == 1 and 1.5 or 1.25
                        v60.Size = v64 * Vector3.new(v65, v66, v67:NextNumber(0.85, v68))
                        v60.customFunction = p53.customFunction
                        v60.TrailEnabled = p53.TrailEnabled
                        v60.HitPart = v57.Instance
                        v60.Extra = p54
                        v59(v60)
                    end
                end
            else
                return
            end
        end
    end
}