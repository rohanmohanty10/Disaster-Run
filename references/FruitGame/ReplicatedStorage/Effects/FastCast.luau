 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.FastCastRedux).new()
u2.IgnoreDescendantsInstance = { workspace.Effects, game.Players.LocalPlayer.Character, workspace.CurrentCamera }
warn("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tCASTED \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t")
local u3 = {}
local u4 = {}
setmetatable(u4, {
    ["__mode"] = "k"
})
setmetatable(u3, {
    ["__mode"] = "k"
})
local u5 = require(game.ReplicatedStorage.Modules.MaidClass)
local u6 = {}
local _ = _G.getHumanoid
local u7 = {}
local function u11(p8) --[[ Line: 44 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if game["Run Service"]:IsStudio() == false and u7[p8] then
        return u7[p8]
    end
    local v9 = script.FireEffects:GetDescendants()
    for v10 = 1, #v9 do
        if v9[v10].Name == p8 and v9[v10]:IsA("ModuleScript") then
            u7[v9[v10].Name] = v9[v10]
            return v9[v10]
        end
    end
end
function updateRay(_, p12, p13, p14, u15, p16)
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
        [3] = u3
        [4] = u11
    --]]
    local u17 = u4[u15]
    if u17 == nil then
        return
    else
        local v18 = u17.bulletLen
        local u19 = CFrame.new(p12, p12 + p13) * CFrame.new(0, 0, -(p14 - v18)) * u4[u15].offset
        if u15 and (u15.Parent and (u15.Parent:IsA("Model") and u15.Parent.PrimaryPart ~= nil)) then
            u15.Parent:PivotTo(u19)
            u15 = u15.Parent.PrimaryPart
        else
            if not u15 then
                u6[u15]:Destroy()
                u6[u15] = nil
                u3[u15] = nil
                u4[u15] = nil
                pcall(function() --[[ Line: 64 ]] end)
                return
            end
            u15.CFrame = u19
        end
        if u17.delta >= 10 then
            u6[u15]:Destroy()
            u6[u15] = nil
            u3[u15] = nil
            u4[u15] = nil
            pcall(function() --[[ Line: 64 ]] end)
        else
            local u20 = u11(u15.Name)
            if u20 then
                u20 = require(u20)
            end
            if u20 and u20.move ~= nil then
                pcall(function() --[[ Line: 217 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u15
                        [3] = u19
                    --]]
                    u20.move(u15, u19)
                end)
            end
            local v21 = u15.Position.Y
            local v22 = workspace.Env.WaterStuff.Ocean.Position.Y
            local v23 = v21 - v22
            if v21 <= v22 - 1 and (u15:FindFirstChild("Splash") == nil and (v23 < 5 and (v23 > -10 and (u15:FindFirstChild("FinishHit") == nil and u20)))) then
                local v24 = Instance.new("BoolValue")
                v24.Name = "Splash"
                v24.Parent = u15
                pcall(function() --[[ Line: 233 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u15
                    --]]
                    u20.splash(u15, u15.CFrame)
                end)
                if u17.splashRemove ~= nil then
                    pcall(function() --[[ Line: 238 ]]
                        --[[
                        Upvalues:
                            [1] = u15
                            [2] = u20
                            [3] = u19
                            [4] = u17
                        --]]
                        local v25 = Instance.new("BoolValue")
                        v25.Name = "FinishHit"
                        v25.Parent = u15
                        u20.impact(u15, u15, u19.Position, Vector3.new(0, 0, 0), u17)
                    end)
                end
            end
            local _ = game.Players.LocalPlayer.Character
            u17.delta = u17.delta + p16
        end
    end
end
function v1.start(_, p26, u27, u28, p29, p30, _, p31) --[[ Line: 264 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
        [3] = u5
        [4] = u11
        [5] = u2
    --]]
    if p26 and (_G.tick and _G.tick - p26 >= 1) then
        return
    elseif (workspace.CurrentCamera.CFrame.Position - u27.startpos).Magnitude > u27.maxdistance + 500 then
        return
    else
        local v32 = p29 == nil and {} or p29
        local v33 = u27.startpos
        local v34 = u27.bullet
        local v35 = u27.direction * u27.maxdistance
        local v36 = u27.speed
        if u27.ply ~= nil then
            if game.ReplicatedStorage.FCProjectiles:FindFirstChild(v34) then
                local v37 = Instance.new("Model")
                v37.Name = "gun"
                local u38 = game.ReplicatedStorage.FCProjectiles:FindFirstChild(v34):Clone()
                if u38:IsA("Model") and u38.PrimaryPart ~= nil then
                    u38.PrimaryPart.Anchored = true
                end
                u38.Parent = v37
                v37.Parent = workspace.Projectiles
                if workspace.Projectiles:FindFirstChild(u27.ply.Name) then
                    v37.Parent = workspace.Projectiles:FindFirstChild(u27.ply.Name)
                end
                if p30 == nil then
                    p30 = CFrame.Angles(1.5707963267948966, 0, 0)
                end
                if u38:IsA("BasePart") then
                    u38.CFrame = CFrame.new(v33, v33 + v35.Unit) * p30
                else
                    u38:PivotTo(CFrame.new(v33, v33 + v35.Unit) * p30)
                    table.insert(v32, u38)
                    u38 = u38.PrimaryPart
                end
                local v39 = Instance.new("Vector3Value")
                v39.Name = "org"
                v39.Value = v33
                v39.Parent = u38
                u27.offset = p30
                u4[u38] = u27
                u6[u38] = u5.new()
                local v40 = {
                    workspace.Effects,
                    workspace.CurrentCamera,
                    u27.char,
                    workspace.PlayerCharacters.KenHaki
                }
                if v32 then
                    for v41 = 1, #v32 do
                        local v42 = v32[v41]
                        table.insert(v40, v42)
                    end
                end
                if workspace.Projectiles:FindFirstChild(u27.ply.Name) then
                    v37.Parent = workspace.Projectiles:FindFirstChild(u27.ply.Name)
                    local v43 = workspace.Projectiles
                    local v44 = u27.ply.Name
                    table.insert(v40, v43:FindFirstChild(v44))
                end
                if u27.ply.Parent == workspace.NPCs or u27.ply.Parent == workspace.Ships.NPC then
                    v37.Parent = workspace.Projectiles.NPC
                    local v45 = workspace.Projectiles.NPC
                    table.insert(v40, v45)
                    local v46 = workspace.NPCs
                    table.insert(v40, v46)
                end
                if ((u27.ply and (u27.ply:IsA("Player") and u27.ply.Character:FindFirstChild("BusoMelee") or u27.ply:FindFirstChild("BusoMelee")) or u27.buso == true) and true or false) == true then
                    local v47 = Instance.new("BoolValue")
                    v47.Name = "Buso"
                    v47.Parent = u38
                else
                    local v48 = workspace.PlayerCharacters:GetChildren()
                    for v49 = 1, #v48 do
                        if v48[v49]:FindFirstChild("Logia") then
                            local v50 = v48[v49]
                            table.insert(v40, v50)
                        end
                    end
                end
                local v51 = u11(u38.Name)
                if v51 then
                    local u52 = require(v51)
                    pcall(function() --[[ Line: 357 ]]
                        --[[
                        Upvalues:
                            [1] = u52
                            [2] = u28
                            [3] = u38
                        --]]
                        u52:Fire(u28, u38, u38.CFrame)
                    end)
                end
                local u53 = u27.ply
                pcall(function() --[[ Line: 362 ]]
                    --[[
                    Upvalues:
                        [1] = u53
                        [2] = u27
                    --]]
                    u53 = u27.ply.Character
                end)
                if u27.regionBox ~= nil then
                    local v54 = Instance.new("BoolValue")
                    v54.Name = "regionBox"
                    v54.Parent = u38
                end
                u27.bulletLen = u38.Size.Z / 2
                u2:Fire(u53, v33, v35, v36, u38, v40, true, u27.grav, v37, p31)
            end
        end
    end
end
u2.LengthChanged:Connect(updateRay)
u2.RayHit:Connect(function(u55, u56, u57, _, u58, _) --[[ Name: onhit, Line 69 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u11
        [4] = u6
        [5] = u2
    --]]
    local u59 = u4[u58]
    if u59 == nil then
        return
    end
    local _ = u59.ply
    local v60
    if u55 then
        v60 = _G.getHumanoid(u55)
    else
        v60 = nil
    end
    local v61 = u59.canReflect
    local v62 = _G.checkPartIsBarrierFruit(u55)
    if v61 == true and (u59.perfectReflect == true and (u55 and v62 == false)) then
        v61 = false
        if v60 then
            local v63 = v60.Parent:FindFirstChild("Blocking")
            if v63 then
                local v64 = v63.BlockTime.Value
                v61 = _G.tick - v64 <= 0.2 and true or v61
            end
        end
    end
    if u55 then
        if u3[u58] == true or v61 == false then
            ::l16::
            if v62 == false then
                local v65 = u58 and u58.Parent ~= nil and u11(u58.Name)
                if v65 then
                    local u66 = require(v65)
                    pcall(function() --[[ Line: 104 ]]
                        --[[
                        Upvalues:
                            [1] = u56
                            [2] = u66
                            [3] = u58
                            [4] = u55
                            [5] = u57
                            [6] = u59
                        --]]
                        if _G.checkRenderDistance(u56) == true then
                            u66.impact(u58, u55, u56, u57, u59)
                        end
                    end)
                end
                u6[u58]:Destroy()
                u6[u58] = nil
                u3[u58] = nil
                u4[u58] = nil
                pcall(function() --[[ Line: 64 ]] end)
                ::l29::
                return
            end
            goto l14
        end
        if v61 == true then
            local v67
            if v60 == nil then
                v67 = false
            else
                v67 = v60.Parent:FindFirstChild("Reflecting") and true or false
            end
            if v67 ~= false then
                goto l14
            end
            goto l16
        end
    end
    ::l14::
    if u55 then
        if v60 and v61 == true then
            local v68
            if v60 == nil then
                v68 = false
            else
                v68 = v60.Parent:FindFirstChild("Reflecting") and true or false
            end
            if v68 == true then
                ::l39::
                u3[u58] = true
                if u4[u58].reflectTimes == nil then
                    u4[u58].reflectTimes = 0
                end
                u4[u58].reflectTimes = u4[u58].reflectTimes + 1
                if u4[u58].reflectTimes > 25 then
                    u6[u58]:Destroy()
                    u6[u58] = nil
                    u3[u58] = nil
                    u4[u58] = nil
                    pcall(function() --[[ Line: 64 ]] end)
                    u58:Destroy()
                    return
                end
                local u69 = CFrame.new(u56, u56 + u57)
                local v70 = u69.LookVector
                local v71 = v70 - 2 * v70:Dot(u57) * u57
                local v72 = v71.X
                local v73 = v71.Y
                local v74 = -math.clamp(v73, 0.1, 0.2)
                local v75 = v71.Z
                local v76 = Vector3.new(v72, v74, v75)
                if u55 and _G.checkPartIsBarrierFruit(u55) == true then
                    local v77 = Instance.new("Attachment")
                    _G.destroy(v77, 2)
                    v77.WorldCFrame = CFrame.new(u56)
                    v77.Parent = workspace.Terrain
                    local v78 = script.BarrierHits["forcefieldhit" .. math.random(1, 4)]:Clone()
                    v78.Parent = v77
                    v78:Play()
                end
                u58.CFrame = u69
                pcall(function() --[[ Line: 141 ]]
                    --[[
                    Upvalues:
                        [1] = u58
                        [2] = u69
                        [3] = u4
                    --]]
                    u58.CFrame = u69 * u4[u58].offset
                end)
                local v79 = { workspace.Effects, workspace.CurrentCamera, u59.char }
                if v60 then
                    local v80 = v60.Parent
                    table.insert(v79, v80)
                end
                if u58:FindFirstChild("reflected") == nil then
                    local v81 = Instance.new("BoolValue")
                    v81.Name = "reflected"
                    v81.Parent = u58
                end
                u2:Fire(u4[u58].ply, u56, -v76 * 1000, u59.speed, u58, v79, true, u59.grav)
                local _ = game.Players.LocalPlayer == u59.ply
                local v82 = script.Part.Attachment:Clone()
                v82.Parent = workspace.Terrain
                v82.WorldPosition = u56
                _G.destroy(v82, 0.2)
                v82.ParticleEmitter:Emit(1)
                local v83 = script.SFX["S" .. math.random(1, 2)]:Clone()
                v83.Parent = u58
                v83:Play()
                if u58:FindFirstChild("OrgA") then
                    u58.OrgA.Value.WorldPosition = u56
                end
                if v60 and (v60.Parent == game.Players.LocalPlayer.Character and v62 == false) then
                    local _, _, _, v84, _, _, v85, _, _, v86, _, _ = v60.Parent.HumanoidRootPart.CFrame:components()
                    local v87 = v84 * v70.x + v85 * v70.y + v86 * v70.z
                    local v88 = v87 < 0 and -1 or (v87 > 0 and 1 or 0)
                    local v89
                    if v88 == -1 then
                        v89 = v60:LoadAnimation(script.Anims.R1)
                    elseif v88 == 1 then
                        v89 = v60:LoadAnimation(script.Anims.R3)
                    else
                        v89 = v60:LoadAnimation(script.Anims.R2)
                    end
                    v89:Play()
                end
                goto l29
            end
        end
        if v62 ~= true then
            goto l29
        end
        goto l39
    end
    goto l29
end)
return v1