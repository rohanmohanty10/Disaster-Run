 

local v1 = {}
game:GetService("ReplicatedStorage")
game:GetService("Players")
game:GetService("Debris")
game:GetService("Workspace")
local u2 = script.Move2
local _ = u2.Anims
local v3 = script.Move2.Mesh:Clone()
v3.CFrame = CFrame.new(0, -500, 0)
v3.Parent = workspace.Effects
function v1.start(_, p4, p5, p6, p7) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p4 ~= nil then
        local v8
        if p4 then
            v8 = p4.PrimaryPart
        else
            v8 = p4
        end
        if v8 ~= nil then
            if _G.checkRenderDistance(p4.PrimaryPart.Position) ~= false then
                local u9 = Instance.new("Folder")
                u9.Parent = workspace.Effects
                local v10 = p4:WaitForChild("HumanoidRootPart")
                p4:WaitForChild("Humanoid")
                local v11 = u2.UltraTigerHunt:Clone()
                local v12 = u2.Impact:Clone()
                local v13 = u2.Mesh:Clone()
                v11.CFrame = v10.CFrame
                local v14, _, _ = _G.getRayFloor(p5, 2)
                v12.CFrame = p5
                v13.CFrame = v12.CFrame * CFrame.new(0, 4, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
                _G.PlaySound(p4.PrimaryPart, script["3ssTigerHuntSlash"])
                if v14 then
                    _G.recolorParticles(v12, v14.Color)
                    _G.PlayEffect("GroundRocks4", nil, {
                        ["Segments"] = 20,
                        ["Position"] = v12.Position + Vector3.new(0, 5, 0),
                        ["DistanceRandomness"] = Vector2.new(0.25, 1),
                        ["Duration"] = 2,
                        ["TweenDuration"] = 1,
                        ["Radius"] = 9,
                        ["Direction"] = Vector3.new(0, -15, 0)
                    })
                    _G.PlayEffect("RockDebris", nil, {
                        ["PartCount"] = 8,
                        ["RandomVelocityMagnitude"] = Vector2.new(-55, 55) / 2,
                        ["Position"] = v12.Position,
                        ["Direction"] = Vector3.new(0, 65, 0),
                        ["RaycastDirection"] = Vector3.new(0, -30, 0),
                        ["Size"] = Vector3.new(0.7, 0.7, 0.7),
                        ["TrailEnabled"] = true
                    })
                end
                local v15 = Instance.new("Highlight")
                v15.OutlineTransparency = 0.25
                v15.DepthMode = Enum.HighlightDepthMode.Occluded
                v15.FillTransparency = 0.25
                v15.OutlineColor = Color3.fromRGB(255, 62, 32)
                v15.FillColor = Color3.fromRGB(0, 0, 0)
                v15.Parent = v13
                if p7 then
                    _G.PlayEffect("3SSRecolor", nil, { v12, v11, v13 }, p7)
                    v15.OutlineColor = p7
                end
                v11.Parent = u9
                v12.Parent = u9
                v13.Parent = u9
                _G.customEmit(v11)
                if p6 == true then
                    _G.customEmit(v12)
                    _G.PlaySound(v12, script["3ssTigerHuntGroundSmash"], {
                        ["RandomPitch"] = true
                    })
                end
                _G.tween(v13, {
                    0.35,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(18, 0, 0),
                    ["Transparency"] = 0.04
                })
                for _, v16 in ipairs(v11:GetDescendants()) do
                    if v16:IsA("Beam") then
                        _G.tween(v16, {
                            0.17,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        })
                    end
                end
                task.delay(1.5, function() --[[ Line: 140 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                    --]]
                    _G.destroy(u9, 1.5)
                end)
            end
        end
    end
end
return v1