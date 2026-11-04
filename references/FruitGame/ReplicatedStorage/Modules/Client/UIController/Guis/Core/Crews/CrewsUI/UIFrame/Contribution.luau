 

game:GetService("TweenService")
game:GetService("MarketplaceService")
local u1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("Players")
local _ = u2.LocalPlayer
local v3 = u1.Modules.Shared
require(v3.CrewUtils)
local v4 = {}
local u5 = {}
function GetNameFromUserId(p6)
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
    --]]
    local u7 = p6.UserId
    if u7 == nil then
        return nil
    end
    if typeof(u7) ~= "number" then
        return nil
    end
    local v8 = u5[u7]
    if v8 then
        return v8
    end
    local u9 = nil
    local v10, _ = pcall(function() --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u2
            [3] = u7
        --]]
        u9 = u2:GetNameFromUserIdAsync(u7)
    end)
    if v10 then
        u5[u7] = u9
    end
    return u9
end
function v4.Setup(p11) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local _ = p11.CrewsUI
    local u12 = p11.Frame
    local u13 = u12:WaitForChild("Frame"):WaitForChild("List")
    local u14 = {}
    local function u25(p15, p16) --[[ Line: 46 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u13
        --]]
        local u17 = p16.Key
        local v18 = p16.Value
        local v19 = u14[u17] or script.ContributerTemplate:Clone()
        v19.LayoutOrder = p15
        v19.Parent = u13
        v19.Name = u17
        local u20 = v19.Info
        u20.Rank.Text = "#" .. p15
        u20.Portrait.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(u17)
        u20.Username.Text = "Loading name for UserId:" .. u17
        u20.ContributionAmount.Text = v18 .. " Infamy"
        task.spawn(function() --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u20
                [2] = u17
            --]]
            local v21 = u20.Username
            local v22 = GetNameFromUserId
            local v23 = {}
            local v24 = u17
            v23.UserId = tonumber(v24)
            v21.Text = v22(v23) or "Failed to load name"
        end)
        u14[u17] = v19
    end
    local u26 = ""
    function p11.UpdateList(_, p27) --[[ Line: 76 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u14
            [3] = u26
        --]]
        local v28 = p27.MemberContribution
        local v29 = {}
        for v30, v31 in pairs(v28) do
            table.insert(v29, {
                ["Key"] = v30,
                ["Value"] = v31
            })
        end
        table.sort(v29, function(p32, p33) --[[ Line: 85 ]]
            return p32.Value > p33.Value
        end)
        local v34 = {}
        for v35, v36 in pairs(v29) do
            if v35 >= 51 then
                break
            end
            u25(v35, v36)
            v34[v36.Key] = true
        end
        for v37, _ in pairs(u14) do
            if v34[v37] == nil and u14[v37] then
                u14[v37]:Destroy()
                u14[v37] = nil
            end
        end
        u26 = p27.Name
    end
    task.spawn(function() --[[ Line: 103 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u26
            [3] = u12
        --]]
        local v38 = u1:WaitForChild("CrewsInServer", 360)
        while true do
            local v39 = v38:FindFirstChild(u26 .. "NextUpdate")
            if v39 then
                local v40 = u12.Refresh
                local v41 = 90 - v39:GetAttribute("NextCacheUpdate")
                v40.Text = "\240\159\148\132 " .. math.floor(v41)
            end
            task.wait(1)
        end
    end)
end
return v4