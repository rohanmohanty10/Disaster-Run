 

local v1, _, _, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
repeat
    task.wait()
until v1 and (v1.Character and (v1.Character:FindFirstChild("Humanoid") and _G.tween ~= nil))
while game.Players.LocalPlayer.Character == nil do
    task.wait()
end
local v2 = false
local function v8(p3) --[[ Line: 11 ]]
    local v4 = (p3 - p3 % 60) / 60
    local v5 = p3 - v4 * 60
    local v6 = (v4 - v4 % 60) / 60
    local v7 = v4 - v6 * 60
    return (v6 <= 0 and "" or string.format("%02i", v6) .. ":") .. string.format("%02i", v7) .. ":" .. string.format("%02i", v5)
end
while true do
    task.wait(1)
    if v2 == false and game.ReplicatedStorage.reservedCode:GetAttribute("battleRoyale") ~= nil then
        v1.PlayerGui.Quest.Enabled = false
        v2 = true
    end
    if v2 then
        local v9 = game.Players:GetPlayers()
        local v10 = 0
        for v11 = 1, #v9 do
            if v9[v11].Team == game.Teams:FindFirstChild("Players") then
                v10 = v10 + 1
            end
        end
        script.Parent.playersRemain.Visible = true
        if game.ReplicatedStorage.reservedCode:GetAttribute("matchTime") then
            script.Parent.time.Visible = true
            script.Parent.grips.Visible = true
            script.Parent.time.Text = v8(game.ReplicatedStorage.reservedCode:GetAttribute("matchTime"))
        end
        local v12 = game.Players.LocalPlayer:GetAttribute("playersEliminated")
        local v13 = v12 == nil and 0 or v12
        script.Parent.grips.Text = "\240\159\146\128 " .. v13
        script.Parent.playersRemain.Text = tostring(v10) .. " PLAYERS REMAIN"
    end
end