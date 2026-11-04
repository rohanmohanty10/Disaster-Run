 

local v1 = game:GetService("ReplicatedStorage")
script.Parent:RemoveDefaultLoadingScreen()
game:GetService("Chat")
game.Players.LocalPlayer:WaitForChild("PlayerGui")
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Captures, false)
if game:GetService("TeleportService"):GetArrivingTeleportGui() == nil then
    local v2 = game.ReplicatedFirst:WaitForChild("lodascreen"):WaitForChild("LoadingGUI"):Clone()
    v2.Parent = game.Players.LocalPlayer.PlayerGui
    v2.CanvasGroup.LocalScript.Disabled = false
end
game.ReplicatedFirst:RemoveDefaultLoadingScreen()
local v3 = v1:WaitForChild("Modules")
v3:WaitForChild("CustomDeb")
_G.destroy = require(v3.CustomDeb)
local v4 = tick()
warn("Inting", "SharedGlobals")
warn("Took " .. tick() - v4, "SharedGlobals")
_G.fastsp = require(v3:WaitForChild("FastSpawn"))
function _G.checkRenderDistance(p5, p6) --[[ Line: 44 ]]
    local v7 = _G.mobile == true and 600 or 1024
    local v8 = _G.fastmode == true and 400 or v7
    local v9 = p6 or (_G.omegabooster == true and 200 or v8)
    if typeof(p5) == "CFrame" then
        p5 = p5.Position
    end
    return v9 >= (p5 - workspace.CurrentCamera.CFrame.Position).magnitude
end
local u10 = {}
local u11 = nil
local u12 = 0
local u13 = game.ReplicatedStorage:WaitForChild("Effects")
local function u17() --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u13
    --]]
    local v14 = {}
    u11 = u13:GetDescendants()
    for v15 = 1, #u11 do
        if u11[v15]:IsA("ModuleScript") and u11[v15].Parent:IsA("Folder") then
            local v16 = u11[v15]
            table.insert(v14, v16)
        end
    end
    table.clear(u11)
    u11 = v14
end
local u18 = game["Run Service"]:IsStudio()
function _G.getEffect(u19) --[[ Line: 95 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u17
        [3] = u10
        [4] = u18
        [5] = u12
    --]]
    if u11 == nil then
        u17()
    end
    if u10[u19] and u18 == false then
        return u10[u19]
    end
    if u18 == true and tick() - u12 >= 1 then
        u17()
        u12 = tick()
    end
    if game.Players.LocalPlayer == nil then
        repeat
            task.wait()
        until game.Players.LocalPlayer
    end
    local u20 = u11
    local u21 = nil
    for u22 = 1, #u20 do
        if u20[u22] ~= nil and (u20[u22]:IsA("ModuleScript") and (u20[u22].Name == u19 and u20[u22].Parent.Name ~= "Modules")) then
            local v23, v24 = pcall(function() --[[ Line: 115 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u19
                    [3] = u20
                    [4] = u22
                    [5] = u21
                --]]
                u10[u19] = require(u20[u22])
                u21 = u10[u19]
            end)
            if v23 == false then
                warn("error: " .. v24)
            end
            break
        end
    end
    return u21
end
require(v3:WaitForChild("SharedGlobals"))()
_G.clientEffectsFolder = u13