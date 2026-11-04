 

local u1 = nil
local u2 = Instance.new("Highlight")
u2.FillTransparency = 1
u2.OutlineTransparency = 0.6
u2.Name = "PartyHighlight"
u2.FillColor = Color3.fromRGB(0, 255, 0)
u2.OutlineColor = u2.FillColor
u2.DepthMode = Enum.HighlightDepthMode.Occluded
u2.OutlineColor = u2.FillColor
u2.Parent = game.Players.LocalPlayer.PlayerGui.HealthBars
local function v4() --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v3 = script.Parent.targetPlayer.Value.Character
    if u1 == nil then
        u1 = game.Players:GetPlayerFromCharacter(v3)
    end
    if game.Teams:FindFirstChild("Eliminated") and u1.Team == game.Teams.Eliminated then
        script.Parent.Enabled = false
    else
        script.Parent.Enabled = true
    end
    if u2 then
        u2.Adornee = v3
        u2.Enabled = true
    end
    if v3 and v3:findFirstChild("Head") then
        script.Parent.Adornee = v3.Head
    else
        script.Parent.Adornee = workspace.Terrain
    end
end
script.Parent.Destroying:Connect(function() --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2 then
        u2:Destroy()
    end
end)
while true do
    v4()
    if script.Parent.Adornee == workspace.Terrain then
        pcall(function() --[[ Line: 47 ]]
            script.Parent.StudsOffsetWorldSpace = game.ReplicatedStorage.Events.getPartyPosition:InvokeServer(script.Parent.targetPlayer.Value)
        end)
        v4()
    else
        script.Parent.StudsOffsetWorldSpace = Vector3.new()
    end
    task.wait(1)
end