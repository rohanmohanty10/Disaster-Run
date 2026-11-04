 

local v1 = game:GetService("ReplicatedStorage")
local v2 = {}
local u3 = require(v1.Modules.VFXUtility.mesh_emit)
local u4 = require(v1.Modules.VFXUtility.highlight_emit)
local u5 = require(v1.Modules.VFXUtility.beam_emit)
require(v1.Modules.VFXUtility.colorcorrection_emit)
function v2.start(_, p6, p7) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
    --]]
    local v8 = p6.PrimaryPart
    if v8 then
        local v9 = p7.serverStartTime
        local v10 = workspace:GetServerTimeNow() - v9
        local v11 = p6:FindFirstChild("Ghost Princess\'s UmbrellaSword")
        local v12, v13
        if v11 then
            v12 = v11:FindFirstChild("Umbrella_Closed")
            v13 = v11:FindFirstChild("Umbrella_Open")
        else
            v13 = nil
            v12 = nil
        end
        local v14 = p7.Speed
        if p7.Type == "Startup" then
            _G.PlaySound(v8, script.Startup).Parent = v8
            task.wait((0.2315 - v10) / v14)
            local v15 = script.Gr:Clone()
            u3.new(v15):Emit(v8.CFrame * CFrame.new(v15:GetAttribute("Offset")))
            local v16 = script.Start:Clone()
            v16.Parent = v8
            _G.customEmit(v16)
            _G.destroy(v16, 5)
            u4.tweenHighlight(p6, Color3.fromRGB(255, 103, 214), Color3.fromRGB(255, 103, 214), 0.7, Enum.HighlightDepthMode.Occluded, "In", 0.25)
            _G.PlaySound(v8, script.Indicator).Parent = v8
            if v12 and v13 then
                v12.Transparency = 0
                v13.Transparency = 1
                return
            end
        else
            task.wait((p7.DelayTime - v10) / v14)
            _G.PlaySound(v8, script.ThrustSFX)
            local v17 = script.Cu:Clone()
            u3.new(v17):Emit(v8.CFrame * CFrame.new(v17:GetAttribute("Offset")))
            local v18 = script.Cu2:Clone()
            u3.new(v18):Emit(v8.CFrame * CFrame.new(v18:GetAttribute("Offset")))
            local v19 = script.Beams1
            v19.CFrame = v8.CFrame * CFrame.new(0, 0, -8) * CFrame.Angles(0, 3.141592653589793, 0)
            local v20 = u5
            local v21 = {
                ["Properties"] = {
                    ["Brightness"] = 36,
                    ["LightEmission"] = 0,
                    ["TextureSpeed"] = 0,
                    ["Width0"] = 60,
                    ["Width1"] = 15
                },
                ["RotationSpeed"] = 300,
                ["Rotation"] = true,
                ["Offset"] = CFrame.new(0, 0, 0),
                ["Duration"] = 0.05,
                ["Easing"] = "Sine",
                ["EasingDirection"] = "Out"
            }
            v20(v19, v21)
            local v22 = script.WindBeamsLess
            v22.CFrame = v8.CFrame * CFrame.new(0, 0, -8) * CFrame.Angles(0, 0, 0)
            local v23 = u5
            local v24 = {
                ["Properties"] = {
                    ["Brightness"] = 0,
                    ["LightEmission"] = 1,
                    ["TextureSpeed"] = 1,
                    ["Width0"] = 3,
                    ["Width1"] = 9
                },
                ["RotationSpeed"] = 5,
                ["Rotation"] = true,
                ["Offset"] = CFrame.new(0, 0, 0),
                ["Duration"] = 1,
                ["Easing"] = "Sine",
                ["EasingDirection"] = "Out"
            }
            v23(v22, v24)
            local v25, v26, v27 = _G.getRayFloor(v8.CFrame, 10)
            local v28 = script.Thrust:Clone()
            v28.Parent = v8
            local v29 = {}
            if v25 then
                local v30 = v28.Smoke
                local v31 = v28.Wind
                v30.Parent = workspace.Effects
                v31.Parent = workspace.Effects
                v30.WorldCFrame = CFrame.new(v26, v26 + v27) * CFrame.Angles(-1.5707963267948966, 0, 0)
                _G.recolorParticles(v30, v25.Color, "UseGroundColor")
                v31.WorldCFrame = v30.WorldCFrame
                table.insert(v29, v30)
                table.insert(v29, v31)
            else
                v28.Smoke:Destroy()
            end
            for v32 = 1, #v29 do
                _G.customEmit(v29[v32])
                _G.destroy(v29[v32], 5)
            end
            _G.customEmit(v28)
            _G.destroy(v28, 5)
            task.wait(0.1)
            if v13 and v12 then
                v12.Transparency = 1
                v13.Transparency = 0
            end
        end
    end
end
return v2