 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local u4 = nil
function ApplyProperties(u5, p6)
    for u7, v8 in next, p6 do
        if pcall(function() --[[ Line: 9 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u7
            --]]
            return u5[u7] ~= nil
        end) then
            u5[u7] = v8
        end
    end
end
function RandomRocks(p9)
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v10, v11 = GetFloorPos(p9)
    local v12 = Random.new()
    local v13 = v12:NextInteger(4, 6)
    for v14 = 1, v13 do
        local v15 = 360 / v13 * v14
        local v16 = math.rad(v15)
        local v17 = v12:NextNumber(12, 14)
        local v18 = (CFrame.new(v10, v10 + v11) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(math.cos(v16) * v17, 0, math.sin(v16) * v17)).Position
        local v19 = RaycastParams.new()
        local v20 = { workspace.Ships, workspace.Islands, workspace.Env }
        local v21 = Enum.RaycastFilterType.Whitelist
        v19.FilterDescendantsInstances = v20
        v19.FilterType = v21
        local v22 = workspace:Raycast(v18 + Vector3.new(0, 1, 0), v11 * -5, v19)
        if v22 then
            local v23 = Vector3.new(0, v12:NextNumber(0, 1))
            local v24 = CFrame.Angles(0, v12:NextNumber(-0.5235987755982988, 0.5235987755982988), 0)
            local v25 = CFrame.new(v18 + v23, v10) * v24
            local u26 = script:WaitForChild("Debris"):Clone()
            u3.apply(u26, u4)
            u26.Size = u26.Size * v12:NextNumber(1.2, 1.8)
            u26.CFrame = CFrame.new(v10, v10 - v11 * 10) * v24
            u26.Parent = workspace.Effects
            _G.matchMaterial(u26, v22.Instance)
            _G.tween(u26, { 0.3, "Quint", Enum.EasingDirection.Out }, {
                ["CFrame"] = v25
            })
            task.delay(0.016666666666666666 * v12:NextInteger(1, 12) + 0.5, function() --[[ Line: 45 ]]
                --[[
                Upvalues:
                    [1] = u26
                --]]
                _G.tween(u26, { 0.75, "Back", Enum.EasingDirection.In }, {
                    ["Size"] = Vector3.new(),
                    ["CFrame"] = u26.CFrame * CFrame.new(0, -1.25, 0)
                })
                _G.destroy(u26, 0.75)
            end)
        end
    end
end
function GetFloorPos(p27)
    local v28 = RaycastParams.new()
    local v29 = { workspace.Ships, workspace.Islands, workspace.Env }
    local v30 = Enum.RaycastFilterType.Whitelist
    v28.FilterDescendantsInstances = v29
    v28.FilterType = v30
    local v31 = workspace:Raycast(p27, Vector3.new(0, -500, 0), v28) or {
        ["Position"] = Vector3.new(0, 0, 0),
        ["Normal"] = Vector3.new(1, 1, 1)
    }
    return v31.Position, v31.Normal
end
function CreateEffect(p32, p33)
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v34 = script:WaitForChild(p32):Clone()
    u3.apply(v34, u4)
    v34.CFrame = p33
    v34.Parent = workspace.Effects
    _G.customEmit(v34.Attachment)
    _G.destroy(v34, 2)
    return v34
end
function CreateMesh(p35, p36)
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v37 = script:WaitForChild("MeshImage"):Clone()
    u3.apply(v37, u4)
    v37.CFrame = p36 * CFrame.Angles(0, -1.5707963267948966, 0)
    v37.Parent = workspace.Effects
    v37.Decal.Texture = "rbxassetid://" .. p35
    return v37
end
function v1.start(_, u38, p39, p40, p41) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
    --]]
    u4 = u38
    if u38.PrimaryPart == nil then
        return
    elseif _G.checkRenderDistance(u38.PrimaryPart.Position) then
        if p39 == "slam" then
            local function v44() --[[ Line: 92 ]]
                --[[
                Upvalues:
                    [1] = u38
                --]]
                local v42 = u38.PrimaryPart:GetChildren()
                for v43 = 1, #v42 do
                    if v42[v43].Name == "galtlet" then
                        v42[v43]:Destroy()
                    end
                end
            end
            if p41 == nil then
                v44()
                return
            elseif _G.checkRenderDistance(u38.PrimaryPart.Position) then
                local v45 = CreateMesh("9622414579", CFrame.new(p40 + Vector3.new(0, 3, 0), p40 - Vector3.new(0, 2, 0)))
                v45.Mesh.Scale = Vector3.new(0.354, 0.124, 0.169)
                _G.tween(v45, { 0.5, "Quad", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v45.CFrame * CFrame.new(-7, 0, 0)
                })
                _G.tween(v45.Mesh, { 0.5, "Cubic", Enum.EasingDirection.Out }, {
                    ["Scale"] = Vector3.new(0.161, 1.011, 0.978)
                })
                _G.tween(v45.Decal, { 0.4, "Cubic", Enum.EasingDirection.Out }, {
                    ["Transparency"] = 1
                })
                local v46 = CreateMesh("9572542664", CFrame.new(p40 + Vector3.new(0, 3, 0), p40 - Vector3.new(0, 2, 0)))
                v46.Mesh.Scale = Vector3.new(0.225, 0.578, 0.541)
                _G.tween(v46.Mesh, { 0.2, "Quint", Enum.EasingDirection.Out }, {
                    ["Scale"] = Vector3.new(1.036, 0, 0)
                })
                _G.tween(v46, { 0.2, "Quint", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v46.CFrame * CFrame.new(14, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
                })
                local v47 = CreateMesh("9626892087", CFrame.new(p40 + Vector3.new(0, 3, 0), p40 - Vector3.new(0, 2, 0)))
                _G.tween(v47.Mesh, { 0.25, "Quint", Enum.EasingDirection.Out }, {
                    ["Scale"] = Vector3.new(0.088, 0.678, 0.657)
                })
                _G.tween(v47.Decal, { 0.25, "Quint", Enum.EasingDirection.Out }, {
                    ["Transparency"] = 1
                })
                _G.tween(v47, { 0.25, "Quint", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v47.CFrame * CFrame.new(-7, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
                })
                _G.destroy(v46, 0.2)
                _G.destroy(v45, 1)
                _G.destroy(v47, 0.5)
                local v48 = CreateEffect("Smash", CFrame.new(p40 - Vector3.new(0, 2.5, 0)))
                local v49, _, _ = _G.getRayFloor(CFrame.new(p40), 15)
                if v49 then
                    v48.Attachment.Smoke.Color = ColorSequence.new(v49.Color)
                    v48.Attachment.ImpactSmoke.Color = ColorSequence.new(v49.Color)
                    v48.Attachment.Rocks.Color = ColorSequence.new(v49.Color)
                end
                task.spawn(RandomRocks, p40)
                local v50, v51 = GetFloorPos(p40)
                local u52 = script:WaitForChild("ImageFloor"):Clone()
                u3.apply(u52, u4)
                u52.CFrame = CFrame.new(v50, v50 + v51) * CFrame.Angles(-1.5707963267948966, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0)
                u52.Parent = workspace.Effects
                u52.Size = Vector3.new(0, 0, 0)
                u2:Create(u52, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Size"] = Vector3.new(31.399, 0.002, 32.656)
                }):Play()
                task.delay(1.5, function() --[[ Line: 153 ]]
                    --[[
                    Upvalues:
                        [1] = u52
                        [2] = u2
                    --]]
                    _G.destroy(u52, 1)
                    local v53 = next
                    local v54, v55 = u52:GetChildren()
                    for _, v56 in v53, v54, v55 do
                        u2:Create(v56, TweenInfo.new(Random.new():NextNumber(0.5, 1), Enum.EasingStyle.Cubic), {
                            ["Transparency"] = 1
                        }):Play()
                    end
                end)
                local v57 = Instance.new("Part")
                local v58 = p40 - Vector3.new(0, 3, 0)
                local v59 = Color3.new(1, 1, 1)
                v57.Size = Vector3.new(0, 0, 0)
                v57.Position = v58
                v57.Anchored = true
                v57.CanCollide = false
                v57.Color = v59
                v57.Material = Enum.Material.ForceField
                local v60 = Enum.PartType.Ball
                v57.Transparency = -2.5
                v57.CastShadow = false
                v57.Shape = v60
                v57.Parent = workspace.Effects
                _G.tween(v57, { 0.3, "Cubic", Enum.EasingDirection.Out }, {
                    ["Size"] = Vector3.new(40, 40, 40),
                    ["Transparency"] = 3
                })
                _G.destroy(v57, 0.3)
                v44()
            end
        elseif p39 == "jump" then
            CreateEffect("Jump", p40 * CFrame.new(0, -2.75, 0))
            local v61 = {}
            for v62 = -1, 1, 2 do
                local v63 = Instance.new("Attachment")
                v63.Parent = u38.PrimaryPart
                local v64 = v62 * 2
                v63.Position = Vector3.new(v64, 0, 0)
                v63.Name = "galtlet"
                table.insert(v61, v63)
            end
            local v65 = script:WaitForChild("Trail"):Clone()
            u3.apply(v65, u38)
            v65.Parent = u38.PrimaryPart
            v65.Name = "galtlet"
            v65.Attachment1 = v61[1]
            v65.Attachment0 = v61[2]
        elseif p39 == "follow" then
            if game.Players.LocalPlayer.Character == u38 then
                return
            end
            local v66, u67, u68, u69 = unpack(p41)
            local u70 = nil
            local u71 = (v66 - u67 - Vector3.new(0, -98.1, 0)) / 1
            local u72 = 0
            u70 = game["Run Service"].Heartbeat:Connect(function(p73) --[[ Line: 199 ]]
                --[[
                Upvalues:
                    [1] = u38
                    [2] = u70
                    [3] = u72
                    [4] = u71
                    [5] = u67
                    [6] = u69
                    [7] = u68
                --]]
                if u38.PrimaryPart == nil then
                    u70:Disconnect()
                    u70 = nil
                    return
                else
                    local v74 = u72 + p73 * 1.5
                    local v75 = CFrame.new(Vector3.new(0, -98.1, 0) * v74 * v74 + u71 * v74 + u67)
                    local v76 = Ray.new(u38.HumanoidRootPart.CFrame.Position, (u38.HumanoidRootPart.CFrame.Position - v75.Position).unit * -(u38.HumanoidRootPart.CFrame.Position - v75.Position).Magnitude)
                    local v77, _ = _G.raycastWhitelist(v76, { workspace.Islands, workspace.Env, workspace.Ships })
                    Ray.new(u38.HumanoidRootPart.CFrame.Position, (u38.HumanoidRootPart.CFrame.Position - v75.Position).unit * (u38.HumanoidRootPart.CFrame.Position - v75.Position).Magnitude / 2)
                    if v77 then
                        u70:Disconnect()
                        u70 = nil
                        return
                    elseif u69:IsDescendantOf(game) == false then
                        u70:Disconnect()
                        u70 = nil
                    else
                        u38.HumanoidRootPart.CFrame = CFrame.new(CFrame.new(Vector3.new(0, -98.1, 0) * u72 * u72 + u71 * u72 + u67).Position, u68)
                        u72 = u72 + p73 * 1.5
                    end
                end
            end)
        end
    else
        return
    end
end
return v1