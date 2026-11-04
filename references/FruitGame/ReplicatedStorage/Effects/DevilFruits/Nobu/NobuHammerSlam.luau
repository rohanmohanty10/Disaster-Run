 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, u2, p3, p4) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p3.root.Position) then
        local v5 = { 0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In }
        local v6 = _G.tween(p3.root, v5, {
            ["CFrame"] = p3.root.CFrame * CFrame.Angles(-2, 0, 0)
        })
        delay(0.19, function() --[[ Line: 13 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            local v7 = script.Swoosh:Clone()
            v7.CFrame = u2.HumanoidRootPart.CFrame * CFrame.new(-0, -0, -0, 0.241841719, 0.76232338, -0.600307047, 0.241840586, -0.646506071, -0.723563313, -0.939695358, 0.0298091099, -0.34071371)
            v7.Parent = workspace.Effects
            _G.tween(v7, { 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut }, {
                ["CFrame"] = v7.CFrame * CFrame.Angles(0, -3.13, 0)
            })
            _G.tween(v7.Decal, { 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In }, {
                ["Transparency"] = 1
            })
            _G.tween(v7.Mesh, { 0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out }, {
                ["Scale"] = Vector3.new(19, 80, 19)
            })
            _G.destroy(v7, 0.23)
        end)
        v6.Completed:Wait()
        local v8 = u2.HumanoidRootPart.CFrame * CFrame.new(0, 0, -15)
        p3.root.CFrame = v8 * CFrame.new(2.02551079, 5.70490837, 13.3814182, 0.965448678, -0.107088476, 0.237497017, -0.260509074, -0.388105035, 0.88402921, -0.0024955275, -0.915372431, -0.402600706)
        _G.PlaySound(p3.root, script.Slam)
        local v9 = script.NSlam:Clone()
        v9:PivotTo(v8)
        v9.Parent = workspace.Effects
        _G.tween(v9.SwirlA, {
            1.5,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v9.SwirlA.CFrame * CFrame.Angles(0, 0, 2.13),
            ["Size"] = Vector3.new(50, 50, 4),
            ["Transparency"] = 1
        })
        _G.tween(v9.SwirlB, {
            1.2,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v9.SwirlB.CFrame * CFrame.Angles(0, 0, -3.13),
            ["Size"] = Vector3.new(55, 55, 5),
            ["Transparency"] = 1
        })
        _G.tween(v9.Spike, {
            0.2,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v9.Spike.CFrame * CFrame.Angles(0, 3.13, 0),
            ["Size"] = Vector3.new(8, 64, 8),
            ["Transparency"] = 1
        })
        if p4 then
            v9.root.Attachment.Core:Emit(1)
            _G.customEmit(v9.root.Attachment.FillStar)
            _G.customEmit(v9.root.Attachment.HollowStar)
            _G.PlaySound(p3.root, script.SoundDoll, {
                ["PlaybackSpeed"] = Random.new():NextNumber(1, 1.15)
            })
        else
            _G.PlaySound(p3.root, script.SoundNoob, {
                ["PlaybackSpeed"] = Random.new():NextNumber(0.9, 1)
            })
        end
        _G.customEmit(v9.root.Attachment.Smoke)
        _G.PlayEffect("GroundRocks2", nil, v8, 15, 10, 5, 0, 5)
        _G.PlayEffect("GroundRocks2", nil, v8, 15, 20, 2, 0, 5)
        _G.PlayEffect("Spheres", nil, {
            ["xrange"] = 6.25,
            ["yrange"] = 25,
            ["zrange"] = 6.25,
            ["cf"] = v8,
            ["ti"] = 0.2,
            ["ti2"] = 0.25,
            ["range"] = 30,
            ["minThick"] = 5,
            ["maxThick"] = 15,
            ["part"] = nil,
            ["color"] = Color3.fromRGB(255, 255, 255),
            ["am"] = 15
        })
        _G.shakenear(v8.Position, 75, 75, 100, -0.5)
        _G.destroy(p3, 3)
        _G.destroy(v9, 1)
    end
end
return v1