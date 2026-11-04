 

game:GetService("TweenService")
game:GetService("MarketplaceService")
local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("Players")
local u3 = u2.LocalPlayer
local v4 = v1.Modules.Shared
require(v4.CrewUtils)
return {
    ["Setup"] = function(u5, u6) --[[ Name: Setup, Line 14 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        local u7 = u5.CrewsUI
        local v8 = u5.Frame
        local v9 = v8:WaitForChild("Invite")
        local u10 = v9:WaitForChild("Input"):WaitForChild("TextBox")
        local v11 = v9:WaitForChild("Invite")
        local u12 = v9:WaitForChild("Find")
        local u13 = ""
        local u14 = nil
        local function u19(p15) --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
            --]]
            local v16 = u2:FindFirstChild(p15)
            if v16 then
                return v16.Name
            end
            local v17 = p15:len()
            for _, v18 in ipairs(u2:GetPlayers()) do
                if v18 ~= u3 and v18.Name:lower():sub(1, v17) == p15:lower() then
                    return v18.Name
                end
            end
            return nil
        end
        u10:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 46 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u13
                [3] = u14
                [4] = u19
                [5] = u12
            --]]
            local v20 = u10.Text
            if v20 == "" or v20 == u13 then
                return
            else
                u14 = nil
                local v21 = u19(v20)
                if v21 == nil then
                    u12.Text = ""
                else
                    u14 = v21
                    u12.Text = "Found: " .. v21
                    u10.Text = v21:sub(1, v20:len())
                    u13 = v21
                end
            end
        end)
        u10.FocusLost:Connect(function(p22) --[[ Line: 67 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u10
            --]]
            if u14 then
                u10.Text = u14
            end
            if p22 ~= false then
            end
        end)
        local u23 = {}
        function u5.RemoveInvite(_, p24) --[[ Line: 79 ]]
            --[[
            Upvalues:
                [1] = u23
            --]]
            if u23[p24] ~= nil then
                u23[p24] = true
            end
        end
        v11.MouseButton1Click:Connect(function() --[[ Line: 85 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u14
                [3] = u2
                [4] = u7
                [5] = u23
            --]]
            u6.UIUtils.ButtonEffect()
            if u14 == nil then
                return
            else
                local u25 = u2:FindFirstChild(u14)
                if u25 == nil then
                    u7.Notify("Information", "Could not find player!")
                else
                    task.spawn(function() --[[ Line: 104 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                            [2] = u25
                            [3] = u7
                        --]]
                        u23[u25] = true
                        local v26 = u7.Notify("Information", "Sending Invite to" .. u25.Name)
                        local v27 = {
                            ["Method"] = "Invite",
                            ["InvitedPlayer"] = u25
                        }
                        local v28, v29 = u7.UIClient:GetRemote():InvokeServer(v27)
                        u7.RemoveNotification(v26, true)
                        u7.Notify(v29 == nil and "Error" or "Success", v28)
                    end)
                end
            end
        end)
        local u30 = v8:WaitForChild("Invited"):WaitForChild("Invites")
        local u31 = {}
        local u32 = false
        function u5.ReceiveInvite(_, p33) --[[ Line: 130 ]]
            --[[
            Upvalues:
                [1] = u31
                [2] = u30
                [3] = u6
                [4] = u32
                [5] = u7
            --]]
            local v34 = p33.InvitationData
            if v34 == nil then
                return
            else
                local u35 = v34.CrewName
                local v36 = v34.CrewImage
                local _ = v34.Inviter
                if u31[u35] == nil then
                    local u37 = script.InviteTemplate:Clone()
                    u37.Name = u35
                    u37.Parent = u30
                    local v38 = u37.Invitation
                    v38.CrewName.Text = u35
                    local v39 = v38.Logo
                    if v36 then
                        v36 = "https://www.roblox.com/asset-thumbnail/image?assetId=" .. v36 .. "&width=420&height=420&format=png"
                    end
                    v39.Image = v36
                    v38.Accept.MouseButton1Click:Connect(function() --[[ Line: 149 ]]
                        --[[
                        Upvalues:
                            [1] = u6
                            [2] = u32
                            [3] = u7
                            [4] = u35
                            [5] = u31
                            [6] = u37
                        --]]
                        u6.UIUtils.ButtonEffect()
                        if u32 == true then
                            u7.Notify("Information", "Game is still processing previous action")
                        else
                            u32 = true
                            local v40 = u7.Notify("Information", "Joining " .. u35)
                            local v41 = {
                                ["Method"] = "AcceptInvite",
                                ["CrewName"] = u35
                            }
                            local v42, v43 = u7.UIClient:GetRemote():InvokeServer(v41)
                            u7.RemoveNotification(v40, true)
                            u7.Notify(v43 == nil and "Error" or "Success", v42)
                            if v43 and v43 == true then
                                u31[u35] = nil
                                u37:Destroy()
                            end
                            u32 = false
                        end
                    end)
                    v38.Ignore.MouseButton1Click:Connect(function() --[[ Line: 177 ]]
                        --[[
                        Upvalues:
                            [1] = u6
                            [2] = u32
                            [3] = u7
                            [4] = u35
                            [5] = u31
                            [6] = u37
                        --]]
                        u6.UIUtils.ButtonEffect()
                        if u32 ~= true then
                            local v44 = {
                                ["Method"] = "DeclineInvite",
                                ["CrewName"] = u35
                            }
                            local _, v45 = u7.UIClient:GetRemote():InvokeServer(v44)
                            if v45 and v45 == true then
                                u31[u35] = nil
                                u37:Destroy()
                            end
                        end
                    end)
                    u31[u35] = u37
                end
            end
        end
        u2.PlayerRemoving:Connect(function(p46) --[[ Line: 196 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5:RemoveInvite(p46)
        end)
    end
}