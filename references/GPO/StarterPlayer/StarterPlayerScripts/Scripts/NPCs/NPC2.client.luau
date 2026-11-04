 

local _, _, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
repeat
    task.wait()
until game.Players.LocalPlayer.PlayerGui
repeat
    task.wait()
until game.Players.LocalPlayer.PlayerGui:FindFirstChild("HealthBars")
repeat
    task.wait()
until game.Players.LocalPlayer.Character
task.wait(2)
local u1 = require(script.HealthBar)
local u2 = require(script.NPCAnimation)
local v3 = workspace.NPCs:GetChildren()
local function u12(u4) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u4:WaitForChild("Info", 3) == nil then
        return
    else
        local v5 = u4:FindFirstChild("Info")
        if v5:FindFirstChild("SeaNPC") == nil then
            u4:WaitForChild("Humanoid")
            if v5 == nil then
                return
            elseif v5:FindFirstChild("AnimationStyle") ~= nil then
                u2:animate(u4, v5.AnimationStyle.Value)
                if u4.Humanoid:IsA("Humanoid") and u4.Humanoid:GetAttribute("deadSet") == nil then
                    u4.Humanoid:SetAttribute("deadSet", true)
                    local u6 = nil
                    u6 = u4.Humanoid.HealthChanged:Connect(function(p7) --[[ Line: 31 ]]
                        --[[
                        Upvalues:
                            [1] = u4
                            [2] = u6
                        --]]
                        if p7 <= 0 then
                            local v8 = u4:FindFirstChild("damageHighlight")
                            if v8 then
                                v8:Destroy()
                            end
                            u6:Disconnect()
                            u6 = nil
                            local v9 = u4:GetDescendants()
                            for v10 = 1, #v9 do
                                if v9[v10]:IsA("BasePart") then
                                    v9[v10].Transparency = 1
                                    v9[v10].Anchored = true
                                    if v9[v10].Parent == u4 then
                                        local v11 = script.ParticleEmitter:Clone()
                                        v11.Name = "deathVFX"
                                        v11.Parent = v9[v10]
                                        _G.customEmit(v11)
                                        _G.destroy(v11, 1)
                                    end
                                elseif v9[v10]:IsA("ParticleEmitter") and (v9[v10].Name ~= "deathVFX" and v9[v10].Enabled == true) then
                                    v9[v10]:Clear()
                                    v9[v10]:Destroy()
                                elseif v9[v10]:IsA("BillboardGui") or (v9[v10]:IsA("Beam") or v9[v10]:IsA("Decal")) then
                                    v9[v10]:Destroy()
                                end
                            end
                        end
                    end)
                end
            end
        else
            return
        end
    end
end
local u13 = {}
for v14 = 1, #v3 do
    task.spawn(u12, v3[v14])
end
local v15 = game.ReplicatedStorage:FindFirstChild("NPCCache")
workspace.NPCs.ChildAdded:Connect(function(p16) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    local v17 = p16:WaitForChild("Info", 10)
    if v17 == nil then
        return
    else
        p16:WaitForChild("HumanoidRootPart", 10)
        if v17 == nil then
            return
        elseif v17:FindFirstChild("SeaNPC") == nil then
            if p16:FindFirstChild("animated") then
                p16:FindFirstChild("animated"):Destroy()
            end
            u12(p16)
        end
    end
end)
workspace.NPCs.ChildRemoved:Connect(function(u18) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u2
    --]]
    if u18:FindFirstChild("animated") then
        u18:FindFirstChild("animated"):Destroy()
    end
    if u13[u18] then
        u13[u18]:Stop()
        u13[u18]:Destroy()
        u13[u18] = nil
    end
    pcall(function() --[[ Line: 102 ]]
        --[[
        Upvalues:
            [1] = u18
        --]]
        local v19 = u18:GetDescendants()
        for v20 = 1, #v19 do
            if v19[v20]:IsA("BodyVelocity") or v19[v20]:IsA("BodyGyro") then
                v19[v20]:Destroy()
            end
        end
    end)
    pcall(function() --[[ Line: 110 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u18
        --]]
        u2:remove(u18)
    end)
end)
local u21 = {}
local function u32(u22) --[[ Line: 116 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u32
    --]]
    u22:WaitForChild("Head", 300)
    local v23 = script.NPCAnimation.Overhead:Clone()
    v23.Name = u22.Name
    v23.NameT.Text = u22.Name
    v23.Health.Frame.Script.char.Value = u22
    v23.Adornee = u22.Head
    v23.Parent = game.Players.LocalPlayer.PlayerGui.HealthBars
    v23.Health.Frame.Script.Disabled = false
    local v24 = Instance.new("ObjectValue", u22.Head)
    v24.Name = "Overhead"
    v24.Value = v23
    local v25 = u21
    table.insert(v25, { u22, v23 })
    local u26 = nil
    u26 = u22.ChildAdded:Connect(function(p27) --[[ Line: 131 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u22
            [3] = u26
            [4] = u32
        --]]
        if p27.Name == "Head" then
            for u28 = 1, #u21 do
                pcall(function() --[[ Line: 134 ]]
                    --[[
                    Upvalues:
                        [1] = u21
                        [2] = u28
                        [3] = u22
                    --]]
                    local v29 = u21[u28]
                    local v30, v31 = unpack(v29)
                    if v30 == u22 then
                        v31:Destroy()
                        table.remove(u21, u28)
                    end
                end)
            end
            u26:Disconnect()
            u26 = nil
            u32(u22)
        end
    end)
end
local function u35(p33) --[[ Line: 149 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if not p33:FindFirstChild("noOverhead") then
        if p33 == game.Players.LocalPlayer.Character or p33.Name == game.Players.LocalPlayer.Character.Name then
            local v34 = game.ReplicatedStorage:FindFirstChild("Stats" .. game.Players.LocalPlayer.Name)
            if v34 and v34.Settings.ShowLocalPlayerBar.Value == false then
                return
            end
        end
        u1:addBar(p33)
    end
end
workspace.PlayerCharacters.ChildAdded:Connect(function(p36) --[[ Line: 163 ]]
    --[[
    Upvalues:
        [1] = u35
    --]]
    u35(p36)
end)
local v37 = workspace.PlayerCharacters:GetChildren()
for v38 = 1, #v37 do
    if v37[v38]:IsA("Model") then
        print("estting for " .. v37[v38].Name)
        u35(v37[v38])
    end
end
game.ReplicatedStorage.Events.clientCommand.OnClientEvent:Connect(function(p39, p40) --[[ Line: 177 ]]
    local v41 = game.Players.LocalPlayer.PlayerGui.HealthBars:GetChildren()
    for v42 = 1, #v41 do
        if v41[v42].Name == p39 then
            v41[v42].Health.Frame.Script.playerName.Value = p40
            warn("CHANGED NAME!!")
        end
    end
end)
require(game.ReplicatedStorage.Modules.NPCInteractions):getquests()
if v15 == nil then
    Instance.new("Folder", game.ReplicatedStorage).Name = "NPCCache"
end