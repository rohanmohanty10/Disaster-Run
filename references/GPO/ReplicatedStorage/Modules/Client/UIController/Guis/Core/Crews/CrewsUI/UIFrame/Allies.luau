 

game:GetService("TweenService")
game:GetService("MarketplaceService")
local v1 = game:GetService("ReplicatedStorage")
local _ = game:GetService("Players").LocalPlayer
local v2 = v1.Modules.Shared
require(v2.CrewUtils)
return {
    ["Setup"] = function(p3, u4) --[[ Name: Setup, Line 14 ]]
        local u5 = p3.CrewsUI
        local v6 = p3.Frame:WaitForChild("Inner")
        local v7 = v6:WaitForChild("Categories")
        local v8 = v7:WaitForChild("SendRequests")
        local u9 = v8:WaitForChild("Input"):WaitForChild("TextBox")
        local v10 = v8:WaitForChild("Send")
        local u11 = v7:WaitForChild("Requests")
        local u12 = v7:WaitForChild("Allies")
        local v13 = v6:WaitForChild("CategoryButtons")
        local u14 = v13:WaitForChild("Allies")
        local u15 = v13:WaitForChild("Requests")
        local u16 = v13:WaitForChild("SendRequests")
        local u17 = false
        v10.MouseButton1Click:Connect(function() --[[ Line: 37 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u17
                [3] = u5
                [4] = u9
            --]]
            u4.UIUtils.ButtonEffect()
            if u17 == true then
                u5.Notify("Information", "Game is still processing previous action")
            else
                u17 = true
                local v18 = u5.Notify("Information", "Attempting to send Invite to")
                local v19, v20 = u5.UIClient:GetRemote():InvokeServer({
                    ["Method"] = "SendAllyRequest",
                    ["AllyCrewName"] = u9.Text
                })
                u5.RemoveNotification(v18, true)
                u5.Notify(v20 == nil and "Error" or "Success", v19)
                u17 = false
            end
        end)
        local u21 = {}
        local u22 = nil
        for _, v23 in ipairs(v7:GetChildren()) do
            u21[v23.Name] = v23
            v23.Visible = false
        end
        u14.MouseButton1Click:Connect(function() --[[ Name: OnButtonPressed, Line 82 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u14
                [3] = u22
                [4] = u21
            --]]
            u4.UIUtils.ButtonEffect()
            local v24 = u14
            if u22 then
                u22.Visible = false
                u22 = nil
            end
            u21[v24.Name].Visible = true
            u22 = u21[v24.Name]
        end)
        if u14 == u14 then
            if u22 then
                u22.Visible = false
                u22 = nil
            end
            u21[u14.Name].Visible = true
            u22 = u21[u14.Name]
        end
        local function v26() --[[ Line: 82 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u15
                [3] = u22
                [4] = u21
            --]]
            u4.UIUtils.ButtonEffect()
            local v25 = u15
            if u22 then
                u22.Visible = false
                u22 = nil
            end
            u21[v25.Name].Visible = true
            u22 = u21[v25.Name]
        end
        u15.MouseButton1Click:Connect(v26)
        if u15 == u14 then
            if u22 then
                u22.Visible = false
                u22 = nil
            end
            u21[u15.Name].Visible = true
            u22 = u21[u15.Name]
        end
        local function v28() --[[ Line: 82 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u16
                [3] = u22
                [4] = u21
            --]]
            u4.UIUtils.ButtonEffect()
            local v27 = u16
            if u22 then
                u22.Visible = false
                u22 = nil
            end
            u21[v27.Name].Visible = true
            u22 = u21[v27.Name]
        end
        u16.MouseButton1Click:Connect(v28)
        if u16 == u14 then
            if u22 then
                u22.Visible = false
                u22 = nil
            end
            u21[u16.Name].Visible = true
            u22 = u21[u16.Name]
        end
        local u29 = {}
        function p3.RefreshAllyList(_, p30) --[[ Line: 98 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u29
                [3] = u5
            --]]
            local v31 = p30.Allies
            for u32, _ in pairs(v31) do
                if not u12:FindFirstChild(u32) then
                    local u33 = script.AllyTemplate:Clone()
                    u33.Name = u32
                    u33.Parent = u12
                    u29[u32] = u33
                    local u34 = u33.Info
                    u34.CrewName.Text = u32
                    local u35 = false
                    local u36 = false
                    u34.Revoke.MouseButton1Click:Connect(function() --[[ Line: 114 ]]
                        --[[
                        Upvalues:
                            [1] = u36
                            [2] = u35
                            [3] = u34
                            [4] = u33
                            [5] = u5
                            [6] = u32
                        --]]
                        if u36 == true then
                            return
                        elseif u35 == false then
                            u35 = true
                            u34.Revoke.Text = "Press again to confirm remove"
                            task.delay(2.5, function() --[[ Line: 120 ]]
                                --[[
                                Upvalues:
                                    [1] = u33
                                    [2] = u34
                                    [3] = u35
                                --]]
                                if u33.Parent ~= nil then
                                    u34.Revoke.Text = "Remove"
                                    u35 = false
                                end
                            end)
                        elseif u35 == true then
                            u36 = true
                            local v37 = u5.Notify("Information", "Removing ally...")
                            local v38 = {
                                ["Method"] = "RemoveAlly",
                                ["AllyCrewName"] = u32
                            }
                            local v39, v40 = u5.UIClient:GetRemote():InvokeServer(v38)
                            u36 = false
                            u5.RemoveNotification(v37, true)
                            u5.Notify(v40 == nil and "Error" or "Success", v39)
                        end
                    end)
                end
            end
            for v41, v42 in pairs(u29) do
                if v31[v41] == nil then
                    v42:Destroy()
                    u29[v41] = nil
                end
            end
        end
        function p3.ReceiveAllyRequest(_, p43) --[[ Line: 153 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u5
            --]]
            local u44 = p43.AllyCrewName
            local v45 = p43.AllyCrewImage
            if not u11:FindFirstChild(u44) then
                local u46 = script.AllyRequestTemplate:Clone()
                u46.Name = u44
                u46.Parent = u11
                local v47 = u46.Main
                v47.CrewName.Text = u44
                local v48 = v47.Logo
                if v45 then
                    v45 = "https://www.roblox.com/asset-thumbnail/image?assetId=" .. v45 .. "&width=420&height=420&format=png"
                end
                v48.Image = v45
                local u49 = false
                v47.Accept.MouseButton1Click:Connect(function() --[[ Line: 170 ]]
                    --[[
                    Upvalues:
                        [1] = u49
                        [2] = u5
                        [3] = u44
                        [4] = u46
                    --]]
                    if u49 ~= true then
                        u49 = true
                        local v50 = u5.Notify("Information", "Declining ally request")
                        local v51 = {
                            ["Method"] = "AcceptAllyRequest",
                            ["AllyCrewName"] = u44
                        }
                        local v52, v53 = u5.UIClient:GetRemote():InvokeServer(v51)
                        u49 = false
                        u5.RemoveNotification(v50, true)
                        u5.Notify(v53 == nil and "Error" or "Success", v52)
                        if v53 then
                            u46:Destroy()
                        end
                    end
                end)
                v47.Ignore.MouseButton1Click:Connect(function() --[[ Line: 191 ]]
                    --[[
                    Upvalues:
                        [1] = u49
                        [2] = u5
                        [3] = u44
                        [4] = u46
                    --]]
                    if u49 ~= true then
                        u49 = true
                        local v54 = u5.Notify("Information", "Declining ally request")
                        local v55 = {
                            ["Method"] = "DeclineAllyRequest",
                            ["AllyCrewName"] = u44
                        }
                        local v56, v57 = u5.UIClient:GetRemote():InvokeServer(v55)
                        u49 = false
                        u5.RemoveNotification(v54, true)
                        u5.Notify(v57 == nil and "Error" or "Success", v56)
                        if v57 then
                            u46:Destroy()
                        end
                    end
                end)
            end
        end
    end
}