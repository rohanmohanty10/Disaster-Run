 

local v1 = game:GetService("TeleportService")
local v2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedFirst")
local v4 = v1:GetArrivingTeleportGui()
if v4 then
    local v5 = v2.LocalPlayer:WaitForChild("PlayerGui")
    v3:RemoveDefaultLoadingScreen()
    v4.Parent = v5
    local v6 = script.LoadingGUI:Clone()
    v6.Parent = game.Players.LocalPlayer.PlayerGui
    v6.CanvasGroup.LocalScript.Disabled = false
    v4:Destroy()
end
game:GetService("TeleportService"):SetTeleportGui(script:WaitForChild("LoadingGUI"))