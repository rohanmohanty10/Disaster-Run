 

repeat
    task.wait()
until game.Players.LocalPlayer
local u1 = game.Players.LocalPlayer
local u2 = nil
local u3 = 0
task.spawn(function() --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    u2 = u1:WaitForChild("Loaded")
end)
task.spawn(function() --[[ Line: 9 ]]
    game:GetService("ContentProvider"):PreloadAsync({ script.Parent })
end)
task.spawn(function() --[[ Line: 12 ]] end)
script.Parent.LogoText.UIGradient.Enabled = true
local function v7(p4, p5) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v6 = 0
    while true do
        if tick() - v6 >= 0.2 then
            script.Parent.TextLabel.Text = p4 .. string.rep(".", u3)
            u3 = u3 + 1
            if u3 >= 4 then
                u3 = 0
            end
            v6 = tick()
        end
        game["Run Service"].Heartbeat:Wait()
        if p5() == true then
            return
        end
    end
end
if workspace:FindFirstChild("Islands") then
    v7("Server Initializing", function() --[[ Line: 50 ]]
        return workspace.Islands:GetAttribute("ready") == true
    end)
end
v7("Loading Player Info", function() --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1:GetAttribute("banLoaded") ~= nil
end)
v7("Loading Data", function() --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v8
    if u2 == nil or u2.Value ~= true then
        v8 = false
    else
        v8 = u1:GetAttribute("banLoaded") ~= nil
    end
    return v8
end)
game.ReplicatedStorage:WaitForChild("Stats" .. u1.Name, 300)
if game.ReplicatedStorage:WaitForChild("AFKHUB", 2) == nil then
    script.Parent.hint.Visible = true
    v7("Processing Inventory", function() --[[ Line: 69 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1:GetAttribute("inventoryVerified") == true
    end)
    script.Parent.hint.Visible = false
end
if u1:GetAttribute("royaleDataLoaded") ~= nil then
    local u9 = tick()
    v7("Loading Battle Royale Data", function() --[[ Line: 79 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u1
        --]]
        if tick() - u9 >= 30 then
            script.Parent.hint.Visible = true
            script.Parent.hint.Text = "(may take up to 2 mins)"
        end
        return u1:GetAttribute("royaleDataLoaded") == true
    end)
    script.Parent.hint.Visible = false
end
local u10 = workspace:FindFirstChild("NPCs")
if u10 and u10:GetAttribute("fullyLoaded") == nil then
    v7("Loading NPCs", function() --[[ Line: 92 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        return u10:GetAttribute("fullyLoaded") ~= nil
    end)
end
script.Parent.TextLabel.Text = "Loaded!"
local v11 = workspace:WaitForChild("Env", 3)
if v11 then
    v11:WaitForChild("WaterStuff")
end
if game.ReplicatedStorage:FindFirstChild("playerLoaded") then
    repeat
        task.wait()
    until game:IsLoaded() == true
    local v12, _, _, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get(true)
    if not v12.Character then
        v12.CharacterAdded:Wait()
    end
    local v13 = tick()
    local v14 = game.Players.LocalPlayer.Character:GetModelSize()
    while true do
        task.wait()
        if _G.getRayFloor and (game.Players.LocalPlayer.Character ~= nil and game.Players.LocalPlayer.Character.PrimaryPart ~= nil) then
            local _, _, _ = _G.getRayFloor(game.Players.LocalPlayer.Character.PrimaryPart.CFrame, v14.Y / 2 + 1)
            if game.Players.LocalPlayer.Character.PrimaryPart.Position.Y < workspace.Env.WaterStuff.Falls.Position.Y + 5 then
                break
            end
        end
        if tick() - v13 >= 30 or game.Players.LocalPlayer and (game.Players.LocalPlayer.Character and (game.Players.LocalPlayer.Character.PrimaryPart ~= nil and game.Players.LocalPlayer.Character.Humanoid.FloorMaterial ~= Enum.Material.Air)) then
            break
        end
    end
    game.ReplicatedStorage.playerLoaded:FireServer()
elseif game.Players.LocalPlayer.Character == nil and game.ReplicatedStorage:FindFirstChild("HUB") == nil then
    game.Players.LocalPlayer.CharacterAdded:Wait()
    task.wait(1)
end
local v15 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
game:GetService("TweenService"):Create(script.Parent.LogoText, v15, {
    ["ImageTransparency"] = 1
}):Play()
local v16 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
game:GetService("TweenService"):Create(script.Parent.TextLabel, v16, {
    ["TextTransparency"] = 1
}):Play()
_G.destroy(script.Parent, 1)
_G.loadingFinished = true