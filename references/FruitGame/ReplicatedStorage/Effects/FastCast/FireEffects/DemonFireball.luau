 

local v1 = {}
require(game.ReplicatedStorage.Refrences.Fishman.Modules.SpikyFoam)
local function u4(p2) --[[ Line: 5 ]]
    local v3 = p2:Clone()
    p2.Enabled = false
    v3.Parent = p2.Parent
    v3.Enabled = false
    v3.Lifetime = NumberRange.new(0.25, 0.5)
    v3.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 10, 5), NumberSequenceKeypoint.new(1, 0, 0) })
    v3.Speed = NumberRange.new(50, 100)
    v3.Drag = 5
    v3.SpreadAngle = Vector2.new(-360, 360)
    v3:Emit(40)
end
function v1.impact(p5, p6, _, _, _) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v7 = require(script.Explode)
    p5.Anchored = true
    p5.Parent = workspace.Effects
    u4(p5.Attachment.BurningPart)
    p5.looped:Stop()
    v7:start(p5.CFrame, p5.CFrame, p5, p6)
    _G.tween(p5.PointLight, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Range"] = 50,
        ["Brightness"] = 0
    })
    _G.destroy(p5, 2)
    local v8 = script.Explode.sphere:Clone()
    v8.Parent = workspace.Effects
    v8.CFrame = p5.CFrame
    v8.Material = Enum.Material.ForceField
    v8.Transparency = -1
    _G.tween(v8, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Transparency"] = 1
    })
    _G.tween(v8.Mesh, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Scale"] = Vector3.new(45, 45, 45)
    })
    _G.destroy(v8, 0.25)
    _G.PlaySound(v8, script.ex)
end
local u9 = {}
function v1.move(p10, p11) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    if _G.checkRenderDistance(p11.Position) == false then
        return
    else
        if u9[p10] == nil then
            u9[p10] = { p11, p11 }
        end
        local v12 = u9[p10][1]
        if (v12.p - p11.p).magnitude > 5 then
            local v13 = script.Part:Clone()
            local v14 = (v12.p - p11.p).magnitude
            v13.Mesh.Scale = Vector3.new(0, v14, 0)
            v13.CFrame = CFrame.new(v12.p, p11.p) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -v14 / 2, 0)
            if (u9[p10][2].p - p11.p).magnitude >= 40 then
                local v15 = v13.CFrame * CFrame.Angles(3.141592653589793, 0, 0)
                _G.PlayEffect("Shockwave2", nil, v15, v15, BrickColor.new("White"), Vector3.new(15, 1, 15), Vector3.new(0, 1, 0), 0.25, 0, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
                u9[p10][2] = v15
            end
            v13.Mesh.Scale = Vector3.new(3, v14, 3)
            v13.Parent = workspace.Effects
            _G.tween(v13.Mesh, {
                0.25,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0, v14, 0)
            })
            _G.tween(v13, {
                0.25,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = BrickColor.new("Persimmon").Color
            })
            _G.destroy(v13, 0.25)
            u9[p10][1] = p11
        end
    end
end
function v1.splash(p16, p17) --[[ Line: 80 ]]
    local v18 = p16:GetDescendants()
    for v19 = 1, #v18 do
        if v18[v19]:IsA("ParticleEmitter") then
            v18[v19].Enabled = false
        end
    end
    _G.destroy(p16, 2)
    p16.Parent = workspace.Effects
    Instance.new("BoolValue", p16).Name = "FinishHit"
    local v20 = script.smoke:Clone()
    v20.Parent = workspace.Effects
    v20.CFrame = p17
    v20.Attachment.sm2:Emit(35)
    _G.destroy(v20, 2)
end
function v1.Fire(_, _, p21) --[[ Line: 99 ]]
    p21.looped:Play()
end
return v1