 

local v1 = {}
local u2 = 0
local u3 = script.test:Clone()
local u4 = CFrame.new(0, 0, -0.5)
local u5 = nil
local function u9(u6) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u7 = u3:GetDescendants()
    for u8 = 1, #u7 do
        pcall(function() --[[ Line: 9 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u8
                [3] = u6
            --]]
            u7[u8].Enabled = u6
        end)
    end
end
function v1.start(_, p10) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u9
        [3] = u2
    --]]
    if u5 == nil then
        u5 = script.depressedColor:Clone()
        u5.Parent = workspace.CurrentCamera
        u5.Brightness = 0
        u5.Saturation = 0
        u5.TintColor = Color3.fromRGB(255, 255, 255)
        _G.tween(u5, {
            0.25,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Brightness"] = script.depressedColor.Brightness,
            ["TintColor"] = script.depressedColor.TintColor,
            ["Saturation"] = script.depressedColor.Saturation
        })
    end
    u9(true)
    if u2 < p10 then
        u2 = p10
    end
end
local u11 = tick()
local u12 = 0
game["Run Service"].RenderStepped:Connect(function() --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u11
        [4] = u9
        [5] = u12
        [6] = u5
        [7] = u4
    --]]
    if u2 > 0 then
        if pcall(function() --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            u3.Parent = workspace.CurrentCamera
        end) == false then
            u3 = script.test:Clone()
        end
        u2 = u2 - (tick() - u11)
    else
        u2 = 0
        if u3 and u3.Lines.Enabled == true then
            u9(false)
            u12 = tick()
        end
        if u5 and u5.Name ~= "done" then
            u5.Name = "done"
            _G.tween(u5, {
                0.25,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Brightness"] = 0,
                ["TintColor"] = Color3.fromRGB(255, 255, 255),
                ["Saturation"] = 0
            })
            _G.destroy(u5, 0.25)
            u5 = nil
        end
        if tick() - u12 > 4 then
            u3.Parent = nil
        end
    end
    u3.CFrame = workspace.CurrentCamera.CFrame * u4
    u11 = tick()
end)
return v1