 

local v1 = {}
local u2 = {
    ["SeasonsOrg"] = {
        ["Center"] = Vector2.new(-4393.885, -7016.61),
        ["ImageID"] = "rbxassetid://13787016890",
        ["Resolution"] = { 11001, 11001 }
    },
    ["SeasonsHollow"] = {
        ["Center"] = Vector2.new(-4393.885, -7016.61),
        ["ImageID"] = "rbxassetid://13787016890",
        ["Resolution"] = { 11001, 11001 }
    },
    ["SeasonsWinter2023"] = {
        ["Center"] = Vector2.new(-4073.159, -6883.714),
        ["ImageID"] = "rbxassetid://112804128877322",
        ["Resolution"] = { 11000, 11000 }
    },
    ["Winter Wonderland"] = {
        ["Center"] = Vector2.new(753.633, 5392.918),
        ["ImageID"] = "rbxassetid://11903004814",
        ["Resolution"] = { 11001, 11001 }
    },
    ["Grassy Planes"] = {
        ["Center"] = Vector2.new(-4440.4345703125, -7302.380859375),
        ["ImageID"] = "rbxassetid://11230987489",
        ["Resolution"] = { 11001, 11001 }
    },
    ["Four Seasons"] = {
        ["Center"] = Vector2.new(-4031.985, -6658.461),
        ["ImageID"] = "rbxassetid://18446323822",
        ["Resolution"] = { 12856.2, 12856.2 }
    },
    ["Four SeasonsHallow"] = {
        ["Center"] = Vector2.new(-4031.985, -6658.461),
        ["ImageID"] = "rbxassetid://18446323822",
        ["Resolution"] = { 12856.2, 12856.2 }
    },
    ["Icy Bastion"] = {
        ["Center"] = Vector2.new(-3942.18, -6986.803),
        ["ImageID"] = "rbxassetid://137321229185572",
        ["Resolution"] = { 10362.968, 10362.968 },
        ["HasTrain"] = true
    },
    ["Four SeasonsWinter"] = {
        ["Center"] = Vector2.new(-4031.985, -6658.461),
        ["ImageID"] = "rbxassetid://92103528259255",
        ["Resolution"] = { 12856.2, 12856.2 },
        ["HasTrain"] = true
    },
    ["Spring2025Map"] = {
        ["Center"] = Vector2.new(-4031.985, -6658.46),
        ["ImageID"] = "rbxassetid://115023830732486",
        ["Resolution"] = { 13070.802, 13070.802 },
        ["HasTrain"] = true
    },
    ["Founding Archipelago"] = {
        ["Center"] = Vector2.new(-4031.985, -6658.46),
        ["ImageID"] = "rbxassetid://112457455677193",
        ["Resolution"] = { 12856.2, 12856.2 }
    },
    ["FirstSeaBRMap"] = {
        ["Center"] = Vector2.new(-3734.453, -7205.174),
        ["ImageID"] = "rbxassetid://103940818429433",
        ["Resolution"] = { 14000, 14000 }
    },
    ["DBZMap"] = {
        ["Center"] = Vector2.new(-4142.077, -6903.197),
        ["ImageID"] = "rbxassetid://132731077216738",
        ["Resolution"] = { 11000, 11000 }
    },
    ["Cupid\'s Land"] = {
        ["Center"] = Vector2.new(-4224.929, -7066.839),
        ["ImageID"] = "rbxassetid://102980633849284",
        ["Resolution"] = { 10000, 10000 }
    }
}
function v1.Display(_, p3) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[p3] then
        local v4 = u2[p3]
        local v5 = script.Minimap
        v5.GuiElements.Map.Image = v4.ImageID
        v5.LocalScript:SetAttribute("Center", v4.Center)
        v5.LocalScript:SetAttribute("Resolution", game:GetService("HttpService"):JSONEncode(v4.Resolution))
        v5.LocalScript:SetAttribute("MapName", p3)
        v5:SetAttribute("Resolution", game:GetService("HttpService"):JSONEncode(v4.Resolution))
        _G.stormResolution = v4.Resolution
        v5.LocalScript.Disabled = false
        if v4.HasTrain == true then
            task.spawn(function() --[[ Line: 100 ]]
                local u6 = Ray.new
                local v7 = game:GetService("RunService")
                local u8 = game:GetService("Players").LocalPlayer
                local _ = u8.Character
                local u9 = nil
                local u10 = nil
                v7.Heartbeat:Connect(function(_, _) --[[ Line: 109 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                        [2] = u6
                        [3] = u10
                        [4] = u9
                    --]]
                    local v11 = u8.Character
                    if v11 ~= nil then
                        local v12 = v11.PrimaryPart
                        if v12 then
                            local v13 = u6(v12.CFrame.p, Vector3.new(0, -25, 0))
                            local v14 = workspace:FindPartOnRayWithWhitelist(v13, { workspace.Ships })
                            if v14 then
                                if not u10 then
                                    u10 = v14
                                end
                                if v14 == u10 then
                                    if not u9 then
                                        u9 = v14.CFrame
                                    end
                                else
                                    u9 = v14.CFrame
                                end
                                local v15 = v14.CFrame * u9:inverse()
                                u9 = v14.CFrame
                                if v11.Humanoid.Sit == false then
                                    v14.AssemblyLinearVelocity = Vector3.new()
                                    v14.AssemblyAngularVelocity = Vector3.new()
                                    v12.CFrame = v15 * v12.CFrame
                                end
                                u10 = v14
                                return
                            end
                            u9 = nil
                        end
                    end
                end)
            end)
        end
    else
        warn("cant find map ", p3)
    end
end
v1.MapData = u2
return v1