 

local v1 = {}
function lookAt(p2, p3)
    local v4 = (p3 - p2).Unit
    local v5 = v4:Cross(Vector3.new(0, 1, 0))
    local v6 = v5:Cross(v4)
    return CFrame.fromMatrix(p2, v5, v6)
end
local u7 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
local u8 = require(game.ReplicatedStorage.Modules.sBeat)
function v1.start(_, p9, p10) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u7
    --]]
    if _G.checkRenderDistance(p9.PrimaryPart.Position) == false then
        return
    else
        local v11 = tick()
        while true do
            u8()
            for _ = 1, 2 do
                local v12 = -math.random(40, 70) / 10
                if math.random(1, 2) == 1 then
                    Color3.fromRGB(255, 255, 255)
                end
                local v13 = script.SwooshB:Clone()
                local v14 = math.random(100, 300) / 100
                local v15 = CFrame.Angles
                local v16 = 90 + math.random(-90, 90)
                local v17 = math.rad(v16)
                local v18 = math.random(-25, 25)
                v15(v17, math.rad(v18), -1.5707963267948966)
                v13.Mesh.Scale = Vector3.new(v14, 2.7, v14)
                v13.Decal.Transparency = 1
                local v19 = p9.HumanoidRootPart.CFrame * CFrame.new(0, 1, v12)
                local v20 = CFrame.Angles
                local v21 = math.random(-360, 360)
                local v22 = math.rad(v21)
                local v23 = math.random(-360, 360)
                local v24 = math.rad(v23)
                local v25 = math.random(-360, 360)
                v13.CFrame = v19 * v20(v22, v24, (math.rad(v25)))
                v13.Parent = workspace.Effects
                _G.tween(v13.Decal, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 0
                })
                _G.tween(v13.Mesh, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = v13.Mesh.Scale * 1.25
                })
                if math.random(1, 2) == 1 then
                    v13.Decal.Color3 = Color3.new(0, 0, 0)
                    u7.Do("thswir", v13)
                else
                    u7.Do("thswir", v13)
                end
                _G.destroy(v13, 1)
                local v26 = script.sphere:Clone()
                local v27 = math.random(15, 35)
                v26.Size = Vector3.new(0.3, v27, 0.3)
                local v28 = p9.HumanoidRootPart.CFrame * CFrame.new(math.random(-20, 20) / 10, math.random(-20, 20) / 10, v12)
                local v29 = CFrame.Angles
                local v30 = math.random(-360, 360)
                local v31 = math.rad(v30)
                local v32 = math.random(-360, 360)
                local v33 = math.rad(v32)
                local v34 = math.random(-360, 360)
                v26.CFrame = v28 * v29(v31, v33, (math.rad(v34)))
                local v35 = v26.Attachment
                local v36 = v26.Size.Y / 4
                v35.Position = Vector3.new(0, v36, 0)
                local v37 = 0.1
                if math.random(1, 2) == 1 then
                    v26.Color = Color3.fromRGB(0, 0, 0)
                else
                    v37 = 0.2
                end
                v26.Parent = workspace.Effects
                v26.Attachment.ParticleEmitter:Emit(1)
                local v38 = _G.tween
                local v39 = {
                    v37,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v40 = {}
                local v41 = v26.Size.Y
                v40.Size = Vector3.new(0, v41, 0)
                v40.Color = Color3.fromRGB(255, 0, 0)
                v38(v26, v39, v40)
                _G.tween(v26.Mesh, {
                    v37,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(0, 0, 0)
                })
                _G.destroy(v26, v37)
            end
            if tick() - v11 >= 0.025 then
                v11 = tick()
                _G.PlaySound(p9.Head, script["Audio/DaggerSkill2Slash" .. math.random(1, 5)], {
                    ["Pitch"] = math.random(110, 130) / 100
                })
                _G.shakenear(p9.HumanoidRootPart.CFrame.Position, 45, 35, 20, -1)
            end
            if p10.Parent == nil then
                return
            end
        end
    end
end
return v1