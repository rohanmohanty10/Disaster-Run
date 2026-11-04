 

local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Modules.Client.WeaponVFXRecolor)
local v3 = {}
local function u7(p4, p5) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = script["Pika Tp Dash Main"]:Clone()
    u2.apply(v6, p5)
    v6.CFrame = p4
    v6.Parent = workspace.Effects
    _G.customEmit(v6)
    _G.destroy(v6, 3)
end
function v3.start(_, p8, p9, p10) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u7
    --]]
    if p10 and game.Players.LocalPlayer == p10 then
        return
    elseif _G.checkRenderDistance(p9.Position) ~= false then
        local v11 = p10 and _G.char_npc(p10) or game.Players.LocalPlayer.Character
        local v12 = script.Part:Clone()
        u2.apply(v12, v11)
        v12.Parent = workspace.Effects
        v12.CFrame = p9
        _G.customEmit(v12.Attachment)
        _G.tween(v12.PointLight, {
            0.2,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 16,
            ["Brightness"] = 0
        })
        _G.destroy(v12, 1)
        u7(p8, v11)
        u7(p9, v11)
        _G.PlaySound(p9, script["Audio/LightDash" .. math.random(1, 3)], {
            ["RandomPitch"] = true
        })
        local v13 = (p8.Position - p9.Position).Magnitude
        local v14 = script.cyn:Clone()
        u2.apply(v14, v11)
        v14.Parent = workspace.Effects
        v14.CFrame = CFrame.new(p8.Position, p9.Position) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -v13 / 2, 0)
        v14.Mesh.Scale = Vector3.new(1, v13, 1)
        local v15 = _G.tween
        local v16 = v14.Mesh
        local v17 = {
            0.2,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v18 = {
            ["Scale"] = Vector3.new(0, 0, 0)
        }
        local v19 = -v13 / 2
        v18.Offset = Vector3.new(0, v19, 0)
        v15(v16, v17, v18)
        _G.destroy(v14, 0.2)
    end
end
return v3