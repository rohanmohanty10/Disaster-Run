 

local u1 = game:GetService("Players")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
local u4 = u1.LocalPlayer:WaitForChild("PlayerGui")
local v5 = u2:WaitForChild("Modules")
local u6 = require(v5.Trove)
local v7 = v5.Shared
require(v7.GameUtils)
u2:WaitForChild("Events")
local u8 = u2.Assets.NPCCircle
local u80 = {
    ["Initialized"] = false,
    ["Initialize"] = function(p9) --[[ Name: Initialize, Line 35 ]]
        --[[
        Upvalues:
            [1] = u80
            [2] = u2
            [3] = u4
            [4] = u6
            [5] = u3
            [6] = u1
            [7] = u8
        --]]
        if not u80.Initialized then
            p9:GetStatsFolder()
            local u10 = u2:WaitForChild("Replication"):WaitForChild("Bosses")
            local u11 = u4:WaitForChild("BossHP", 360):WaitForChild("Main")
            local u12 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local u13 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local u14 = nil
            local u15 = {}
            local u16 = {}
            local function v58(u17) --[[ Line: 55 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u6
                    [3] = u10
                    [4] = u11
                    [5] = u3
                    [6] = u12
                    [7] = u16
                    [8] = u13
                    [9] = u1
                    [10] = u14
                    [11] = u8
                --]]
                if u15[u17] ~= nil then
                    return
                end
                u15[u17] = {
                    ["Trove"] = u6.new()
                }
                local u18 = u17.Value
                while u18 == nil do
                    u18 = u17.Value
                    if u18 ~= nil or u17.Parent ~= u10 then
                        break
                    end
                    task.wait(1)
                end
                if u18 == nil then
                    return
                end
                local u19 = u18.Parent
                repeat
                    task.wait()
                until #u19:GetChildren() > 1 and u19.PrimaryPart ~= nil
                if u15[u17] == nil then
                    u15[u17] = {
                        ["Trove"] = u6.new()
                    }
                end
                if u19 == nil then
                    return
                end
                local v20 = u19:FindFirstChild("Head")
                local u21 = script.HealthBar:Clone()
                u21.Name = u19.Name
                u21.Parent = u11
                u21.Visible = false
                u15[u17].Trove:Add(u21)
                u15[u17].HealthBar = u21
                u15[u17].Marker = u19:FindFirstChild("questMarker")
                local u22 = u21.DamageFrame
                local u23 = u22.List
                local v24 = u21.NPCName
                local u25 = u21.Health
                v24.Text = u19.Name
                v24.Shadow.Text = u19.Name
                local function u36(p26, p27, p28) --[[ Line: 107 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                        [2] = u21
                        [3] = u3
                        [4] = u12
                        [5] = u16
                        [6] = u13
                    --]]
                    local v29 = math.floor(p27)
                    local v30 = math.max(v29, 0)
                    local v31 = math.floor(p28)
                    local v32 = v30 / v31
                    local u33 = math.clamp(v32, 0, 1)
                    local v34 = p26.Fill
                    local u35 = p26.FillLag
                    u25.Text = ("%* / %*"):format(v30, v31)
                    u25.Shadow.Text = u25.Text
                    if u21.Visible == false then
                        v34.Size = UDim2.new(u33, 0, 1, 0)
                        u35.Size = UDim2.new(u33, 0, 1, 0)
                    else
                        u3:Create(v34, u12, {
                            ["Size"] = UDim2.new(u33, 0, 1, 0)
                        }):Play()
                        if u16[p26] and coroutine.status(u16[p26]) ~= "dead" then
                            task.defer(task.cancel, u16[p26])
                        end
                        u16[p26] = task.delay(0.35, function() --[[ Line: 139 ]]
                            --[[
                            Upvalues:
                                [1] = u3
                                [2] = u35
                                [3] = u13
                                [4] = u33
                            --]]
                            u3:Create(u35, u13, {
                                ["Size"] = UDim2.new(u33, 0, 1, 0)
                            }):Play()
                        end)
                    end
                end
                local function u52() --[[ Line: 150 ]]
                    --[[
                    Upvalues:
                        [1] = u19
                        [2] = u21
                        [3] = u22
                        [4] = u1
                        [5] = u23
                        [6] = u18
                    --]]
                    local v37 = u19:FindFirstChild("PlayerDMG")
                    if v37 and u21.Visible == true then
                        local v38 = v37:GetChildren()
                        if #v38 <= 0 then
                            u22.Visible = false
                        else
                            u22.Visible = true
                            for _, v39 in ipairs(v38) do
                                local v40 = u1:FindFirstChild(v39.Name)
                                if v40 then
                                    local v41 = u23:FindFirstChild(v40.Name)
                                    if v41 == nil then
                                        v41 = script.PlayerTemplate:Clone()
                                        v41.Name = v40.Name
                                        v41.Parent = u23
                                    end
                                    local v42 = "%*: %*%%"
                                    local v43 = v40.Name
                                    local v44 = v39.Value / u18.MaxHealth * 100
                                    local v45 = math.pow(10, 2 or 0)
                                    local v46 = v44 * v45
                                    local v47
                                    if v46 >= 0 then
                                        local v48 = v46 + 0.5
                                        v47 = math.floor(v48)
                                    else
                                        local v49 = v46 - 0.5
                                        v47 = math.ceil(v49)
                                    end
                                    local v50 = v42:format(v43, v47 / v45)
                                    v41.Text = v50
                                    v41.Shadow.Text = v50
                                    v41.LayoutOrder = 100 - v39.Value / u18.MaxHealth * 100
                                    if v39.Value / u18.MaxHealth >= 0.05 then
                                        v41.TextColor3 = Color3.fromRGB(170, 255, 127)
                                    end
                                end
                            end
                            for _, v51 in ipairs(u23:GetChildren()) do
                                if v51:IsA("PlayerDamageDisplay") and u23:FindFirstChild(v51.Name) == nil then
                                    v51:Destroy()
                                end
                            end
                        end
                    else
                        u22.Visible = false
                        return
                    end
                end
                local function v53() --[[ Line: 194 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                        [2] = u14
                        [3] = u21
                        [4] = u36
                        [5] = u52
                    --]]
                    if u18.Health <= 0 then
                        if u14 == u21 then
                            u21.Visible = false
                            u14 = nil
                        end
                    else
                        u36(u21, u18.Health, u18.MaxHealth)
                        u52()
                    end
                end
                if u15[u17].Marker == nil then
                    local v54 = u8:Clone()
                    v54.Name = "questMarker"
                    local v55 = u19:GetDescendants()
                    local v56 = nil
                    for v57 = 1, #v55 do
                        if v55[v57]:IsA("BillboardGui") and v55[v57].Parent.Name ~= "HumanoidRootPart" then
                            v56 = v55[v57]
                            break
                        end
                    end
                    v54.Parent = u19
                    if v56 == nil then
                        v54.Adornee = v20
                    else
                        v54.Adornee = v56.Parent
                        v54.StudsOffsetWorldSpace = v56.StudsOffsetWorldSpace
                    end
                    u15[u17].Marker = v54
                    u15[u17].Marker.Enabled = false
                else
                    u15[u17].Marker.Enabled = false
                end
                if u18.Health <= 0 then
                    if u14 == u21 then
                        u21.Visible = false
                        u14 = nil
                    end
                else
                    u36(u21, u18.Health, u18.MaxHealth)
                    u52()
                end
                u15[u17].Trove:Add(u18.HealthChanged:Connect(v53))
                u15[u17].Trove:Add(u21:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 239 ]]
                    --[[
                    Upvalues:
                        [1] = u15
                        [2] = u17
                        [3] = u21
                        [4] = u52
                    --]]
                    if u15[u17].Marker ~= nil then
                        u15[u17].Marker.Enabled = u21.Visible
                        if u21.Visible == true then
                            u52()
                        end
                    end
                end))
            end
            u10.ChildAdded:Connect(v58)
            u10.ChildRemoved:Connect(function(p59) --[[ Name: BossRemoved, Line 249 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                if u15[p59] then
                    u15[p59].Trove:Destroy()
                    u15[p59] = nil
                end
            end)
            local u60 = u14
            for _, v61 in ipairs(u10:GetChildren()) do
                task.spawn(v58, v61)
            end
            task.spawn(function() --[[ Line: 280 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u60
                --]]
                while true do
                    task.wait()
                    local v62 = {}
                    for v63, _ in pairs(u15) do
                        local v64 = workspace.CurrentCamera
                        local v65 = v63.Value
                        local v66
                        if v65 then
                            v66 = v65.Parent
                        else
                            v66 = v65
                        end
                        local v67 = v63:GetAttribute("viewRange") or 100
                        if v66 ~= nil and (v66.PrimaryPart ~= nil and (v66.Parent == workspace.NPCs and (v65.Health > 0 and (v65:GetAttribute("notNPC") == nil and (v63 and (v66 and v65)))))) then
                            local v68 = (v64.CFrame.Position - v66.PrimaryPart.Position).Magnitude
                            if v68 <= v67 then
                                table.insert(v62, {
                                    ["Boss"] = v66,
                                    ["Distance"] = v68,
                                    ["BossObject"] = v63
                                })
                            end
                        end
                    end
                    table.sort(v62, function(p69, p70) --[[ Line: 324 ]]
                        return p69.Distance < p70.Distance
                    end)
                    local v71 = false
                    for _, v72 in ipairs(v62) do
                        local v73 = v72.Boss
                        local v74 = workspace.CurrentCamera
                        local v75 = v74.CFrame.LookVector
                        local v76 = v73.PrimaryPart
                        local v77 = v75:Dot((v76.Position - v74.CFrame.Position).Unit)
                        local _, v78 = v74:WorldToScreenPoint(v76.Position)
                        if (v78 == true and true or v77 >= -0.2836910914865273) == true then
                            v71 = true
                            if u60 ~= nil and u60.Parent ~= nil then
                                u60.Visible = false
                                u60 = nil
                            end
                            local v79 = u15[v72.BossObject]
                            if v79 then
                                u60 = v79.HealthBar
                                if u60 then
                                    u60.Visible = true
                                end
                            end
                        end
                    end
                    if v71 == false and (u60 ~= nil and u60.Parent ~= nil) then
                        u60.Visible = false
                        u60 = nil
                    end
                end
            end)
            u80.Initialized = true
        end
    end
}
return u80