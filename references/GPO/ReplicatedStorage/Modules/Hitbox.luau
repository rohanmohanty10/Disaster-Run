 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.RotatedRegion3)
require(game.ReplicatedStorage.Modules.LowLevel)
local u3 = require(game.ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local u4 = _G.getTargetByPart
local function u13(p5, p6, p7) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v8 = u2.new(p6.CFrame, p6.Size)
    if _G.getTargets == nil then
        require(game.ReplicatedStorage.Modules.SharedGlobals)()
    end
    local v9 = _G.getTargets(p5, nil, nil, nil, nil, p7)
    local v10 = {}
    for _, v11 in ipairs(v9) do
        local v12 = v11.Parent
        table.insert(v10, v12)
    end
    return v8:FindPartsInRegion3WithWhiteList(v10, 5000)
end
function FindNearest(p14, p15)
    local v16 = (1 / 0)
    local v17 = nil
    for v18 = 1, #p15 do
        local v19 = (p15[v18].Position - p14).magnitude
        if v19 < v16 then
            v17 = p15[v18]
            v16 = v19
        end
    end
    return v17
end
local u20 = {}
local _ = game["Run Service"]:IsStudio() == false and game.GameId ~= 2097989947
local u21 = false
function v1.start(_, u22, u23, u24, u25, u26, u27, _, u28, u29, u30, u31) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u21
        [3] = u3
        [4] = u20
    --]]
    tick()
    u4 = _G.getTargetByPart
    task.spawn(function() --[[ Line: 49 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u21
            [3] = u28
            [4] = u22
            [5] = u25
            [6] = u24
            [7] = u3
            [8] = u20
            [9] = u26
            [10] = u27
            [11] = u29
            [12] = u30
            [13] = u31
        --]]
        local v32 = Instance.new("Part")
        v32.Size = u23
        v32.Massless = true
        v32.Transparency = 1
        v32.CanCollide = false
        v32.CastShadow = false
        v32.Color = Color3.fromRGB(255, 0, 0)
        v32.Material = Enum.Material.Neon
        if u21 == true then
            v32.Transparency = 0.75
        end
        v32.Parent = workspace.Effects
        local v33 = Instance.new("Weld")
        if u28 then
            v33.Part0 = u28
        else
            v33.Part0 = u22.HumanoidRootPart
        end
        v33.Name = "hitbox"
        v33.Part1 = v32
        v33.C0 = u25
        v33.Parent = v33.Part1
        _G.destroy(v32, u24)
        local v34 = u3.new()
        local v35 = u20
        local v36 = {
            v32,
            u22,
            u26,
            u27,
            v34,
            tick(),
            u24,
            u29,
            u30,
            u31
        }
        table.insert(v35, v36)
        v34:Wait()
        v34:DisconnectAll()
        v33:Destroy()
        v32:Destroy()
        u27 = nil
        u26 = nil
        u24 = nil
    end)
end
local v37 = game["Run Service"].Heartbeat
if game["Run Service"]:IsClient() == true then
    v37 = game["Run Service"].RenderStepped
end
v37:Connect(function(_) --[[ Line: 94 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u13
        [3] = u4
    --]]
    for v38 = 1, #u20 do
        if u20[v38] then
            local v39 = u20[v38]
            local v40, v41, v42, v43, v44, v45, v46, v47, v48, v49 = unpack(v39)
            if v40 and v40.Parent ~= nil then
                local v50
                if _G.check:inspect(v41) == false then
                    v50 = true
                elseif v48 then
                    v50 = v48() == true
                else
                    v50 = v48
                end
                if not v50 == false and v43 then
                    table.remove(u20, v38)
                    v43()
                    v44:Fire()
                    return
                end
                local v51 = u13(v41, v40, v49)
                local v52 = {}
                if #v51 > 0 then
                    for v53 = 1, #v51 do
                        local v54 = u4(v51[v53]) or v51[v53]
                        if v54 ~= nil and v54 ~= v41 then
                            if v54:FindFirstChild("Humanoid") then
                                if (not v54:FindFirstChild("Rag") or v54.Rag.Value == nil) and (v54:FindFirstChild("gripping") == nil and v52[v54] == nil) then
                                    v52[v54] = true
                                end
                            elseif v54:FindFirstChild("barrelHP") then
                                v52[v54] = true
                            end
                        end
                    end
                    local v55 = {}
                    for v56, _ in v52 do
                        if v56:IsA("Model") and v56.PrimaryPart then
                            local v57 = v56.PrimaryPart
                            table.insert(v55, v57)
                        else
                            local v58 = v56:GetChildren()[1]
                            table.insert(v55, v58)
                        end
                    end
                    if v47 == nil then
                        v55 = FindNearest(v41.HumanoidRootPart.CFrame.p, v55)
                    end
                    if v55 then
                        table.remove(u20, v38)
                        v44:Fire()
                        if _G.check:inspect(v41) == false then
                            v48 = true
                        elseif v48 then
                            v48 = v48() == true
                        end
                        if not v48 == true then
                            v42(v55)
                        end
                    end
                end
                if v46 <= tick() - v45 then
                    table.remove(u20, v38)
                    v44:Fire()
                end
            else
                table.remove(u20, v38)
            end
        end
    end
end)
return v1