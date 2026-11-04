 

local u1 = script.char.Value:WaitForChild("Humanoid")
require(game.ReplicatedStorage.CrewInfo)
local u2 = script.Parent.BackgroundColor3
local u3 = script.Parent.Parent.Parent
local u4 = game.ReplicatedStorage:FindFirstChild("Stats" .. u1.Parent.Name)
task.wait()
local u5 = script.char.Value
local u6 = game.ReplicatedStorage:WaitForChild("CrewsInServer")
local u7 = game.Players:GetPlayerFromCharacter(u5)
local v8 = u5:FindFirstChild("Info")
local function u23() --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u7
        [3] = u3
        [4] = u6
    --]]
    local v9 = game.ReplicatedStorage:FindFirstChild("Stats" .. u5.Name)
    local v10 = require(game.ReplicatedStorage.Modules.Titles)
    local v11 = Color3.fromRGB(0, 0, 0)
    local v12
    if v9 then
        v12 = v9.Titles.EquipedTitle.Value
    else
        v12 = u5:GetAttribute("Title") or ""
    end
    if v10[v12] then
        v11 = v10[v12].RoleColor
    end
    local v13 = script.playerName.Value
    local v14 = "["
    local v15 = "]"
    warn(v12)
    if v12 ~= "" then
        if v10[v12] and v10[v12].StartText ~= nil then
            v14 = v10[v12].StartText .. v14
            v15 = v15 .. v10[v12].EndText
        end
        if v9 then
            if v9.Titles.EquipedTitle.Value == "Content Creator" and game.ReplicatedStorage:FindFirstChild("Matchinfo") ~= nil then
                v13 = u7.UserId
                v11 = Color3.fromRGB(255, 255, 255)
                v12 = "Cabin Boy"
            else
                v13 = script.playerName.Value
            end
        end
        local v16 = v14 .. v12 .. v15
        local v17 = "<font color=\"#" .. tostring(v11:ToHex()) .. "\"><b>" .. v16 .. "</b></font><br/>" .. v13
        script.Parent.Parent.Parent.NameT.Text = v17
    end
    if v9 ~= nil then
        local v18 = v9.Stats.Crew.Value
        if v18 ~= "" then
            local v19 = game.ReplicatedStorage.CrewRemote:InvokeServer({
                ["Method"] = "GetImage",
                ["CrewName"] = v18
            })
            warn("crew logo for " .. v18 .. " is " .. v19)
            u3.CrewFlag.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=" .. v19 .. "&width=420&height=420&format=png"
            u3.CrewName.Text = v9.Stats.Crew.Value
            if u6 then
                local v20 = game:GetService("HttpService"):JSONDecode(u6:GetAttribute("CurrentTop50"))
                for v21, v22 in pairs(v20) do
                    if v22.CrewName == v9.Stats.Crew.Value then
                        u3.CrewName.Text = "<b><font color=\"rgb(255,176,0)\">" .. "[#" .. v21 .. "] " .. "</font></b>" .. v9.Stats.Crew.Value
                        return
                    end
                end
            end
        end
    end
end
local v24 = v8 and (v8:FindFirstChild("Hostile") and v8:FindFirstChild("Hostile").Value == false) and true or false
if not u1:IsA("Humanoid") or v24 == true then
    u23()
    script:Destroy()
    return
end
if _G.isCustomHUB == true then
    script.Parent.Parent.Visible = false
end
local function v26(_) --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
        [4] = u3
    --]]
    if script.Parent ~= nil then
        local v25 = u1.Health / u1.MaxHealth
        script.Parent.BackgroundColor3 = BrickColor.new("Bright red").Color:Lerp(u2, v25)
        script.Parent:TweenSize(UDim2.new(v25, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
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
v26()
u1.HealthChanged:Connect(v26)
if not u4 then
    return
end
u4.Stats.Crew.Changed:Connect(v26);
(function() --[[ Name: updateCrewInfo, Line 134 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u5
        [3] = u4
        [4] = u23
    --]]
    if u7 ~= nil then
        script.playerName.Value = u5.Name
        u4.Titles.EquipedTitle.Changed:Connect(u23)
        u4.Stats.Crew.Changed:Connect(u23)
        script.playerName.Changed:Connect(u23)
        u23()
    end
end)()
u6.AttributeChanged:Connect(function(p27) --[[ Line: 147 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    if p27 == "CurrentTop50" then
        u23()
    end
end)
while true do
    task.wait(1)
    if u7 == true and u5:findFirstChild("Head") then
        u3.Adornee = u5.Head
    end
    if u3.Adornee == nil then
        u3.Adornee = workspace.Terrain
    end
    if (u5:WaitForChild("Head", 100000000000).Position - workspace.CurrentCamera.CFrame.Position).magnitude > 30 then
        return
    end
    if not u1:IsDescendantOf(game) and (script:FindFirstChild("char") == nil or script.char.Value ~= nil and script.char.Value.Parent == nil) then
        u3:Destroy()
        return
    end
    if u1 and u1:IsDescendantOf(workspace.Effects) then
        u3:Destroy()
        return
    end
end