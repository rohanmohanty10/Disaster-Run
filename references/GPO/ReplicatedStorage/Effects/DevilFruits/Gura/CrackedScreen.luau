 

local v1 = {}
local u2 = {}
local function u5(p3) --[[ Line: 5 ]]
    local v4 = p3.Transparency
    p3.Transparency = 1
    local _ = p3.Size
    _G.tween(p3, {
        0.25,
        Enum.EasingStyle.Cubic,
        Enum.EasingDirection.Out,
        0,
        true,
        0
    }, {
        ["Transparency"] = v4
    })
end
function v1.start(_, _, _, _) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
    --]]
    local v6 = script.Model:Clone()
    v6.Parent = workspace.CurrentCamera
    local v7 = math.random(-360, 360)
    v6:PivotTo(workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -3))
    u2[v6] = v7
    local u8 = script.ColorCorrection:Clone()
    u8.TintColor = Color3.fromRGB(255, 255, 255)
    u8.Parent = workspace.CurrentCamera
    _G.destroy(u8, 1.15)
    _G.tween(u8, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["TintColor"] = Color3.fromRGB(255, 0, 0)
    })
    u5(v6.glass)
    u5(v6.neon)
    task.spawn(function() --[[ Line: 29 ]]
        task.wait(0.1)
        script["Audio/GuraScreenCrack"]:Play()
    end)
    _G.destroy(v6, 1)
    task.spawn(function() --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        task.wait(0.5)
        _G.tween(u8, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TintColor"] = Color3.fromRGB(255, 255, 255)
        })
    end)
    task.wait(1)
    u2[v6] = nil
end
game["Run Service"].RenderStepped:Connect(function() --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for u9, u10 in u2 do
        if u9 then
            pcall(function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u10
                --]]
                local v11 = u10
                u9:PivotTo(workspace.CurrentCamera.CFrame * CFrame.new(-3, 0, -2) * CFrame.Angles(0, 0, (math.rad(v11))))
            end)
        end
    end
end)
return v1