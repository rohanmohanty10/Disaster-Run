 

local v1 = game:GetService("RunService")
local u2 = game.ReplicatedStorage.Refrences.Fishman
local u3 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Tween)
local u4 = workspace:WaitForChild("Effects")
local u5 = workspace.CurrentCamera
local u6 = {}
v1:BindToRenderStep(script.Parent.Name .. "-" .. script.Name, Enum.RenderPriority.Last.Value - 1000, function(p7) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u3
    --]]
    local v8 = tick()
    local v9 = u5.CFrame.LookVector
    local v10 = 0
    for v11, u13 in next, u6 do
        if v10 > 0 then
            local u13 = u6[v11 - v10]
        end
        local v14 = v8 - u13.Start
        local v15 = (CFrame.new(Vector3.new(), v9) + u13.CFrame.p) * (u13.CFrame - u13.CFrame.p)
        if u13.FadeIn + u13.FadeOut + u13.Lifetime < v14 then
            spawn(function() --[[ Line: 22 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13:Destroy()
            end)
            table.remove(u6, v11 - v10)
            v10 = v10 + 1
        elseif u13.FadeIn + u13.Lifetime < v14 then
            local v16 = (v14 - u13.FadeIn - u13.Lifetime) / u13.FadeOut
            local v17 = u3.ease.out.sine(v16, 0, 1, 1)
            local v18 = u3.ease["in"].back(v16, 1, -1, 1)
            for v19, v20 in next, u13.Data do
                v20.Angle = (v20.Angle or 0) + 1.5707963267948966 * u13.Speed * p7 % 6.283185307179586
                if v19 % 2 ~= 0 then
                    ::l13::
                    local v21 = v20.Angle
                    v23 = math.sin(v21)
                    goto l14
                end
                local v22 = v20.Angle
                local v23 = math.cos(v22)
                if not v23 then
                    goto l13
                end
                ::l14::
                if v19 % 2 ~= 0 then
                    ::l16::
                    local v24 = v20.Angle
                    v26 = math.cos(v24)
                    goto l17
                end
                local v25 = v20.Angle
                local v26 = math.sin(v25)
                if not v26 then
                    goto l16
                end
                ::l17::
                local v27 = CFrame.new(Vector3.new(), v20.Rotation:Lerp(Vector3.new(0, 1, 0), v17))
                v20.Part.CFrame = v15 * v27
                v20.Attachment.Position = v20.Offset * (u13.Scale + u13.Scale * 0.5 * v23) * v18
                v20.Beam.Width0 = v20.Unit.X * (u13.Scale + u13.Scale * 1 - u13.Scale * 0.25 * v23) * v18
                v20.Beam.Width1 = v20.Unit.Y * (u13.Scale + u13.Scale * 1 - u13.Scale * 0.25 * v26) * (1 + v17)
                v20.Beam.Transparency = NumberSequence.new(u3.point(u13.Transparency, 1, v17))
            end
        elseif u13.FadeIn < v14 then
            local _ = (v14 - u13.FadeIn) / u13.Lifetime
            for v28, v29 in next, u13.Data do
                v29.Angle = (v29.Angle or 0) + 1.5707963267948966 * u13.Speed * p7 % 6.283185307179586
                if v28 % 2 ~= 0 then
                    ::l24::
                    local v30 = v29.Angle
                    v32 = math.sin(v30)
                    goto l25
                end
                local v31 = v29.Angle
                local v32 = math.cos(v31)
                if not v32 then
                    goto l24
                end
                ::l25::
                if v28 % 2 ~= 0 then
                    ::l27::
                    local v33 = v29.Angle
                    v35 = math.cos(v33)
                    goto l28
                end
                local v34 = v29.Angle
                local v35 = math.sin(v34)
                if not v35 then
                    goto l27
                end
                ::l28::
                local v36 = CFrame.new(Vector3.new(), v29.Rotation)
                v29.Part.CFrame = v15 * v36
                v29.Attachment.Position = v29.Offset * (u13.Scale + u13.Scale * 0.5 * v32)
                v29.Beam.Width0 = v29.Unit.X * (u13.Scale + u13.Scale * 1 - u13.Scale * 0.25 * v32)
                v29.Beam.Width1 = v29.Unit.Y * (u13.Scale + u13.Scale * 1 - u13.Scale * 0.25 * v35)
            end
        else
            local v37 = v14 / u13.FadeIn
            local v38 = u3.ease.out.quad(v37, 0, 1, 1)
            local v39 = u3.ease.out.sine(v37, 0, 1, 1)
            local v40 = u3.ease["in"].quint(v37, 0, 1, 1)
            for v41, v42 in next, u13.Data do
                v42.Angle = (v42.Angle or 0) + 1.5707963267948966 * u13.Speed * p7 % 6.283185307179586
                if v41 % 2 ~= 0 then
                    ::l33::
                    local v43 = v42.Angle
                    v45 = math.sin(v43)
                    goto l34
                end
                local v44 = v42.Angle
                local v45 = math.cos(v44)
                if not v45 then
                    goto l33
                end
                ::l34::
                if v41 % 2 ~= 0 then
                    ::l36::
                    local v46 = v42.Angle
                    v48 = math.cos(v46)
                    goto l37
                end
                local v47 = v42.Angle
                local v48 = math.sin(v47)
                if not v48 then
                    goto l36
                end
                ::l37::
                local v49 = CFrame.new(Vector3.new(), (Vector3.new(0, 1, 0)):Lerp(v42.Rotation, v39))
                v42.Part.CFrame = v15 * CFrame.new(0, -u13.Scale + u13.Scale * v38, 0) * v49
                v42.Attachment.Position = v42.Offset * (u13.Scale + u13.Scale * 0.5 * v45) * v39
                v42.Beam.Width0 = v42.Unit.X * (u13.Scale + u13.Scale * 1 - u13.Scale * 0.25 * v45) * v39
                v42.Beam.Width1 = v42.Unit.Y * (u13.Scale + u13.Scale * 1 - u13.Scale * 0.25 * v48) * v39
                v42.Beam.Transparency = NumberSequence.new(u3.point(1, u13.Transparency, v40))
            end
        end
    end
end)
local u64 = {
    ["new"] = function(p50) --[[ Name: new, Line 86 ]]
        --[[
        Upvalues:
            [1] = u64
        --]]
        local v51 = p50 or {}
        local v52 = {
            ["CFrame"] = v51.CFrame or CFrame.new(),
            ["Scale"] = v51.Scale or 1,
            ["FadeIn"] = v51.FadeIn or 0.5,
            ["FadeOut"] = v51.FadeOut or 0.5,
            ["Lifetime"] = v51.Lifetime or 1,
            ["Speed"] = v51.Speed or 2,
            ["Transparency"] = v51.Transparency or 0.25,
            ["Color"] = v51.Color or Color3.new(1, 1, 1)
        }
        local v53 = {
            ["__index"] = u64
        }
        return setmetatable(v52, v53):__init()
    end,
    ["__init"] = function(p54) --[[ Name: __init, Line 101 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u4
            [3] = u6
        --]]
        if not p54.Reference then
            p54.Reference = u2.Assets.SpikyFoam:Clone()
            p54.Reference:PivotTo(p54.CFrame)
            p54.Reference.Parent = u4
            p54.Data = {}
            local v55 = next
            local v56, v57 = p54.Reference:GetChildren()
            for _, v58 in v55, v56, v57 do
                if v58 ~= p54.Reference.PrimaryPart then
                    local v59 = p54.Data
                    local v60 = {
                        ["Part"] = v58,
                        ["Rotation"] = v58.CFrame.LookVector,
                        ["Beam"] = v58.AuraSpike,
                        ["Attachment"] = v58.Attachment,
                        ["Origin"] = v58.Origin,
                        ["Offset"] = v58.Attachment.Position / 12,
                        ["Unit"] = Vector2.new(v58.AuraSpike.Width0, v58.AuraSpike.Width1) / 12
                    }
                    table.insert(v59, v60)
                end
            end
            for _, v61 in next, p54.Data do
                v61.Part.CFrame = p54.CFrame
                v61.Attachment.Position = v61.Offset * 0
                v61.Beam.Width0 = v61.Unit.X * 0
                v61.Beam.Width1 = v61.Unit.Y * 0
                v61.Beam.Transparency = NumberSequence.new(1)
                v61.Beam.Color = ColorSequence.new(p54.Color:Lerp(Color3.new(1, 1, 1), 0.5), p54.Color)
            end
            p54.Start = tick()
            local v62 = u6
            table.insert(v62, p54)
            return p54
        end
    end,
    ["Destroy"] = function(p63) --[[ Name: Destroy, Line 141 ]]
        p63.Reference:Destroy()
    end
}
return u64