 

local _ = script
local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local _ = workspace.Effects
game:GetService("Debris")
game:GetService("TweenService")
Random.new()
local v2 = {}
local u3 = require(v1.Modules.SwordHandle.SwordInfo)["Ghost Princess\'s Umbrella"].cooldown
local u4 = require(v1.Modules.VFXUtility.beam_emit)
function v2.start(_, u5, u6) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    local u7 = u6.Parent
    local v8 = u7:FindFirstChild("Ghost Princess\'s UmbrellaSword")
    if v8 then
        local v9 = v8:FindFirstChild("Umbrella_Closed")
        local v10 = v8:FindFirstChild("Umbrella_Open")
        local v11 = tick()
        task.delay(0.1, function() --[[ Line: 33 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u5
                [3] = u6
                [4] = u4
            --]]
            if u7:FindFirstChild("BusoMelee") then
                if u5 == "1" then
                    local v12 = script.M1
                    v12.CFrame = u6.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0)
                    local v13 = u4
                    local v14 = {
                        ["Properties"] = {
                            ["Brightness"] = 36,
                            ["LightEmission"] = 0,
                            ["TextureSpeed"] = 0,
                            ["Width0"] = 50,
                            ["Width1"] = 1
                        },
                        ["RotationSpeed"] = 46,
                        ["Rotation"] = true,
                        ["Offset"] = CFrame.new(0, 0, 0),
                        ["Duration"] = 0.05,
                        ["Easing"] = "Sine",
                        ["EasingDirection"] = "Out"
                    }
                    v13(v12, v14)
                    local v15 = script.HumanoidRootPart.M1:Clone()
                    v15.Parent = u6
                    _G.customEmit(v15)
                    _G.destroy(v15, 5)
                    return
                end
                if u5 == "2" then
                    local v16 = script.M2
                    v16.CFrame = u6.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(-1.5707963267948966, 0.12217304763960307, 0)
                    local v17 = u4
                    local v18 = {
                        ["Properties"] = {
                            ["Brightness"] = 66,
                            ["LightEmission"] = 0,
                            ["TextureSpeed"] = 0,
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        },
                        ["RotationSpeed"] = -800,
                        ["Rotation"] = true,
                        ["Offset"] = CFrame.new(0, 0, 0),
                        ["Duration"] = 0.16,
                        ["Easing"] = "Sine",
                        ["EasingDirection"] = "Out"
                    }
                    v17(v16, v18)
                    local v19 = script.HumanoidRootPart.M2:Clone()
                    v19.Parent = u6
                    _G.customEmit(v19)
                    _G.destroy(v19, 5)
                    return
                end
                if u5 == "3" then
                    local v20 = script.M3
                    v20.CFrame = u6.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(1.4835298641951802, -0.2792526803190927, 3.473205211468716)
                    local v21 = u4
                    local v22 = {
                        ["Properties"] = {
                            ["Brightness"] = 66,
                            ["LightEmission"] = 0,
                            ["TextureSpeed"] = 0,
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        },
                        ["RotationSpeed"] = -1200,
                        ["Rotation"] = true,
                        ["Offset"] = CFrame.new(0, 0, 0),
                        ["Duration"] = 0.1,
                        ["Easing"] = "Sine",
                        ["EasingDirection"] = "Out"
                    }
                    v21(v20, v22)
                    local v23 = script.HumanoidRootPart.M3:Clone()
                    v23.Parent = u6
                    _G.customEmit(v23)
                    _G.destroy(v23, 5)
                    return
                end
                if u5 == "4" then
                    local v24 = script.M1
                    v24.CFrame = u6.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0)
                    local v25 = u4
                    local v26 = {
                        ["Properties"] = {
                            ["Brightness"] = 36,
                            ["LightEmission"] = 0,
                            ["TextureSpeed"] = 0,
                            ["Width0"] = 50,
                            ["Width1"] = 1
                        },
                        ["RotationSpeed"] = 4600,
                        ["Rotation"] = true,
                        ["Offset"] = CFrame.new(0, 0, 0),
                        ["Duration"] = 0.05,
                        ["Easing"] = "Sine",
                        ["EasingDirection"] = "Out"
                    }
                    v25(v24, v26)
                    local v27 = script.HumanoidRootPart.M4:Clone()
                    v27.Parent = u6
                    _G.customEmit(v27)
                    _G.destroy(v27, 5)
                    return
                end
                if u5 == "5" then
                    local v28 = script.M2
                    v28.CFrame = u6.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(-1.5707963267948966, 0.12217304763960307, 0)
                    local v29 = u4
                    local v30 = {
                        ["Properties"] = {
                            ["Brightness"] = 66,
                            ["LightEmission"] = 0,
                            ["TextureSpeed"] = 0,
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        },
                        ["RotationSpeed"] = -800,
                        ["Rotation"] = true,
                        ["Offset"] = CFrame.new(0, 0, 0),
                        ["Duration"] = 0.16,
                        ["Easing"] = "Sine",
                        ["EasingDirection"] = "Out"
                    }
                    v29(v28, v30)
                    local v31 = script.HumanoidRootPart.M5:Clone()
                    v31.Parent = u6
                    _G.customEmit(v31)
                    _G.destroy(v31, 5)
                end
            end
        end)
        repeat
            v9.Transparency = 0
            v10.Transparency = 1
            task.wait()
        until tick() - v11 >= u3 + 0.1
        v9.Transparency = 1
        v10.Transparency = 0
    end
end
return v2