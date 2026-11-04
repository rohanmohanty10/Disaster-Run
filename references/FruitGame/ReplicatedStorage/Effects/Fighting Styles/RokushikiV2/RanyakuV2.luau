 

local v1 = RaycastParams.new()
v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = workspace.Env:GetDescendants()
local u2 = script
local v3 = {}
game:GetService("RunService")
game:GetService("TweenService")
Random.new()
local u4 = {
    "rbxassetid://16453876882",
    "rbxassetid://16453876675",
    "rbxassetid://16453876519",
    "rbxassetid://16453876381",
    "rbxassetid://16453876272",
    "rbxassetid://16453876130",
    "rbxassetid://16453875982",
    "rbxassetid://16453875673",
    "rbxassetid://16453875525",
    "rbxassetid://16453875296",
    "rbxassetid://16453875121",
    "rbxassetid://16453874844",
    "rbxassetid://16453874585",
    "rbxassetid://16453874349",
    "rbxassetid://16453874156",
    ""
}
function v3.start(_, p5, p6, p7) --[[ Line: 55 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    if p6 == "charged" then
        if p5 == nil then
            return
        elseif _G.checkRenderDistance(p5.PrimaryPart.Position) ~= false then
            local v8 = Instance.new("Highlight")
            v8.FillColor = Color3.fromRGB(85, 170, 255)
            v8.OutlineTransparency = 1
            v8.FillTransparency = 0
            v8.OutlineTransparency = 0.5
            v8.OutlineColor = Color3.fromRGB(255, 255, 255)
            v8.DepthMode = Enum.HighlightDepthMode.Occluded
            v8.Parent = p5
            _G.tween(v8, {
                0.5,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["FillTransparency"] = 1,
                ["OutlineTransparency"] = 1
            })
            _G.destroy(v8, 0.5)
            _G.PlaySound(p5.PrimaryPart, script.RokuTrippleKickTick)
        end
    elseif _G.checkRenderDistance(p5.Position) ~= false then
        local v9 = Instance.new("Folder")
        v9.Name = "EffectsFolder"
        v9.Parent = workspace.Effects
        local u10 = u2.LegSwoop:Clone()
        u10.CFrame = p5 * CFrame.Angles(3.141592653589793, 0, 0)
        u10.Parent = v9
        task.spawn(function() --[[ Line: 91 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u10
            --]]
            for _, v11 in pairs(u4) do
                u10.Decal.Texture = v11
                task.wait(0.015)
            end
        end)
        task.wait(0.05)
        local v12 = CFrame.Angles(1.5707963267948966, 0, -1.5707963267948966)
        local v13, _, _ = _G.getRayFloor(p5, 15)
        local v14 = u2.rank:Clone()
        v14.CFrame = p5 * v12
        if v13 then
            v14.Dust.Color = ColorSequence.new(v13.Color)
        end
        v14.Parent = v9
        local v15 = u2.Kick:Clone()
        v15.CFrame = p5
        v15.Parent = v9
        _G.customEmit(v15)
        local v16 = p6 * CFrame.new(0, 0, v14.Size.X / 2)
        _G.tween(v14, {
            p7,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v16 * v12
        })
        os.clock()
        local v17 = _G.PlaySound(v14, script.RokuRankakyuShoot, {
            ["Pitch"] = math.random(90, 110) / 100
        })
        v17.Parent = v14
        _G.PlayEffect("SurfaceTrail2", nil, {
            ["obj"] = v14,
            ["offset"] = 0
        })
        task.wait(p7)
        _G.tween(v17, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        _G.particleEnabled(v14, false)
        _G.customEmit(v14.explodeLine)
        v14.Transparency = 1
        v14.PointLight.Brightness = 6
        _G.tween(v14.PointLight, {
            0.35,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 45,
            ["Brightness"] = 0
        })
        local v18 = u2.Explode:Clone()
        v18.CFrame = v14.CFrame
        v18.Parent = v9
        _G.customEmit(v18)
        local v19 = (v16 * CFrame.new(0, 0, -3)).Position
        local v20 = v16.LookVector * 15
        local v21, _, _ = _G.getRayFloor(v16, 6)
        if v21 then
            v19 = v16.Position
            v20 = Vector3.new(0, -15, 0)
        end
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 16,
            ["Position"] = v19,
            ["DistanceRandomness"] = Vector2.new(0.5, 1),
            ["Duration"] = 1,
            ["TweenDuration"] = 1,
            ["Radius"] = 14,
            ["Direction"] = v20
        })
        _G.PlayEffect("RockDebris", nil, {
            ["PartCount"] = 8,
            ["RandomVelocityMagnitude"] = Vector2.new(-75, 75),
            ["Position"] = v19,
            ["Direction"] = v16.LookVector * -45 + Vector3.new(0, 25, 0),
            ["RaycastDirection"] = v20,
            ["Size"] = Vector3.new(0.7, 0.7, 0.7),
            ["TrailEnabled"] = true
        }, true)
        _G.destroy(v9, 3)
    end
end
return v3