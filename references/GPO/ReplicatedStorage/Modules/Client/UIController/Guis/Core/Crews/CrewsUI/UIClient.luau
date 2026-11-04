 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("Players")
local v3 = v1:WaitForChild("Modules"):WaitForChild("Shared")
local u4 = require(v3:WaitForChild("CrewUtils"))
local u5 = u2.LocalPlayer
local u6 = v1:WaitForChild("CrewRemote", 300)
local u7 = {
    ["Captain"] = "<font color=\"#bdbebe\">By</font> <b>%s</b>",
    ["Member"] = "<b>%s</b> <font color=\"#bdbebe\">Members</font>",
    ["Rank"] = "<b>%s</b> <font color=\"#bdbebe\">Rank</font>",
    ["TotalInfamy"] = "<font color=\"rgb(255,176,0)\">%s Infamy</font>",
    ["CrewName"] = "<b>%s</b>",
    ["ConquestPoints"] = "%s <b><font color=\"rgb(209, 255, 6)\">Conquest Points</font></b>",
    ["Infamy"] = "%s <b><font color=\"rgb(255,176,0)\">Infamy</font></b> ",
    ["Marine"] = "Faction <b><font color=\"rgb(51, 184, 255)\">Marine</font></b> ",
    ["Pirate"] = "Faction <b><font color=\"rgb(255, 0, 0)\">Pirate</font></b>"
}
local u8 = {}
local u68 = {
    ["LastestData"] = nil,
    ["GetRemote"] = function(_) --[[ Name: GetRemote, Line 53 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        return u6
    end,
    ["GetLastestData"] = function(_) --[[ Name: GetLastestData, Line 57 ]]
        --[[
        Upvalues:
            [1] = u68
        --]]
        return u68.LastestData
    end,
    ["Initialize"] = function(_, u9) --[[ Name: Initialize, Line 61 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u68
            [3] = u7
            [4] = u8
            [5] = u4
            [6] = u5
            [7] = u6
        --]]
        local u64 = {
            ["ReceiveAllyRequest"] = function(p10) --[[ Name: ReceiveAllyRequest, Line 65 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                u9.Frames.Allies:ReceiveAllyRequest(p10)
            end,
            ["AddMember"] = function(p11) --[[ Name: AddMember, Line 71 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                local v12 = p11.Member
                u9.Frames.Default:AddMember(v12)
            end,
            ["RemoveMember"] = function(p13) --[[ Name: RemoveMember, Line 80 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                local v14 = p13.Member
                u9.Frames.Default:RemoveMember(v14)
            end,
            ["RemoveAllMember"] = function() --[[ Name: RemoveAllMember, Line 89 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                u9.Frames.Default:RemoveAllMembers()
            end,
            ["UpdateMembersList"] = function(p15) --[[ Name: UpdateMembersList, Line 95 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u2
                --]]
                local v16 = p15.Members
                local v17 = u9.Frames.Default
                for v18, v19 in pairs(v16) do
                    local v20 = u2:FindFirstChild(v18)
                    if v20 then
                        v17:AddMember(v20, v19)
                    end
                end
            end,
            ["UpdateClientCachedData"] = function(p21) --[[ Name: UpdateClientCachedData, Line 108 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                local v22 = p21.CachedData
                u9.Frames.Default:UpdateCachedData(v22)
            end,
            ["UpdateLogoImage"] = function(p23) --[[ Name: UpdateLogoImage, Line 115 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u68
                --]]
                local v24 = p23.CrewData
                local v25 = v24.CrewImage
                local v26 = u9.Frames.Default
                u68.LastestData = v24
                v26:UpdateLogoImage(v25 and ("https://www.roblox.com/asset-thumbnail/image?assetId=" .. v25 .. "&width=420&height=420&format=png" or "") or "")
                v26:UpdateViewInfo("Logo", "Image", v25 and "https://www.roblox.com/asset-thumbnail/image?assetId=" .. v25 .. "&width=420&height=420&format=png" or "")
            end,
            ["UpdateViewInfo"] = function(p27) --[[ Name: UpdateViewInfo, Line 138 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u7
                --]]
                local v28 = p27.UIObject
                local v29 = p27.Property
                local v30 = p27.Format
                local v31 = p27.NewValue
                u9.Frames.Default:UpdateViewInfo(v28, v29, u7[v30]:format(v31))
            end,
            ["UpdateConfigureInfo"] = function(p32) --[[ Name: UpdateConfigureInfo, Line 154 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u7
                --]]
                local v33 = p32.UIObject
                local v34 = p32.Property
                local v35 = p32.Format
                local v36 = p32.NewValue
                u9.Frames.Default:UpdateConfigureInfo(v33, v34, u7[v35]:format(v36))
            end,
            ["UpdateAllFrames"] = function(p37) --[[ Name: UpdateAllFrames, Line 170 ]]
                --[[
                Upvalues:
                    [1] = u68
                    [2] = u9
                    [3] = u7
                    [4] = u8
                    [5] = u2
                    [6] = u4
                    [7] = u5
                    [8] = u64
                --]]
                local v38 = p37.CrewName
                local v39 = p37.CrewData
                local v40 = v39.IsMarineFaction
                local _ = v39.CrewImage
                u68.LastestData = v39
                local v41 = u9.Frames.Default
                v41:UpdateViewInfo("CrewName", "Text", u7.CrewName:format(v38))
                local v42 = "Captain"
                local v43 = "Text"
                local v44 = u7.Captain
                local u45 = v39.OwnerId
                local v46 = u8[u45]
                if not v46 then
                    local u47 = ""
                    local v48, _ = pcall(function() --[[ Line: 36 ]]
                        --[[
                        Upvalues:
                            [1] = u47
                            [2] = u2
                            [3] = u45
                        --]]
                        u47 = u2:GetNameFromUserIdAsync(u45)
                    end)
                    if v48 then
                        u8[u45] = u47
                    else
                        u47 = "Failed to load!"
                    end
                    v46 = u47
                end
                v41:UpdateViewInfo(v42, v43, v44:format(v46))
                v41:UpdateViewInfo("Faction", "Text", v40 and u7.Marine or u7.Pirate)
                v41:UpdateViewInfo("Member", "Text", u7.Member:format(v39.MembersCount .. "/" .. v39.MaxMembers))
                local v49 = u4.GetRankInCrew(u5, v39)
                v41:UpdateViewInfo("Rank", "Text", u7.Rank:format(v49 or "Failed to get rank"))
                v41:UpdateViewInfo("ConquestPoints", "Text", u7.ConquestPoints:format(v39.ConquestPoints))
                v41:UpdateViewInfo("Infamy", "Text", u7.Infamy:format(v39.Infamy))
                local v50 = "ConfigCaptain"
                local v51 = "Text"
                local v52 = u7.Captain
                local u53 = v39.OwnerId
                local v54 = u8[u53]
                if not v54 then
                    local u55 = ""
                    local v56, _ = pcall(function() --[[ Line: 36 ]]
                        --[[
                        Upvalues:
                            [1] = u55
                            [2] = u2
                            [3] = u53
                        --]]
                        u55 = u2:GetNameFromUserIdAsync(u53)
                    end)
                    if v56 then
                        u8[u53] = u55
                    else
                        u55 = "Failed to load!"
                    end
                    v54 = u55
                end
                v41:UpdateConfigureInfo(v50, v51, v52:format(v54))
                v41:UpdateConfigureInfo("Title", "Text", "Configure " .. v38)
                v41:UpdateLeaveFrameText(v39.OwnerId == u5.UserId)
                u64.UpdateLogoImage(p37)
                u9.Frames.Contribution:UpdateList(v39)
                u9.Frames.Shop:UpdateShop(v39)
                u9.Frames.Allies:RefreshAllyList(v39)
            end,
            ["UpdateCrewShop"] = function(p57) --[[ Name: UpdateCrewShop, Line 270 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                local v58 = p57.CrewData
                u9.Frames.Shop:UpdateShop(v58)
            end,
            ["UpdateConfigureMembersPage"] = function(p59) --[[ Name: UpdateConfigureMembersPage, Line 275 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                u9.Frames.Default:AddMembersToConfigure(p59.CrewMembers)
            end,
            ["UpdatePermissionsPage"] = function(p60) --[[ Name: UpdatePermissionsPage, Line 280 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                local v61 = p60.CrewData
                local v62 = u9.Frames.Default
                v62:CreateRankButtons(v61)
                v62:CreateAvailableRanks(v61)
            end,
            ["ReceiveInvite"] = function(p63) --[[ Name: ReceiveInvite, Line 292 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                u9.Frames.Invites:ReceiveInvite(p63)
            end
        }
        function u6.OnClientInvoke(p65) --[[ Line: 302 ]]
            --[[
            Upvalues:
                [1] = u64
            --]]
            local v66 = p65.Method
            if v66 == nil then
                warn("Missing Method Argument!")
                return
            else
                local v67 = u64[v66]
                if v67 then
                    v67(p65)
                else
                    warn("Missing Method!")
                end
            end
        end
        return u68
    end
}
return u68