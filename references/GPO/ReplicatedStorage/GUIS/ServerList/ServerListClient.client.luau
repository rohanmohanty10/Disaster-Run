 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("TeleportService")
local u2 = game:GetService("Players")
local v3 = v1:WaitForChild("Modules").Client
local u4 = require(v3:WaitForChild("UIUtils"))
local u5 = u2.LocalPlayer
local v6 = script.Parent:WaitForChild("Main")
local u7 = v6:WaitForChild("List")
local v8 = v6:WaitForChild("Refresh")
local u9 = v6:WaitForChild("CanCapture")
local u10 = v6:WaitForChild("ListedServers")
local u11 = v6:WaitForChild("SearchBox")
local v12 = v6:WaitForChild("Region")
local u13 = v12:WaitForChild("List")
local u14 = v1:WaitForChild("ServerListRemote")
local u15 = v1:WaitForChild("Stats" .. u5.Name, 360)
if u15 then
    u15 = u15:WaitForChild("Stats")
end
if u15 then
    u15 = u15:WaitForChild("Crew")
end
local u16 = nil
local u17 = {}
local u18 = false
local u19 = {}
task.spawn(function() --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u19
    --]]
    local v20, u21 = pcall(u2.GetFriendsAsync, u2, u5.UserId)
    if v20 then
        while true do
            for _, v22 in ipairs(u21:GetCurrentPage()) do
                u19[v22.Id] = true
            end
            if u21.IsFinished or not pcall(function() --[[ Line: 48 ]]
                --[[
                Upvalues:
                    [1] = u21
                --]]
                u21:AdvanceToNextPageAsync()
            end) then
                goto l2
            end
        end
    else
        ::l2::
        return
    end
end)
local function u27() --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u7
        [3] = u16
        [4] = u18
    --]]
    local v23 = u11.Text
    local v24 = string.lower(v23)
    for _, v25 in pairs(u7:GetChildren()) do
        if v25:IsA("Frame") then
            local v26 = not u16 or u16 == v25:GetAttribute("Region")
            if u18 == true then
                if v25:GetAttribute("CanCaptureIslands") == true then
                    v25.Visible = v26 and string.find(string.lower(v25.Name), v24) and true or false
                else
                    v25.Visible = false
                end
            else
                v25.Visible = v26 and string.find(string.lower(v25.Name), v24) and true or false
            end
        end
    end
end
u13.ChildAdded:Connect(function(u28) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u27
    --]]
    u28.Activated:Connect(function() --[[ Line: 86 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u28
            [3] = u27
        --]]
        u16 = u28:GetAttribute("Region")
        u27()
    end)
end)
local u29 = script.RegionTemplate:Clone()
u29.Name = "Any"
u29.Text = "Any"
u29.LayoutOrder = -1
u29.Parent = u13
v12.Activated:Connect(function() --[[ Line: 98 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    u13.Visible = not u13.Visible
end)
u11:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 102 ]]
    --[[
    Upvalues:
        [1] = u27
    --]]
    u27()
end)
u9.MouseButton1Click:Connect(function() --[[ Line: 106 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u18
        [3] = u9
        [4] = u27
    --]]
    u4.ButtonEffect()
    u18 = not u18
    u9.Text = u18 and "X" or ""
    u27()
end)
v8.MouseButton1Click:Connect(function() --[[ Line: 116 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u14
    --]]
    u4.ButtonEffect()
    _G.displayMessage("Refreshing...")
    u14:FireServer({
        ["Method"] = "Refresh"
    })
    _G.displayMessage("<Color=Green>Refreshed!")
end)
local u30 = {}
local u31 = false
u14.OnClientEvent:Connect(function(p32) --[[ Line: 127 ]]
    --[[
    Upvalues:
        [1] = u31
        [2] = u30
        [3] = u7
        [4] = u14
        [5] = u19
        [6] = u15
        [7] = u17
        [8] = u13
        [9] = u10
        [10] = u29
        [11] = u27
    --]]
    if u31 ~= true then
        u31 = true
        local v33 = p32.ServerInfo
        local v34 = p32.Listings
        local v35 = 0
        local v36 = {}
        local v37 = {}
        for _, v38 in pairs(v34) do
            v35 = v35 + 1
            local v39 = v38.key
            local u40 = v38.value
            local v41 = nil
            if u30[v39] == nil then
                v41 = script.ServerFrameTemplate:Clone()
                v41.Name = u40.ServerName .. u40.Region .. (u40.CanCaptureIslands and " \240\159\143\180\226\128\141" or "")
                v41.Parent = u7
                v41:SetAttribute("CanCaptureIslands", u40.CanCaptureIslands or false)
                local v42 = v41.Join
                if u40.JobId == v33.JobId then
                    v41.LayoutOrder = -1
                    v42.Visible = false
                end
                v42.MouseButton1Click:Connect(function() --[[ Line: 162 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u40
                    --]]
                    u14:FireServer({
                        ["Method"] = "Teleport",
                        ["JobId"] = u40.JobId,
                        ["PlaceId"] = u40.PlaceId
                    })
                end)
                u30[v39] = v41
                v36[v39] = v38
            elseif u30[v39] ~= nil then
                v41 = u30[v39]
                v36[v39] = v38
            end
            if v41 ~= nil then
                v41:SetAttribute("CanCaptureIslands", u40.CanCaptureIslands or false)
                local v43 = v41.Info
                local v44 = v41.ServerName
                local v45 = false
                if u40.JobId == v33.JobId then
                    v44.Text = "[CURRENT SERVER] "
                    v41.LayoutOrder = -1000
                    v45 = true
                else
                    v44.Text = ""
                end
                v44.Text = v44.Text .. u40.ServerName .. (u40.CanCaptureIslands and " \240\159\143\180\226\128\141" or "")
                local v46 = os.time() - u40.ServerStartTime or 0
                local v47 = v46 % 60
                local v48 = math.floor(v47)
                local v49 = v46 / 60 % 60
                local v50 = math.floor(v49)
                local v51 = v46 / 3600 % 24
                local v52 = math.floor(v51)
                local v53 = v46 / 86400
                local v54 = math.floor(v53)
                local v55
                if v54 > 0 then
                    v55 = string.format("%d days %.2d:%.2d:%.2d", v54, v52, v50, v48)
                else
                    v55 = string.format("%.2d:%.2d:%.2d", v52, v50, v48)
                end
                v43.Text = ("Region: <font color=\"rgb(177,167,255)\">%s</font> Players: <font color=\"rgb(255,176,0)\">%s/%s</font> <font color=\"rgb(255,176,0)\">%s</font> Age: <font color=\"rgb(255,176,0)\">%s</font>"):format(u40.Region, u40.TotalPlayers, u40.MaxPlayers, u40.Version or "???", v55)
                v41:SetAttribute("Region", u40.Region)
                local v56 = (v45 and -1000 or 0) - u40.TotalPlayers
                if v37[u40.Region] == nil then
                    v37[u40.Region] = 0
                end
                local v57 = u40.Region
                v37[v57] = v37[v57] + 1
                local v58 = u40.UserIds
                local v59 = {}
                local v60 = 0
                for v61, v62 in pairs(v58) do
                    if v59[v62] == nil then
                        v59[v62] = 1
                    else
                        v59[v62] = v59[v62] + 1
                    end
                    if u19[tonumber(v61)] then
                        v60 = v60 + 1
                    end
                end
                if v60 >= 1 then
                    v41.friendInfo.Text = "+" .. v60 .. " Friends"
                    v56 = v56 - v60 * 100
                else
                    v41.friendInfo.Text = ""
                end
                if v59[u15.Value] == nil or u15.Value == "" then
                    v41.crewInfo.Text = ""
                elseif v45 == true and v59[u15.Value] > 1 or v45 == false then
                    local v63 = v59[u15.Value]
                    if v45 == true then
                        v63 = v63 - 1
                    end
                    v41.crewInfo.Text = "+" .. v63 .. " Crewmates"
                    v56 = v56 - v63 * 100
                end
                v41.LayoutOrder = v56
            end
        end
        local v64 = table.clone(u17)
        for v65, v66 in pairs(v37) do
            if v65 ~= "Unknown, Unknown" then
                local v67 = u17[v65] or u13:FindFirstChild(v65)
                if v67 == nil then
                    v67 = script.RegionTemplate:Clone()
                end
                v67.Text = ("%* (%*)"):format(v65, v66)
                v67.Name = v65
                v67:SetAttribute("Region", v65)
                v67.Parent = u13
                u17[v65] = v67
                v64[v65] = nil
            end
        end
        for v68, _ in pairs(v64) do
            u17[v68]:Destroy()
            u17[v68] = nil
        end
        for v69, v70 in pairs(u30) do
            if v36[v69] == nil then
                v70:Destroy()
                u30[v69] = nil
            end
        end
        u10.Text = string.format("[%s] Listed Servers: %s", v33.Sea, v35)
        u29.Text = ("Any (%*)"):format(v35)
        u27()
        u31 = false
    end
end)