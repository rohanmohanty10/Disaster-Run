 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1) ~= false then
            _G.PlayEffect("DeadLightning", nil, {
                ["StartPosition"] = p1,
                ["EndPosition"] = p2,
                ["Points"] = 7,
                ["Size"] = 8,
                ["Branches"] = true,
                ["NoHighlight"] = true,
                ["RandomSize"] = NumberRange.new(0.15, 1),
                ["Offset"] = NumberRange.new(-25, 25),
                ["MainColor"] = Color3.fromRGB(230, 255, 255),
                ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                ["LightningDuration"] = 0.05,
                ["WaitFunction"] = function(p3, _) --[[ Name: WaitFunction, Line 22 ]]
                    if p3 % 2 == 0 then
                        task.wait()
                    end
                end
            })
            task.wait(0.05)
            local v4, _, _ = _G.getRayFloor(CFrame.new(p2 + Vector3.new(0, 5, 0)), 15)
            local v5 = script.Explosion:Clone()
            v5.CFrame = CFrame.new(p2)
            if v4 then
                v5.Impact["Dust 2"].Color = ColorSequence.new(v4.Color)
            else
                v5.Impact["Dust 2"]:Destroy()
            end
            v5.Parent = workspace.Effects
            _G.PlaySound(v5, script["strike" .. math.random(1, 6)])
            _G.customEmit(v5)
            _G.tween(v5.PointLight, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 60,
                ["Brightness"] = 0
            })
            _G.destroy(v5, 5)
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 14,
                ["Position"] = p2 + Vector3.new(0, 4, 0),
                ["DistanceRandomness"] = Vector2.new(0.1, 1),
                ["Duration"] = 2,
                ["TweenDuration"] = 2,
                ["Radius"] = 30,
                ["Direction"] = Vector3.new(0, -15, 0)
            })
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 10,
                ["RandomVelocityMagnitude"] = Vector2.new(-75, 75),
                ["Position"] = p2 + Vector3.new(0, 4, 0),
                ["Direction"] = Vector3.new(0, 75, 0),
                ["RaycastDirection"] = Vector3.new(0, -15, 0),
                ["Size"] = Vector3.new(1, 1, 1),
                ["TrailEnabled"] = true
            }, true)
            local v6 = Random.new()
            for _ = 1, 2 do
                _G.PlayEffect("DeadLightning", nil, {
                    ["StartPosition"] = p2,
                    ["EndPosition"] = p2 + v6:NextUnitVector() * v6:NextNumber(15, 30),
                    ["Points"] = 10,
                    ["Size"] = math.random(100, 200) / 100,
                    ["Branches"] = true,
                    ["NoHighlight"] = true,
                    ["RandomSize"] = NumberRange.new(0.15, 1),
                    ["Offset"] = NumberRange.new(-50, 50),
                    ["MainColor"] = Color3.fromRGB(230, 255, 255),
                    ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                    ["LightningDuration"] = math.random(100, 200) / 1000,
                    ["WaitFunction"] = function(p7, _) --[[ Name: WaitFunction, Line 87 ]]
                        if p7 % 2 == 0 then
                            task.wait(math.random(100, 300) / 10000)
                        end
                    end
                })
                task.wait(0.025)
            end
        end
    end
}