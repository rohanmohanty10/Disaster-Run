 

return {
    ["start"] = function(_, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v13 = script.BeamShock:Clone()
            v13.Parent = workspace.Effects
            v13.CFrame = p1
            _G.destroy(v13, p4 + 0.1)
            local v14 = v13.Attachment11
            local v15 = v13.Attachment21
            local v16 = p2 / 4
            local v17 = -p3 / 4
            v14.Position = Vector3.new(0, v16, v17)
            local v18 = p2 / 4
            local v19 = p3 / 4
            v15.Position = Vector3.new(0, v18, v19)
            local v20 = p3 / 2
            v13.Beam.CurveSize0 = -v20 / 4
            v13.Beam.CurveSize1 = v20 / 4
            v13.Beam.Width0 = p6
            v13.Beam.Width1 = p7
            if p5 then
                v13.Beam.Color = p5
                v13.Beam2.Color = p5
            end
            if p12 then
                v13.Beam.TextureSpeed = p12
                v13.Beam2.TextureSpeed = p12
            end
            if p9 then
                v13.Beam.Texture = p9
                v13.Beam2.Texture = p9
            end
            if p11 then
                v13.Beam.TextureLength = p11
                v13.Beam2.TextureLength = p11
            end
            if p10 then
                v13.Beam.Transparency = p10
                v13.Beam2.Transparency = p10
            end
            if p8 then
                v13.Beam.LightEmission = p8
                v13.Beam2.LightEmission = p8
            end
            v13.Beam.LightInfluence = 0
            v13.Beam2.LightInfluence = 0
            v13.Beam2.CurveSize0 = v20 / 4
            v13.Beam2.CurveSize1 = -v20 / 4
            v13.Beam2.Width0 = p6
            v13.Beam2.Width1 = p7
            local v21 = _G.tween
            local v22 = {
                p4,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v23 = {}
            local v24 = -p3
            v23.Position = Vector3.new(0, p2, v24)
            v21(v14, v22, v23)
            _G.tween(v15, {
                p4,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Position"] = Vector3.new(0, p2, p3)
            })
            _G.tween(v13.Beam, {
                p4,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CurveSize0"] = -v20,
                ["CurveSize1"] = v20,
                ["Width0"] = 0,
                ["Width1"] = 0
            })
            _G.tween(v13.Beam2, {
                p4,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CurveSize0"] = v20,
                ["CurveSize1"] = -v20,
                ["Width0"] = 0,
                ["Width1"] = 0
            })
        end
    end
}