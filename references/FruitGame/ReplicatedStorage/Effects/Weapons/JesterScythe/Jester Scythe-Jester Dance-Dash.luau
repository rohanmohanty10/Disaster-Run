 

local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v2 = {}
local u3 = Random.new()
function AlignCFrame(p4, p5, _)
    local v6 = p4.Position
    local v7 = p4.LookVector:Cross(p5).Unit
    local v8 = (v7.Magnitude > 0.001 and v7 and v7 or p4.RightVector).Unit
    local v9 = v8:Cross(p5).Unit.Unit
    return CFrame.fromMatrix(v6, v8, p5, v9)
end
local function u17(p10, p11, p12) --[[ Line: 20 ]]
    if p11 == nil then
        p11 = CFrame.new()
    end
    local v13 = CFrame.new(p10.Position + Vector3.new(0, 5, 0))
    local v14 = Ray.new(v13.Position, v13.upVector * -25)
    local _, v15, v16 = _G.raycastWhitelist(v14, { workspace.Env, workspace.Islands, workspace.Ships })
    if p12 == nil then
        return p10
    else
        return AlignCFrame(CFrame.new(Vector3.new(), p10.LookVector) + v15, v16) * p11
    end
end
function v2.start(_, p18) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u17
        [3] = u3
    --]]
    if _G.checkRenderDistance(p18.PrimaryPart.Position) ~= false then
        local u19 = p18.HumanoidRootPart
        local v20 = CFrame.new(u19.CFrame.Position)
        local v21 = Ray.new(v20.Position, v20.upVector * -7)
        local v22, _, _ = _G.raycastWhitelist(v21, { workspace.Env, workspace.Islands, workspace.Ships })
        if v22 then
            local v23 = script.Dust:Clone()
            u1.apply(v23, p18)
            v23.CFrame = u17(u19.CFrame, nil, true)
            v23.Parent = workspace.Effects
            v23.Attachment.Dust.Color = ColorSequence.new(v22.Color)
            _G.customEmit(v23.Attachment)
            _G.destroy(v23, 2)
        end
        local u24 = script.Beams:Clone()
        u1.apply(u24, p18)
        local u25 = u24.End
        local u26 = u25.Fire
        u24.CFrame = p18.HumanoidRootPart.CFrame
        u24.Parent = workspace.Effects
        u25.Parent = u19
        for _, v27 in u24:GetChildren() do
            if v27:IsA("Beam") then
                _G.tween(v27, {
                    0.25,
                    "Quart",
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = NumberSequence.new(1)
                })
            end
        end
        _G.tween(u24.Start, { 0.25, "Sine", Enum.EasingDirection.In }, {
            ["Position"] = Vector3.new(0, 0, -25)
        })
        local u28 = script.Rush:Clone()
        u1.apply(u28, p18)
        u28.Parent = workspace.Effects
        _G.tween(u28.Colored, {
            0.25,
            "Quad",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.tween(u28.Black, {
            0.25,
            "Quad",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.tween(u28.Mesh, {
            0.5,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(5, 25, 5)
        })
        local v29 = CFrame.Angles
        local v30 = u3:NextInteger(0, 360)
        local u31 = v29(0, math.rad(v30), 0)
        local u32 = 0
        local u34 = game:GetService("RunService").RenderStepped:Connect(function(p33) --[[ Line: 81 ]]
            --[[
            Upvalues:
                [1] = u32
                [2] = u28
                [3] = u19
                [4] = u31
            --]]
            u32 = u32 + p33 * 4
            u28.CFrame = u19.CFrame * CFrame.Angles(1.5707963267948966, u32, 0) * u31 * CFrame.new(0, -8, 0) * CFrame.new(0, u28.Mesh.Scale.Y / 2, 0)
        end)
        task.delay(0.2, function() --[[ Line: 89 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u19
            --]]
            u26.Enabled = false
            u26.Parent = u19
            _G.destroy(u26, 0.5)
        end)
        task.delay(0.25, function() --[[ Line: 94 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u28
                [3] = u24
                [4] = u25
            --]]
            u34:Disconnect()
            u28:Destroy()
            u24:Destroy()
            u25:Destroy()
        end)
        _G.PlaySound(p18.Head, script["Audio/Scythe2Dash"])
    end
end
return v2