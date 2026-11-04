 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("TweenService")
local v3 = {}
local u4 = require(v1.Modules.VFXUtility.mesh_emit)
local u5 = require(v1.Modules.VFXUtility.highlight_emit)
require(v1.Modules.VFXUtility.beam_emit)
require(v1.Modules.VFXUtility.colorcorrection_emit)
function v3.start(_, p6, p7) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u2
    --]]
    local v8 = p6.PrimaryPart
    if v8 then
        local v9 = p7.serverStartTime
        local v10 = workspace:GetServerTimeNow() - v9
        if p6.PrimaryPart then
            if p7.delayTime then
                p7.delayTime = p7.delayTime - v10
            end
            if p7.Type == "Startup" then
                _G.PlaySound(p6.PrimaryPart, script["UmbrellaOpen(wTail)"]).Parent = p6.PrimaryPart
                task.wait(p7.delayTime)
                local v11 = p6:FindFirstChild("Ghost Princess\'s UmbrellaSword")
                local v12 = script.GoUp:Clone()
                u4.new(v12):Emit(v8.CFrame * CFrame.new(v12:GetAttribute("Offset")))
                local v13 = script.UpSwirl:Clone()
                u4.new(v13):Emit(v8.CFrame * CFrame.new(v13:GetAttribute("Offset")))
                local v14 = {}
                local v15 = script.FloatFx:Clone()
                v15.CFrame = p6.PrimaryPart.CFrame
                local v16 = Instance.new("Weld")
                v16.Part0 = v15
                v16.Part1 = p6.PrimaryPart
                v16.C0 = CFrame.new(0, p6.PrimaryPart.Size.Y, 0)
                v16.Parent = v15
                v15.Parent = workspace.Effects
                table.insert(v14, v15)
                _G.particleEnabled(v15, true)
                if v11 and v11:FindFirstChild("U_Handle") then
                    local v17 = script.U_Handle.Float:Clone()
                    v17.Parent = v11.U_Handle
                    _G.particleEnabled(v17, true)
                    _G.customEmit(v17)
                    _G.destroy(v17, 5)
                    table.insert(v14, v17)
                    local v18 = script.U_Handle.Fx:Clone()
                    v18.Parent = v11.U_Handle
                    _G.customEmit(v18)
                    _G.destroy(v18, 5)
                end
                local v19 = script.FloatStart:Clone()
                v19.Parent = p6.PrimaryPart
                _G.customEmit(v19)
                _G.destroy(v19, 5)
                u5.tweenHighlight(p6, Color3.fromRGB(255, 103, 214), Color3.fromRGB(255, 103, 214), 0.7, Enum.HighlightDepthMode.Occluded, "In", 0.25)
                local v20 = script.Winds:Clone()
                v20.CFrame = v8.CFrame * CFrame.new(2, 7, 2) * CFrame.Angles(1.5707963267948966, 0, 0)
                local v21 = Instance.new("WeldConstraint")
                v21.Part0 = v20
                v21.Part1 = v8
                v21.Parent = v20
                v20.Parent = workspace.Effects
                _G.destroy(v20, 5)
                local v22 = {
                    ["Properties"] = {
                        ["Brightness"] = 0,
                        ["LightEmission"] = 1,
                        ["TextureSpeed"] = 1,
                        ["Width0"] = 5,
                        ["Width1"] = 9
                    },
                    ["RotationSpeed"] = 250,
                    ["Rotation"] = true,
                    ["Offset"] = CFrame.new(0, 0, 0),
                    ["Duration"] = 1,
                    ["Easing"] = "Sine",
                    ["EasingDirection"] = "Out"
                }
                for _, u23 in v20:GetDescendants() do
                    if u23:IsA("Beam") then
                        u23.Enabled = true
                        local u24 = {
                            ["Width0"] = u23.Width0,
                            ["Width1"] = u23.Width1,
                            ["TextureSpeed"] = u23.TextureSpeed,
                            ["Brightness"] = u23.Brightness,
                            ["LightEmission"] = u23.LightEmission
                        }
                        local v25 = u2:Create(u23, TweenInfo.new(v22.Duration, Enum.EasingStyle[v22.Easing], Enum.EasingDirection[v22.EasingDirection]), v22.Properties)
                        v25:Play()
                        v25.Completed:Once(function() --[[ Line: 137 ]]
                            --[[
                            Upvalues:
                                [1] = u23
                                [2] = u24
                            --]]
                            u23.Enabled = false
                            for v26, v27 in u24 do
                                u23[v26] = v27
                            end
                        end)
                    end
                end
                local v28 = script.UmbrellaLoop:Clone()
                v28.Parent = p6.PrimaryPart
                v28:Play()
                repeat
                    task.wait()
                until p6:GetAttribute("UmbrellaFloatHold") == nil
                u2:Create(v28, TweenInfo.new(0.25), {
                    ["Volume"] = 0
                }):Play()
                _G.destroy(v28, 0.25)
                for v29 = 1, #v14 do
                    _G.particleEnabled(v14[v29], false)
                    _G.destroy(v14[v29], 5)
                end
            end
        end
    else
        return
    end
end
return v3