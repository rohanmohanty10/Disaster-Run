 

local v1 = {}
game:GetService("TweenService")
local u2 = game:GetService("RunService")
game:GetService("Players")
local _ = _G.customEmit
local v3 = RaycastParams.new()
local v4 = Enum.RaycastFilterType.Include
local v5 = { workspace.Islands, workspace.Ships, workspace.Env }
v3.FilterType = v4
v3.FilterDescendantsInstances = v5
function v1.start(_, _, p6, p7) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v8 = p6.PrimaryPart
    local v9 = CFrame.new(0, 2, -7)
    local v10 = script.Breath:Clone()
    v10.CFrame = v8.CFrame * v9
    v10.PointLight.Brightness = 0
    v10.Parent = workspace.Effects
    _G.tween(v10.PointLight, {
        0.1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        -1,
        true,
        0
    }, {
        ["Range"] = v10.PointLight.Range * 0.95
    })
    _G.tween(v10.PointLight, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Brightness"] = script.Breath.PointLight.Brightness
    })
    local v11 = script.DragonFlameBreathLoop:Clone()
    v11.Parent = v10
    v11:Play()
    repeat
        v10.CFrame = v8.CFrame * v9
        u2.RenderStepped:Wait()
    until p7:IsDescendantOf(game) == false
    _G.tween(v11, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Volume"] = 0
    })
    _G.tween(v10.PointLight, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Brightness"] = 0
    })
    _G.particleEnabled(v10, false)
    _G.destroy(v10, 3)
end
return v1