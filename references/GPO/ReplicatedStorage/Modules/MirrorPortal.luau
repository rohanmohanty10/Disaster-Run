 

local u1 = game:GetService("RunService")
local u2 = require(script.ParallaxWindows)
local u3 = {}
u3.__index = u3
function u3.new(p4) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v5 = u3
    local v6 = setmetatable({}, v5)
    v6.Part = p4.Part
    v6.Color = p4.Color
    v6.Icon = p4.Icon
    v6.Window = v6:_createWindow()
    v6:_main()
    return v6
end
function u3._createWindow(p7) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v8 = u2.new()
    local v9 = {
        ["MaxFramerate"] = -1,
        ["ZOffset"] = 0,
        ["AlwaysOnTop"] = false,
        ["Brightness"] = 1,
        ["LightInfluence"] = 0,
        ["MaxDistance"] = 1000,
        ["PixelsPerStud"] = 100,
        ["SizingMode"] = Enum.SurfaceGuiSizingMode.PixelsPerStud
    }
    local v10 = {
        ["UpdateRange"] = 1000,
        ["ZIndex"] = 0,
        ["Image"] = "rbxassetid://73886715549936",
        ["ImageTransparency"] = 0.5,
        ["BackgroundTransparency"] = 1,
        ["ImageColor3"] = Color3.fromRGB(255, 255, 255),
        ["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
        ["ResampleMode"] = Enum.ResamplerMode.Default,
        ["ScaleType"] = Enum.ScaleType.Fit
    }
    local v11 = p7.Part.Size.X * 10
    local v12 = p7.Part.Size.Y * 2
    v10.ImageSize = Vector3.new(v11, v12, 0)
    v10.PosOffset = Vector3.new(0, 0, 0)
    v8:UpdateSettings(v9, v10)
    return v8
end
function u3._main(u13) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    for v14 = 1, 20 do
        local v15 = v14 / 20
        local v16 = u13.Window:AddFrame(u13.Part, Enum.NormalId.Front)
        local v17 = -v14 * 2
        local v18 = {
            ["PosOffset"] = Vector3.new(v17, 0, 0),
            ["ZIndex"] = v14,
            ["ImageTransparency"] = 0,
            ["ImageColor3"] = u13.Color.Keypoints[1].Value:Lerp(u13.Color.Keypoints[2].Value, v15),
            ["Image"] = "rbxassetid://119704968945044"
        }
        u13.Window:UpdateFrameSettings(v16, v18)
    end
    local v19 = u13.Window:AddFrame(u13.Part, Enum.NormalId.Front)
    u13.Window:UpdateFrameSettings(v19, {
        ["PosOffset"] = Vector3.new(-100, 0, 0),
        ["ImageSize"] = Vector3.new(40, 40, 0),
        ["ZIndex"] = 1000,
        ["ImageTransparency"] = 0,
        ["Image"] = u13.Icon
    })
    u13.Heartbeat = u1.RenderStepped:Connect(function() --[[ Line: 93 ]]
        --[[
        Upvalues:
            [1] = u13
        --]]
        u13.Window:Step()
    end)
end
function u3.Destroy(p20) --[[ Line: 98 ]]
    p20.Window:Clear()
    if p20.Heartbeat then
        p20.Heartbeat:Disconnect()
        p20.Heartbeat = nil
    end
    setmetatable(p20, nil)
end
return u3