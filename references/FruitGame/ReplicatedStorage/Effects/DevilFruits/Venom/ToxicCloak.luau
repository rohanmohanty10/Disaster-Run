 

local v1 = {}
game:GetService("RunService")
local u2 = game:GetService("TweenService")
game:GetService("UserInputService")
game.Players.LocalPlayer:GetMouse()
local function u8(p3) --[[ Line: 15 ]]
    local v4 = UserSettings().GameSettings.SavedQualityLevel.Value
    local v5 = math.clamp(v4, 1, 10)
    for _, v6 in p3:GetDescendants() do
        if v6:IsA("ParticleEmitter") then
            local v7 = v6:GetAttribute("EmitCount") * (v5 / 10)
            v6:Emit((math.clamp(v7, 1, v6:GetAttribute("EmitCount"))))
        end
    end
end
function v1.start(_, p9, p10) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u2
    --]]
    if _G.checkRenderDistance(p9.PrimaryPart.Position) ~= false then
        if p10 then
            local v11 = script.Counter:Clone()
            v11.CFrame = CFrame.new(p9.PrimaryPart.Position, p10.PrimaryPart.Position)
            v11.Parent = workspace.Effects
            u8(v11)
            _G.destroy(v11, 4)
            _G.PlaySound(p9.PrimaryPart, script.Sounds.VenomCounterBoom)
            for v12 = 1, 5 do
                local v13 = script.Shockwave:Clone()
                v13.CFrame = v11.CFrame * CFrame.new(0, 0, -v12 * 1.5) * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0)
                v13.Parent = workspace.Effects
                v13.Mesh.Scale = Vector3.new(0, 0, 0)
                u2:Create(v13, TweenInfo.new(0.6), {
                    ["CFrame"] = v13.CFrame * CFrame.Angles(0, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0)
                }):Play()
                u2:Create(v13.Mesh, TweenInfo.new(0.5), {
                    ["Scale"] = Vector3.new(6, 34.8, 5.5) * Random.new():NextNumber(1.1, 1.4)
                }):Play()
                u2:Create(v13.Glow, TweenInfo.new(0.4), {
                    ["Transparency"] = 1
                }):Play()
                _G.destroy(v13, 0.5)
                task.wait()
            end
        end
    end
end
return v1