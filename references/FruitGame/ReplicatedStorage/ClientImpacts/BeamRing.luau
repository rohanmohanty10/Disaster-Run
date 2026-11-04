 

local v1 = {}
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Sparks]
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.RockDebs]
function v1.start(_, p2) --[[ Line: 6 ]]
    local v3 = p2.cf
    local v4 = p2.dam
    local v5 = p2.ti
    local v6 = p2.ti2
    local v7 = p2.rot
    local v8 = p2.color
    local v9 = p2.le
    local v10 = p2.width
    local v11 = p2.rotmulti
    local v12 = v11 == nil and 1 or v11
    if _G.checkRenderDistance(v3.p) ~= false then
        local u13 = script.BeamRing:Clone()
        u13.Parent = workspace.Effects
        if v10 == nil then
            v10 = math.random(50, 100) / 100
        end
        local v14 = 1.3333333333333333 * (v4 / 2) * 0.41421356237309503
        local v15 = v4 / 2
        local v16 = Vector3.new(0, 0, v15)
        local v17 = -v4 / 2
        local v18 = Vector3.new(v17, 0, 0)
        local v19 = -v4 / 2
        local v20 = Vector3.new(0, 0, v19)
        u13.Beam.CurveSize0 = 0
        u13.Beam.CurveSize1 = 0
        u13.Beam.Width0 = v10
        u13.Beam.Width1 = v10
        u13.Beam2.CurveSize0 = 0
        u13.Beam2.CurveSize1 = 0
        u13.Beam2.Width0 = v10
        u13.Beam2.Width1 = v10
        u13.CFrame = v3
        if v8 then
            u13.Beam.Color = v8
            u13.Beam2.Color = v8
        end
        if v9 then
            u13.Beam.LightEmission = v9
            u13.Beam2.LightEmission = v9
        end
        local v21 = Enum.EasingStyle.Sine
        if v5 > 0 then
            _G.tween(u13.A1, {
                v5,
                v21,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Position"] = v16
            })
            _G.tween(u13.A2, {
                v5,
                v21,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Position"] = v18
            })
            _G.tween(u13.A3, {
                v5,
                v21,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Position"] = v20
            })
            _G.tween(u13.Beam, {
                v5,
                v21,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CurveSize0"] = v14,
                ["CurveSize1"] = v14
            })
            _G.tween(u13.Beam2, {
                v5,
                v21,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CurveSize0"] = v14,
                ["CurveSize1"] = v14
            })
        else
            u13.A1.Position = v16
            u13.A2.Position = v18
            u13.A3.Position = v20
            u13.Beam.CurveSize0 = v14
            u13.Beam2.CurveSize0 = v14
            u13.Beam.CurveSize1 = v14
            u13.Beam2.CurveSize1 = v14
        end
        local v22 = (v7 == "x" and Vector3.new(360, 0, 0) or (v7 == "y" and Vector3.new(0, 360, 0) or (v7 == "z" and Vector3.new(0, 0, 360) or Vector3.new(0, 0, 0)))) * v12
        _G.tween(u13, {
            2,
            v21,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Orientation"] = u13.Orientation + v22
        })
        local u23 = Instance.new("NumberValue", game.ReplicatedStorage)
        u23.Value = 0
        u23.Changed:Connect(function() --[[ Line: 81 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u13
            --]]
            local v24 = u23.Value
            u13.Beam.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1, 0),
                NumberSequenceKeypoint.new(0.2, 1, 0),
                NumberSequenceKeypoint.new(0.3, v24, 0),
                NumberSequenceKeypoint.new(1, v24, 0)
            })
            u13.Beam2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, v24, 0), NumberSequenceKeypoint.new(0.75, 1, 0), NumberSequenceKeypoint.new(1, 1, 0) })
        end)
        _G.tween(u23, {
            v6,
            v21,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Value"] = 1
        })
        _G.destroy(u23, v6)
        _G.destroy(u13, v6)
    end
end
return v1