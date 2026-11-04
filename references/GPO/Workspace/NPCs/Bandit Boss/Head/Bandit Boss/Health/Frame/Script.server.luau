 

local u1 = script.char.Value:WaitForChild("Humanoid")
local u2 = script.Parent.BackgroundColor3
local u3 = script.Parent.Parent.Parent
local u4 = game.ReplicatedStorage:FindFirstChild("Stats" .. u1.Parent.Name)
task.wait()
local u5 = script.char.Value
local u6 = game.ReplicatedStorage:WaitForChild("CrewsInServer")
local u7 = game.Players:GetPlayerFromCharacter(u5)
local v8 = u5:FindFirstChild("Info")
local u9 = script.Parent.Parent.Parent.device
local function u24() --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u7
        [3] = u3
        [4] = u6
    --]]
    local v10 = game.ReplicatedStorage:FindFirstChild("Stats" .. u5.Name)
    local v11 = require(game.ReplicatedStorage.Modules.Titles)
    local v12 = Color3.fromRGB(0, 0, 0)
    local v13
    if v10 then
        v13 = v10.Titles.EquipedTitle.Value
    else
        v13 = u5:GetAttribute("Title") or ""
    end
    if v11[v13] then
        v12 = v11[v13].RoleColor
    end
    local v14 = script.playerName.Value
    local v15 = "["
    local v16 = "]"
    if v13 ~= "" then
        if v11[v13] and v11[v13].StartText ~= nil then
            v15 = v11[v13].StartText .. v15
            v16 = v16 .. v11[v13].EndText
        end
        if v10 then
            if v10.Titles.EquipedTitle.Value == "Content Creator" and game.ReplicatedStorage:FindFirstChild("Matchinfo") ~= nil then
                v14 = u7.UserId
                v12 = Color3.fromRGB(255, 255, 255)
                v13 = "Cabin Boy"
            else
                v14 = script.playerName.Value
            end
        end
        local v17 = v15 .. v13 .. v16
        local v18 = "<font color=\"#" .. tostring(v12:ToHex()) .. "\"><b>" .. v17 .. "</b></font><br/>" .. v14
        script.Parent.Parent.Parent.NameT.Text = v18
    end
    if v10 ~= nil then
        local v19 = v10.Stats.Crew.Value
        if v19 ~= "" then
            local v20 = game.ReplicatedStorage.CrewRemote:InvokeServer({
                ["Method"] = "GetImage",
                ["CrewName"] = v19
            })
            u3.CrewFlag.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=" .. v20 .. "&width=420&height=420&format=png"
            u3.CrewName.Text = v10.Stats.Crew.Value
            if u6 and u6:GetAttribute("CurrentTop50") then
                local v21 = game:GetService("HttpService"):JSONDecode(u6:GetAttribute("CurrentTop50"))
                for v22, v23 in pairs(v21) do
                    if v23.CrewName == v10.Stats.Crew.Value then
                        u3.CrewName.Text = "<b><font color=\"rgb(255,176,0)\">" .. "[#" .. v22 .. "] " .. "</font></b>" .. v10.Stats.Crew.Value
                        return
                    end
                end
            end
        end
    end
end
local u25 = {
    ["Mobile"] = "rbxassetid://14942108734",
    ["Controller"] = "rbxassetid://14959700721"
}
local function v27() --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u7
        [3] = u25
        [4] = u9
    --]]
    if u7 and (_G.arena == false or _G.arena == true and _G.arenaMatchStarted == nil) then
        local v26 = u7:GetAttribute("Device")
        if u25[v26] then
            u9.Image = u25[v26]
            u9.shadow.Image = u25[v26]
            u9.Visible = true
        else
            u9.Visible = false
        end
    else
        u9.Visible = false
        return
    end
end
local v28 = v8 and (v8:FindFirstChild("Hostile") and v8:FindFirstChild("Hostile").Value == false) and true or false
v27()
if not u1:IsA("Humanoid") or v28 == true then
    u24()
    u3.Enabled = true
    script:Destroy()
    return
end
if _G.isCustomHUB == true then
    script.Parent.Parent.Visible = false
end
local function v30(_) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
        [4] = u3
    --]]
    if script.Parent ~= nil then
        local v29 = u1.Health / u1.MaxHealth
        script.Parent.BackgroundColor3 = BrickColor.new("Bright red").Color:Lerp(u2, v29)
        script.Parent:TweenSize(UDim2.new(v29, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        if u4 then
            if u4.Stats.Crew.Value ~= "" then
                u3.CrewName.Visible = true
                u3.CrewFlag.Visible = true
                u3.TotalBounty.Visible = true
                return
            end
            u3.TotalBounty.Visible = false
            u3.CrewName.Visible = false
            u3.CrewFlag.Visible = false
        end
    end
end
v30()
u1.HealthChanged:Connect(v30)
if not u4 then
    return
end
if u7 then
    u7:GetAttributeChangedSignal("Device", v27)
end
u4.Stats.Crew.Changed:Connect(v30);
(function() --[[ Name: updateCrewInfo, Line 162 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u5
        [3] = u4
        [4] = u24
    --]]
    if u7 ~= nil then
        script.playerName.Value = u5.Name
        u4.Titles.EquipedTitle.Changed:Connect(u24)
        u4.Stats.Crew.Changed:Connect(u24)
        script.playerName.Changed:Connect(u24)
        u24()
    end
end)()
u6.AttributeChanged:Connect(function(p31) --[[ Line: 175 ]]
    --[[
    Upvalues:
        [1] = u24
    --]]
    if p31 == "CurrentTop50" then
        u24()
    end
end)
u3.Enabled = true
local v32 = script.Parent.Parent.Parent.inCombat
while true do
    if u7 == true and u5:findFirstChild("Head") then
        u3.Adornee = u5.Head
    end
    if u3.Adornee == nil then
        u3.Adornee = workspace.Terrain
    end
    if (u5:WaitForChild("Head", 100000000000).Position - workspace.CurrentCamera.CFrame.Position).magnitude > 30 then
        task.wait(1)
    else
        if not u1:IsDescendantOf(game) and (script:FindFirstChild("char") == nil or script.char.Value ~= nil and script.char.Value.Parent == nil) then
            u3:Destroy()
            return
        end
        if u1 and u1:IsDescendantOf(workspace.Effects) then
            u3:Destroy()
            return
        end
        if u5:FindFirstChild("inCombat") then
            v32.Visible = true
        else
            v32.Visible = false
        end
        task.wait(0.1)
    end
end