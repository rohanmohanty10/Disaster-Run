 

local v1 = {}
require(script:WaitForChild("AttachStretch"))
local u2 = require(script:WaitForChild("SnapEffect"))
local u3 = {
    ["RightFull"] = { "RightUpperArm", "RightLowerArm", "RightHand" },
    ["LeftFull"] = { "LeftUpperArm", "LeftLowerArm", "LeftHand" },
    ["RightHalf"] = { "RightLowerArm", "RightHand" },
    ["LeftHalf"] = { "LeftLowerArm", "LeftHand" }
}
function set_limb_visible(p4, p5, p6)
    --[[
    Upvalues:
        [1] = u3
    --]]
    for _, v7 in u3[p5] do
        p4[v7].Transparency = p6
    end
end
local u117 = {
    ["pistol_shoot"] = function(p8, p9) --[[ Line: 20 ]]
        local v10 = p8:WaitForChild("GumRight", 5)
        set_limb_visible(p8, "RightHalf", 1)
        v10.Transparency = 0
        local v11 = _G.tween
        local v12 = v10.Attachment2
        local v13 = {
            0.15,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v14 = {}
        local v15 = -p9
        v14.Position = Vector3.new(0, v15, 0)
        v11(v12, v13, v14)
        local v16 = _G.tween
        local v17 = v10.Extend
        local v18 = {
            0.15,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v19 = {}
        local v20 = -p9
        v19.Position = Vector3.new(0, v20, 0)
        v16(v17, v18, v19)
        _G.tween(v10.Beam, {
            0.15,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = 5
        })
        local v21 = v10.targetAttachment
        local v22 = -p9
        v21.Position = Vector3.new(0, v22, 0)
    end,
    ["pistol_end"] = function(p23) --[[ Line: 30 ]]
        local v24 = p23:WaitForChild("GumRight", 5)
        local v25 = p23.HumanoidRootPart.CFrame
        _G.tween(v24.Extend, {
            0.2,
            "Exponential",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["WorldCFrame"] = v25 * CFrame.new(-1, 0, -1) * CFrame.Angles(-1.51, 0, 0)
        })
        _G.tween(v24.Attachment2, {
            0.2,
            "Exponential",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["WorldCFrame"] = v25 * CFrame.new(-1, 0, -1) * CFrame.Angles(-1.51, 0, 0)
        })
        _G.tween(v24.Beam, {
            0.2,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = -50
        })
    end,
    ["gatling_prep"] = function(p26) --[[ Line: 39 ]]
        set_limb_visible(p26, "LeftFull", 1)
        set_limb_visible(p26, "RightFull", 1)
        local v27 = p26.Humanoid
        local v28 = script.GatlingSpurt:Clone()
        v28.Name = "SpurtRight"
        v28.CFrame = p26.RightUpperArm.CFrame * CFrame.Angles(0, 0, 1.51)
        local v29 = v28.Mesh
        local v30 = v27.BodyHeightScale.Value + 0.5
        local v31 = v27.BodyWidthScale.Value
        local v32 = v27.BodyDepthScale.Value
        v29.Scale = Vector3.new(v30, v31, v32)
        v28.Color = p26.RightUpperArm.Color
        v28.WC.Part1 = p26.RightUpperArm
        v28.Anchored = false
        v28.WC.Enabled = true
        v28.Parent = p26
        local v33 = script.GatlingSpurt:Clone()
        v33.Name = "SpurtLeft"
        v33.CFrame = p26.LeftUpperArm.CFrame * CFrame.Angles(0, 0, 1.51)
        local v34 = v33.Mesh
        local v35 = v27.BodyHeightScale.Value + 0.5
        local v36 = v27.BodyWidthScale.Value
        local v37 = v27.BodyDepthScale.Value
        v34.Scale = Vector3.new(v35, v36, v37)
        v33.Color = p26.LeftUpperArm.Color
        v33.WC.Part1 = p26.LeftUpperArm
        v33.Anchored = false
        v33.WC.Enabled = true
        v33.Parent = p26
    end,
    ["bazooka_prep"] = function(p38) --[[ Line: 64 ]]
        local v39 = p38:WaitForChild("GumRight", 5)
        local v40 = p38:WaitForChild("GumLeft", 5)
        local _ = p38.HumanoidRootPart.CFrame
        set_limb_visible(p38, "LeftHalf", 1)
        set_limb_visible(p38, "RightHalf", 1)
        v39.Transparency = 0
        v40.Transparency = 0
        _G.tween(v39.Extend, {
            0.5,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Position"] = Vector3.new(0, -15, 0)
        })
        _G.tween(v40.Extend2, {
            0.5,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Position"] = Vector3.new(0, -15, 0)
        })
        _G.tween(v39.Attachment2, {
            0.5,
            "EntranceExpressive",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Position"] = Vector3.new(0, -15, 0)
        })
        _G.tween(v39.Beam, {
            0.5,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = -100
        })
        _G.tween(v40.Attachment2, {
            0.5,
            "EntranceExpressive",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Position"] = Vector3.new(0, -15, 0)
        })
        _G.tween(v40.Beam, {
            0.5,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = -100
        })
        _G.PlaySound(p38.HumanoidRootPart, script.BazookaStart)
        task.wait(0.5)
        v40.Beam.Enabled = false
        v39.Beam.Enabled = false
    end,
    ["bazooka_start"] = function(p41) --[[ Line: 94 ]]
        local v42 = p41:WaitForChild("GumRight", 5)
        local v43 = p41:WaitForChild("GumLeft", 5)
        local _ = p41.HumanoidRootPart.CFrame
        _G.tween(v42.Extend, {
            0.45,
            "UWPAccelerate",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Position"] = Vector3.new(-0.013, -0.575, 0.006)
        })
        _G.tween(v43.Extend2, {
            0.45,
            "UWPAccelerate",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Position"] = Vector3.new(-0.011, -0.574, 0.006)
        })
    end,
    ["bazooka_shoot"] = function(p44) --[[ Line: 101 ]]
        local v45 = p44:WaitForChild("GumRight", 5)
        local v46 = p44:WaitForChild("GumLeft", 5)
        local _ = p44.HumanoidRootPart.CFrame
        v46.Beam.Enabled = true
        v45.Beam.Enabled = true
        _G.tween(v45.Extend, {
            0.25,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Position"] = Vector3.new(0, -40, 0)
        })
        _G.tween(v46.Extend2, {
            0.25,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Position"] = Vector3.new(0, -40, 0)
        })
        _G.tween(v46.Attachment2, {
            0.25,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Position"] = Vector3.new(0, -40, 0)
        })
        _G.tween(v46.Beam, {
            0.25,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = 100
        })
        _G.tween(v45.Attachment2, {
            0.25,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Position"] = Vector3.new(0, -40, 0)
        })
        _G.tween(v45.Beam, {
            0.25,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = 100
        })
    end,
    ["bazooka_end"] = function(p47) --[[ Line: 118 ]]
        local v48 = p47:WaitForChild("GumRight", 5)
        local v49 = p47:WaitForChild("GumLeft", 5)
        local v50 = p47.HumanoidRootPart.CFrame
        _G.tween(v48.Extend, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["WorldCFrame"] = v50 * CFrame.new(-1, 0, -1) * CFrame.Angles(-1.51, 0, 0)
        })
        _G.tween(v49.Extend2, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["WorldCFrame"] = v50 * CFrame.new(-1, 0, -1) * CFrame.Angles(-1.51, 0, 0)
        })
        _G.tween(v49.Attachment2, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["WorldCFrame"] = v50 * CFrame.new(-1, 0, -1) * CFrame.Angles(-1.51, 0, 0)
        })
        _G.tween(v49.Beam, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = 100
        })
        _G.tween(v48.Attachment2, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["WorldCFrame"] = v50 * CFrame.new(-1, 0, -1) * CFrame.Angles(-1.51, 0, 0)
        })
        _G.tween(v48.Beam, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = 100
        })
    end,
    ["rifle_prep"] = function(p51) --[[ Line: 134 ]]
        set_limb_visible(p51, "RightHalf", 1)
    end,
    ["snap"] = function(p52, p53) --[[ Line: 150 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        u2(p52.HumanoidRootPart, p53)
    end,
    ["reset"] = function(p54) --[[ Line: 153 ]]
        local v55 = p54:FindFirstChild("GumRight")
        local v56 = p54:FindFirstChild("GumLeft")
        set_limb_visible(p54, "LeftFull", 0)
        set_limb_visible(p54, "RightFull", 0)
        if p54:FindFirstChild("SpurtRight") then
            p54.SpurtLeft:Destroy()
            p54.SpurtRight:Destroy()
        end
        if p54:FindFirstChild("RifleLimb") then
            p54.RifleLimb:Destroy()
        end
        if v55 then
            v55:Destroy()
        end
        if v56 then
            v56:Destroy()
        end
    end,
    ["rocket_shoot"] = function(p57, p58) --[[ Line: 178 ]]
        local v59 = p57:WaitForChild("GumLeft", 5)
        local v60 = p57:WaitForChild("GumRight", 5)
        set_limb_visible(p57, "LeftHalf", 1)
        set_limb_visible(p57, "RightHalf", 1)
        local v61 = _G.tween
        local v62 = v59.Extend2
        local v63 = {
            0.15,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v64 = {}
        local v65 = -p58
        v64.Position = Vector3.new(0, v65, 0)
        v61(v62, v63, v64)
        local v66 = _G.tween
        local v67 = v60.Extend
        local v68 = {
            0.15,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v69 = {}
        local v70 = -p58
        v69.Position = Vector3.new(0, v70, 0)
        v66(v67, v68, v69)
        _G.tween(v59.Beam, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = 100
        })
        _G.tween(v60.Beam, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = 100
        })
    end,
    ["rocket_pull"] = function(u71, p72) --[[ Line: 189 ]]
        local u73 = u71:WaitForChild("GumRight", 5)
        local u74 = u71:WaitForChild("GumLeft", 5)
        local v75 = u71.HumanoidRootPart.CFrame
        local u76 = u73.Extend.WorldCFrame
        local u77 = u74.Extend2.WorldCFrame
        local _ = p72.Position - p72.Instance.Position
        local _ = p72.Position + v75.rightVector
        local _ = p72.Position - v75.rightVector
        local _ = p72.Position + v75.upVector * 10000
        local u78 = nil
        local u79 = tick()
        _G.PlaySound(CFrame.new(u73.Extend.WorldCFrame.Position), script.attach)
        local u80
        if p72.Instance.Anchored == true then
            local v81 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 206 ]]
                --[[
                Upvalues:
                    [1] = u73
                    [2] = u76
                    [3] = u74
                    [4] = u77
                    [5] = u78
                --]]
                if not pcall(function() --[[ Line: 207 ]]
                    --[[
                    Upvalues:
                        [1] = u73
                        [2] = u76
                        [3] = u74
                        [4] = u77
                    --]]
                    u73.Extend.WorldCFrame = u76
                    u74.Extend2.WorldCFrame = u77
                end) then
                    u78:Disconnect()
                    u78 = nil
                    warn("disconnected")
                end
            end)
            u80 = v81
        else
            local u82 = p72.Instance
            local u83 = u82.CFrame:ToObjectSpace(u76)
            local u84 = u82.CFrame:ToObjectSpace(u77)
            u80 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 221 ]]
                --[[
                Upvalues:
                    [1] = u73
                    [2] = u82
                    [3] = u83
                    [4] = u74
                    [5] = u84
                    [6] = u78
                --]]
                if not pcall(function() --[[ Line: 222 ]]
                    --[[
                    Upvalues:
                        [1] = u73
                        [2] = u82
                        [3] = u83
                        [4] = u74
                        [5] = u84
                    --]]
                    u73.Extend.WorldCFrame = u82.CFrame * u83
                    u74.Extend2.WorldCFrame = u82.CFrame * u84
                end) then
                    u78:Disconnect()
                    u78 = nil
                    warn("disconnected")
                end
            end)
        end
        delay(0.4, function() --[[ Line: 233 ]]
            --[[
            Upvalues:
                [1] = u80
            --]]
            if u80 then
                u80:Disconnect()
            end
        end)
        local u85 = nil
        local u86 = 0
        local u87 = u71.HumanoidRootPart.CFrame.Position
        local u88 = 5
        local u89 = u71.HumanoidRootPart.CFrame.Position
        local u90 = false
        u85 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 245 ]]
            --[[
            Upvalues:
                [1] = u79
                [2] = u85
                [3] = u71
                [4] = u87
                [5] = u90
                [6] = u88
                [7] = u89
                [8] = u86
            --]]
            if tick() - u79 >= 1 then
                u85:Disconnect()
                u85 = nil
            end
            local v91 = u71.HumanoidRootPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
            if (u87 - v91.Position).Magnitude >= 10 then
                Color3.fromRGB(255, 255, 255)
                if u90 == false then
                    Color3.fromRGB(0, 0, 0)
                end
                u87 = v91.Position
            end
            u88 = 50 / (v91.Position - u89).Magnitude
            if tick() - u86 >= u88 / 100 then
                u86 = tick()
                local v92 = script.Part:Clone()
                v92.CFrame = u71.HumanoidRootPart.CFrame * CFrame.new(math.random(-5, 5), math.random(-5, 5), math.random(-15, 5))
                local v93 = (v91.Position - u89).Magnitude / 2 + 80
                local v94 = math.random(v93 / 2, v93) / 10
                local v95 = math.random(1, 5) / 10
                v92.Mesh.Scale = Vector3.new(v95, v95, v94)
                u90 = not u90
                if u90 == true then
                    v92.Transparency = 0.5
                    v92.Color = Color3.fromRGB(0, 0, 0)
                end
                v92.Parent = workspace.Effects
                local v96 = math.random(100, 200) / 1000
                u88 = (v91.Position - u89).Magnitude / 10
                _G.tween(v92, {
                    v96,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["CFrame"] = v92.CFrame * CFrame.new(0, 0, math.random(u88 / 2, u88))
                })
                _G.tween(v92.Mesh, {
                    v96,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.In,
                    0,
                    true,
                    0
                }, {
                    ["Scale"] = Vector3.new(0, 0, v94)
                })
                _G.destroy(v92, v96)
            end
        end)
    end,
    ["rocket_end"] = function(p97) --[[ Line: 303 ]]
        local v98 = p97:WaitForChild("GumRight", 5)
        local v99 = p97:WaitForChild("GumLeft", 5)
        local v100 = p97.HumanoidRootPart.CFrame
        _G.tween(v98.Extend, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["WorldCFrame"] = v100 * CFrame.new(-1, 0, -1) * CFrame.Angles(-1.51, 0, 0)
        })
        _G.tween(v99.Extend2, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["WorldCFrame"] = v100 * CFrame.new(-1, 0, -1) * CFrame.Angles(-1.51, 0, 0)
        })
        _G.tween(v99.Beam, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = -100
        })
        _G.tween(v98.Beam, {
            0.285,
            "UWPAccelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextureSpeed"] = -100
        })
    end,
    ["wist"] = function(_, p101) --[[ Line: 313 ]]
        local v102 = p101.Limb:WaitForChild("RightGumGumHolder"):GetDescendants()
        for v103 = 1, #v102 do
            local v104 = v102[v103]
            local v105 = v104.Position
            local v106 = v104.Position.X
            local v107 = v104.Position.Z
            v104.Position = Vector3.new(v106, 0, v107)
            _G.tween(v104, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Orientation"] = v104.Orientation + Vector3.new(0, 25, 0),
                ["Position"] = v105
            })
        end
    end,
    ["wistend"] = function(_, u108) --[[ Line: 323 ]]
        local v109 = u108.Limb:WaitForChild("RightGumGumHolder"):GetDescendants()
        for v110 = 1, #v109 do
            local v111 = v109[v110]
            local _ = v111.Position
            local v112 = _G.tween
            local v113 = {
                0.2,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v114 = {
                ["Orientation"] = v111.Orientation + Vector3.new(0, 25, 0)
            }
            local v115 = v111.Position.X
            local v116 = v111.Position.Z
            v114.Position = Vector3.new(v115, 0, v116)
            v112(v111, v113, v114)
        end
        task.wait(1)
        pcall(function() --[[ Line: 332 ]]
            --[[
            Upvalues:
                [1] = u108
            --]]
            u108.Limb.WC:Destroy()
            u108:BreakJoints()
            u108.Limb.CFrame = CFrame.new()
        end)
        _G.destroy(u108, 0.1)
    end
}
function v1.start(_, p118, p119, ...) --[[ Line: 342 ]]
    --[[
    Upvalues:
        [1] = u117
    --]]
    if _G.checkRenderDistance(p118.HumanoidRootPart.Position) then
        u117[p119](p118, unpack({ ... }))
    end
end
return v1