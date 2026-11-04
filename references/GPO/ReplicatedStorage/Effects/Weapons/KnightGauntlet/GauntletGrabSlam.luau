 

local u1 = game:GetService("TweenService")
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v3 = {}
local u4 = nil
local u5 = script:WaitForChild("Rocks"):GetChildren()
local u6 = script:WaitForChild("SmallRocks"):GetChildren()
function GetFloorPos(p7)
    local v8 = RaycastParams.new()
    local v9 = { workspace.Islands, workspace.Env, workspace.Ships }
    local v10 = Enum.RaycastFilterType.Whitelist
    v8.FilterDescendantsInstances = v9
    v8.FilterType = v10
    local v11 = workspace:Raycast(p7, Vector3.new(0, -500, 0), v8) or {
        ["Position"] = Vector3.new(0, 0, 0),
        ["Normal"] = Vector3.new(1, 1, 1)
    }
    return v11.Position, v11.Normal
end
function CreateEffect(p12, p13)
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    local v14 = script:WaitForChild(p12):Clone()
    u2.apply(v14, u4)
    v14.CFrame = p13
    v14.Parent = workspace.Effects
    _G.customEmit(v14.Attachment)
    _G.destroy(v14, 2)
    return v14
end
function RandomRocks(p15)
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
        [3] = u4
        [4] = u1
    --]]
    local v16, v17 = GetFloorPos(p15)
    local v18 = Random.new()
    local v19 = v18:NextInteger(10, 17)
    for v20 = 1, v19 do
        local v21 = 360 / v19 * v20
        local v22 = math.rad(v21)
        local v23 = v18:NextNumber(10, 14)
        local v24 = (CFrame.new(v16, v16 + v17) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(math.cos(v22) * v23, 0, math.sin(v22) * v23)).Position
        local v25 = RaycastParams.new()
        local v26 = { workspace.Islands, workspace.Env, workspace.Ships }
        local v27 = Enum.RaycastFilterType.Whitelist
        v25.FilterDescendantsInstances = v26
        v25.FilterType = v27
        local v28 = workspace:Raycast(v24 + Vector3.new(0, 1, 0), v17 * -5, v25)
        if v28 then
            local v29 = v28.Position
            local v30 = Vector3.new(0, v18:NextNumber(-2, -1))
            local v31 = CFrame.Angles(0, v18:NextNumber(-0.5235987755982988, 0.5235987755982988), 0)
            local v32 = CFrame.new(v29 + v30, v16 - Vector3.new(0, 5, 0)) * v31
            local u33 = u5[math.random(1, #u5)]:Clone()
            u2.apply(u33, u4)
            u33:PivotTo(v32)
            local v34 = next
            local v35, v36 = u33:GetChildren()
            for _, v37 in v34, v35, v36 do
                u1:Create(v37, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["CFrame"] = v37.CFrame
                }):Play()
            end
            u33:PivotTo(CFrame.new(v16, v16 - Vector3.new(0, 25, 0)) * v31)
            u33.Parent = workspace.Effects
            _G.matchMaterial(u33.Land, v28.Instance)
            task.delay(0.016666666666666666 * v18:NextInteger(1, 12) + 0.5, function() --[[ Line: 67 ]]
                --[[
                Upvalues:
                    [1] = u33
                --]]
                _G.destroy(u33, 0.75)
                local v38 = next
                local v39, v40 = u33:GetChildren()
                for _, v41 in v38, v39, v40 do
                    _G.tween(v41, { 0.75, "Back", Enum.EasingDirection.In }, {
                        ["Size"] = Vector3.new(),
                        ["CFrame"] = v41.CFrame * CFrame.new(0, -1.25, 0)
                    })
                end
            end)
        end
    end
end
function CreateMesh(p42, p43)
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    local v44 = script:WaitForChild("CurvedImage"):Clone()
    u2.apply(v44, u4)
    v44.CFrame = p43 * CFrame.Angles(0, -1.5707963267948966, 0)
    v44.Parent = workspace.Effects
    v44.Decal.Texture = "rbxassetid://" .. p42
    return v44
end
function FlyingRocks(p45)
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u4
    --]]
    local v46 = RaycastParams.new()
    local v47 = { workspace }
    local v48 = Enum.RaycastFilterType.Whitelist
    v46.FilterDescendantsInstances = v47
    v46.FilterType = v48
    local v49 = workspace:Raycast(p45 + Vector3.new(0, 1, 0), Vector3.new(0, -5, 0), v46)
    if v49 then
        local v50 = Random.new()
        for _ = 1, v50:NextInteger(3, 6) do
            local u51 = u6[math.random(1, #u6)]:Clone()
            u2.apply(u51, u4)
            u51:PivotTo(CFrame.new(v49.Position))
            u51.Parent = workspace.Effects
            _G.matchMaterial(u51.Land, v49.Instance)
            local v52 = next
            local v53, v54 = u51:GetChildren()
            for _, v55 in v52, v53, v54 do
                v55.Anchored = false
            end
            local v56 = Instance.new("BodyAngularVelocity")
            local v57 = Instance.new("BodyVelocity")
            local v58 = v50:NextUnitVector() * 10
            v56.MaxTorque = Vector3.new(25000000, 25000000, 25000000)
            v56.AngularVelocity = v58
            v56.P = 1250
            local v59 = v50:NextNumber(-1, 1)
            local v60 = v50:NextNumber(0.25, 1)
            v57.Velocity = Vector3.new(v59, v60, v50:NextNumber(-1, 1)) * 45
            v57.MaxForce = Vector3.new(50000000, 50000000, 50000000)
            local v61 = u51.PrimaryPart
            local v62 = u51.PrimaryPart
            v57.Parent = v61
            v56.Parent = v62
            _G.destroy(v57, 0.3)
            task.delay(0.15, function() --[[ Line: 112 ]]
                --[[
                Upvalues:
                    [1] = u51
                --]]
                _G.destroy(u51, 2)
                local v63 = next
                local v64, v65 = u51:GetChildren()
                for _, v66 in v63, v64, v65 do
                    _G.tween(v66, { 0.5, "Cubic", Enum.EasingDirection.In }, {
                        ["Size"] = Vector3.new()
                    })
                end
            end)
        end
    end
end
function Hitbox(p67)
    local v68 = OverlapParams.new()
    local v69 = Enum.RaycastFilterType.Blacklist
    v68.FilterDescendantsInstances = { p67 }
    v68.FilterType = v69
    local v70 = workspace:GetPartBoundsInBox(p67.PrimaryPart.CFrame * CFrame.new(0, 0, -3), Vector3.new(4, 4, 6), v68)
    for _, v71 in next, v70 do
        local v72 = v71.Parent:FindFirstChild("Humanoid") or v71.Parent.Parent:FindFirstChild("Humanoid")
        if v72 then
            return v72
        end
    end
end
function v3.start(_, u73, p74) --[[ Line: 138 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u1
    --]]
    local v75 = not p74 and game.Players.LocalPlayer
    if v75 then
        v75 = game.Players.LocalPlayer.Character
    end
    u4 = v75
    if _G.checkRenderDistance(u73.Position) then
        local v76, _, _ = _G.getRayFloor(u73, 15)
        local v77 = CreateEffect("Smash", u73 * CFrame.new(0, -3, 0))
        if v76 then
            v77.Attachment.Smoke.Color = ColorSequence.new(v76.Color)
        end
        RandomRocks(u73.Position)
        for _ = 1, 2 do
            local v78 = CreateMesh("9628867585", u73 * CFrame.new(0, 3, 0) * CFrame.Angles(-1.5707963267948966, 0, 0))
            v78.Mesh.Scale = Vector3.new(0.398, 0.295, 0.278)
            v78.Decal.Transparency = 0.75
            _G.tween(v78, { 0.4, "Quint", Enum.EasingDirection.Out }, {
                ["CFrame"] = v78.CFrame * CFrame.new(-7, 0, 0) * CFrame.new(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0, 0)
            })
            _G.tween(v78.Mesh, { 0.5, "Cubic", Enum.EasingDirection.Out }, {
                ["Scale"] = Vector3.new(0.166, 0.847, 0.795)
            })
            _G.tween(v78.Decal, { 0.4, "Quad", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            _G.destroy(v78, 0.5)
        end
        local v79 = CreateMesh("9622368924", u73 * CFrame.new(0, 5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0))
        v79.Mesh.Scale = Vector3.new(0.45, 0.125, 0.125)
        v79.Decal.Transparency = 0.75
        _G.tween(v79, { 0.3, "Quint", Enum.EasingDirection.Out }, {
            ["CFrame"] = v79.CFrame * CFrame.new(-7, 0, 0) * CFrame.new(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0, 0)
        })
        _G.tween(v79.Mesh, { 0.2, "Cubic", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(0, 0.686, 0.618)
        })
        _G.tween(v79.Decal, { 0.3, "Quad", Enum.EasingDirection.Out }, {
            ["Transparency"] = 1
        })
        _G.destroy(v79, 0.3)
        task.spawn(function() --[[ Line: 174 ]]
            --[[
            Upvalues:
                [1] = u73
                [2] = u2
                [3] = u4
                [4] = u1
            --]]
            local v80, v81 = GetFloorPos(u73.Position)
            local u82 = script:WaitForChild("Cracks"):Clone()
            u2.apply(u82, u4)
            u82.CFrame = CFrame.new(v80, v80 + v81) * CFrame.Angles(-1.5707963267948966, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0)
            u82.Parent = workspace.Effects
            u82.Size = Vector3.new(0, 0, 0)
            u1:Create(u82, TweenInfo.new(0.125, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(31.399, 0.002, 32.656)
            }):Play()
            task.delay(0.5, function() --[[ Line: 184 ]]
                --[[
                Upvalues:
                    [1] = u82
                    [2] = u1
                --]]
                _G.destroy(u82, 2)
                local v83 = next
                local v84, v85 = u82:GetChildren()
                for _, v86 in v83, v84, v85 do
                    u1:Create(v86, TweenInfo.new(1 + Random.new():NextNumber(0.5, 1), Enum.EasingStyle.Cubic), {
                        ["Transparency"] = 1
                    }):Play()
                end
            end)
        end)
        task.wait(0.1)
        FlyingRocks(u73.Position)
        task.spawn(function() --[[ Line: 197 ]]
            --[[
            Upvalues:
                [1] = u73
                [2] = u2
                [3] = u4
                [4] = u1
            --]]
            local v87, v88 = GetFloorPos(u73.Position)
            local u89 = script:WaitForChild("Burn"):Clone()
            u2.apply(u89, u4)
            u89.CFrame = CFrame.new(v87, v87 + v88) * CFrame.Angles(-1.5707963267948966, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0)
            u89.Parent = workspace.Effects
            u89.Size = Vector3.new(0, 0, 0)
            u1:Create(u89, TweenInfo.new(0.125, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(31.399, 0.002, 32.656)
            }):Play()
            task.delay(0.5, function() --[[ Line: 207 ]]
                --[[
                Upvalues:
                    [1] = u89
                    [2] = u1
                --]]
                _G.destroy(u89, 2)
                u1:Create(u89.Decal, TweenInfo.new(1 + Random.new():NextNumber(0.5, 1), Enum.EasingStyle.Cubic), {
                    ["Transparency"] = 1
                }):Play()
            end)
        end)
        local v90 = CreateEffect("Explosion", u73 * CFrame.new(0, -3, 0))
        if v76 then
            v90.Attachment.Smoke.Color = ColorSequence.new(v76.Color)
        end
        local v91 = u73.Position
        local v92 = CreateMesh("9572542664", CFrame.new(v91 + Vector3.new(0, 3, 0), v91 - Vector3.new(0, 2, 0)))
        v92.Mesh.Scale = Vector3.new(0.225, 0.578, 0.541)
        _G.tween(v92.Mesh, { 0.2, "Quint", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(1.036, 0, 0)
        })
        _G.tween(v92, { 0.2, "Quint", Enum.EasingDirection.Out }, {
            ["CFrame"] = v92.CFrame * CFrame.new(14, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
        })
        _G.destroy(v92, 0.2)
        for _ = 1, 2 do
            local v93 = CreateMesh("9626892087", u73 * CFrame.new(0, -3, 0) * CFrame.Angles(-1.5707963267948966, 0, 0))
            v93.Mesh.Scale = Vector3.new(0, 0, 0)
            v93.Decal.Transparency = 0
            _G.tween(v93, { 0.4, "Quint", Enum.EasingDirection.Out }, {
                ["CFrame"] = v93.CFrame * CFrame.new(-2, 0, 0) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0, 0)
            })
            _G.tween(v93.Mesh, { 0.5, "Cubic", Enum.EasingDirection.Out }, {
                ["Scale"] = Vector3.new(0.2075, 1.05875, 0.99375004)
            })
            _G.tween(v93.Decal, { 0.4, "Quad", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            _G.destroy(v93, 1)
        end
    end
end
return v3