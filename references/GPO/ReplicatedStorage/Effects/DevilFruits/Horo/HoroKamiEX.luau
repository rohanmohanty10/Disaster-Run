 

local v1 = game:GetService("ReplicatedStorage")
local v2 = {}
local u3 = require(v1.Modules.Part_Icles)
function v2.start(_, p4) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if _G.checkRenderDistance(p4.Position) ~= false then
        local v5 = CFrame.new(p4.Position)
        _G.shakenear(v5.Position, 150, 125, 150, -0.5)
        local v6 = Ray.new(v5.Position, v5.upVector * -15)
        local v7, v8, v9 = _G.raycastWhitelist(v6, { workspace.Islands, workspace.Env, workspace.Ships })
        local v10 = script.explode:Clone()
        v10:SetPrimaryPartCFrame(v5)
        if v7 then
            v10:SetPrimaryPartCFrame(CFrame.new(v8, v8 + v9) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, v10.PrimaryPart.Size.Y / 2, 0))
            v10.PrimaryPart.floorAttachment.WorldCFrame = CFrame.new(v8, v8 + v9) * CFrame.Angles(-1.5707963267948966, 0, 0)
        else
            v10.PrimaryPart.floorAttachment:Destroy()
        end
        v10.Parent = workspace.Effects
        for _, v11 in pairs(v10:GetChildren()) do
            if v11:IsA("BasePart") then
                u3:AbsoluteEmit(v11)
            end
        end
        _G.PlaySound(v10.PrimaryPart, script.boom)
        local v12 = script.Lighting:Clone()
        v12.WorldCFrame = v5
        v12.Parent = workspace.Effects
        _G.tween(v12.PointLight, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 50,
            ["Brightness"] = 0
        })
        _G.destroy(v12, 1)
        _G.destroy(v10, 6)
        local v13 = CFrame.new(v5.Position)
        _G.PlayEffect("Spheres", nil, {
            ["cf"] = v13,
            ["ti"] = 0.2,
            ["ti2"] = 0.25,
            ["range"] = 25,
            ["minThick"] = 1,
            ["maxThick"] = 5,
            ["part"] = nil,
            ["color"] = BrickColor.new("Toothpaste").Color,
            ["am"] = 30
        })
        if v7 then
            local u14 = script.ex:Clone()
            u14.CFrame = CFrame.new(v8, v8 + v9) * CFrame.Angles(-1.5707963267948966, 0, 0)
            u14.Parent = workspace.Effects
            task.delay(4, function() --[[ Line: 55 ]]
                --[[
                Upvalues:
                    [1] = u14
                --]]
                _G.tween(u14.Decal, {
                    1,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.destroy(u14, 1)
            end)
            local v15 = (u14.CFrame + Vector3.new(0, 1, 0)).Position
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 20,
                ["Position"] = v15 + Vector3.new(0, 2, 0),
                ["DistanceRandomness"] = Vector2.new(0.5, 1),
                ["Duration"] = 4,
                ["TweenDuration"] = 1,
                ["Radius"] = 20,
                ["Direction"] = -v9 * 45,
                ["Angle"] = -0.6108652381980153
            })
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 10,
                ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * 2,
                ["Position"] = v15,
                ["Direction"] = Vector3.new(0, 15, 0),
                ["RaycastDirection"] = -v9 * 15,
                ["Size"] = Vector3.new(0.8, 0.8, 0.8),
                ["TrailEnabled"] = true
            })
        end
    end
end
return v2