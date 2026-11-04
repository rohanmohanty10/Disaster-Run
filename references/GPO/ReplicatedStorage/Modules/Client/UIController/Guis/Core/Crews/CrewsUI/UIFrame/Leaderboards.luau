 

game:GetService("TweenService")
game:GetService("MarketplaceService")
local u1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local u3 = game:GetService("HttpService")
local _ = v2.LocalPlayer
local v4 = u1.Modules
local v5 = v4.Shared
require(v5.CrewUtils)
local v6 = v4.Client
local u7 = require(v6.ItemDisplay)
return {
    ["Setup"] = function(p8) --[[ Name: Setup, Line 20 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
            [3] = u7
        --]]
        local _ = p8.CrewsUI
        local u9 = p8.Frame
        local u10 = u9:WaitForChild("Frame"):WaitForChild("List")
        local u11 = u9:WaitForChild("Title")
        local u12 = {}
        local function u22(p13, p14) --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u10
            --]]
            local v15 = p14.CrewName
            local v16 = p14.CrewImage
            local v17 = p14.Infamy
            local v18 = p14.Members
            local v19 = u12[v15] or script.CrewTemplate:Clone()
            v19.LayoutOrder = p13
            v19.Parent = u10
            v19.Name = v15
            local v20 = v19.Info
            v20.Rank.Text = "#" .. p13
            v20.Portrait.Image = ("https://www.roblox.com/asset-thumbnail/image?assetId=%*&width=420&height=420&format=png"):format(v16)
            v20.Crew.Text = v15
            v20.Infamy.Text = v17 .. " Infamy"
            local v21 = p14.IsMarineFaction == true and "Marine" or "Pirate"
            v20.Members.Text = v18 .. " " .. ({
                ["Marine"] = "<font color=\"rgb(51, 184, 255)\">Marines</font>",
                ["Pirate"] = "<font color=\"rgb(255, 0, 0)\">Pirates</font>"
            })[v21]
            u12[v15] = v19
        end
        local function u29(p23) --[[ Line: 79 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u22
                [3] = u12
            --]]
            local v24 = u3:JSONDecode(p23)
            local v25 = {}
            for v26, v27 in pairs(v24) do
                if v26 >= 51 then
                    break
                end
                u22(v26, v27)
                v25[v27.CrewName] = true
            end
            for v28, _ in pairs(u12) do
                if v25[v28] == nil and u12[v28] then
                    u12[v28]:Destroy()
                    u12[v28] = nil
                end
            end
        end
        local u30 = {
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        }
        task.spawn(function() --[[ Line: 112 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u29
                [3] = u30
                [4] = u11
                [5] = u7
                [6] = u9
            --]]
            local u31 = u1:WaitForChild("CrewsInServer", 360)
            local function v33() --[[ Line: 116 ]]
                --[[
                Upvalues:
                    [1] = u31
                    [2] = u29
                --]]
                local v32 = u31:GetAttribute("CurrentTop50")
                if v32 then
                    u29(v32)
                end
            end
            local function v34() --[[ Line: 123 ]]
                --[[
                Upvalues:
                    [1] = u30
                    [2] = u31
                    [3] = u11
                --]]
                u11.Text = "<font color=\"rgb(255,176,0)\">Top Crews</font> (" .. (u30[u31:GetAttribute("Month")] or "Month") .. " " .. (u31:GetAttribute("Year") or "") .. ") (10k+ Infamy)"
            end
            u11.Text = "<font color=\"rgb(255,176,0)\">Top Crews</font> (" .. (u30[u31:GetAttribute("Month")] or "Month") .. " " .. (u31:GetAttribute("Year") or "") .. ") (10k+ Infamy)"
            u31:GetAttributeChangedSignal("Month"):Connect(v34)
            u31:GetAttributeChangedSignal("Year"):Connect(v34)
            local v35 = u31:GetAttribute("CurrentTop50")
            if v35 then
                u29(v35)
            end
            u31:GetAttributeChangedSignal("CurrentTop50"):Connect(v33)
            local v36 = game:GetService("HttpService"):JSONDecode(u31:GetAttribute("Rewards"))
            local v37 = {}
            for v38 = 1, #v36 do
                v37[v36[v38]] = 1
            end
            local u39 = u7.new({
                ["Gui"] = u9.Parent.Parent.Parent,
                ["Trade"] = false
            })
            u39:AddItemsWithDictionary(u9.Rewards.Items, v37, 3)
            u9:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 144 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u39
                --]]
                if u9.Visible == true then
                    u39:StartRotation()
                else
                    u39:StopRotation()
                end
            end)
            if u31:GetAttribute("NextUpdate") then
                local v40 = u9.Refresh
                local v41 = u31:GetAttribute("NextUpdate")
                v40.Text = "\240\159\148\132 " .. math.floor(v41)
            end
            task.spawn(function() --[[ Line: 160 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u31
                --]]
                while true do
                    local v42 = u9.Refresh
                    local v43 = u31:GetAttribute("NextUpdate")
                    v42.Text = "\240\159\148\132 " .. math.floor(v43)
                    task.wait(1)
                end
            end)
        end)
    end
}