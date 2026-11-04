 

local v1 = game:GetService("RunService")
local u2 = workspace:WaitForChild("Effects")
local u3 = script.Parent.Parent.Assets
local _ = workspace.CurrentCamera
local u4 = require(game.ReplicatedStorage.Util.Tween)
local u5 = require(script.Data)
local u6 = {}
v1:BindToRenderStep(script.Parent.Name .. "-" .. script.Name, Enum.RenderPriority.Last.Value - 1000, function(p7) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
    --]]
    local v8 = tick()
    for _, v9 in next, u6 do
        local v10 = (v8 - v9.Start) / v9.Duration
        local v11 = math.min(1, v10)
        v9.Angle = v9.Angle + 6.283185307179586 * p7
        local v12 = u4.ease.out.quad(v11, 0, 1, 1)
        local v13 = u4.ease["in"].cubic(v11, 0, 1, 1)
        local v14 = u4.ease.inout.quad(v11, 0, 1, 1)
        local v15 = v9.Scale * v12
        local v16 = CFrame.new():Lerp(v9.Offset, v13)
        for _, v17 in next, v9.ReferenceData do
            local v18 = v17.Size / v9.ModelScale
            if v17.Part:IsA("MeshPart") then
                v17.Part.Size = v18 * v15
                v17.Part.Transparency = u4.point(v17.Transparency + v9.Transparency, 1, v14)
                v17.Part.CFrame = v9.CFrame * v17:CalculateOffset(v15 / v9.ModelScale)
            end
        end
        if not v9.LastCFrame then
            v9.LastCFrame = CFrame.new()
        end
        local v19 = v9.Anchor and CFrame.new(v9.Anchor.CFrame.p) or v9.CFrame
        if v11 > 0.5 then
            v19 = v9.LastCFrame or v19
        end
        v9.LastCFrame = v19
        v9.Reference:PivotTo((v9.Anchor and v9.Anchor.CFrame or v9.CFrame) * v16 * CFrame.Angles(0, v9.Angle * v9.RotationDirection, 0) * v9.ModelOffset)
        if v11 == 1 then
            v9:Destroy()
        end
    end
end)
local u50 = {
    ["new"] = function(p20, p21) --[[ Name: new, Line 51 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u50
        --]]
        local v22 = {
            ["ID"] = p20 or (p21.id or 1)
        }
        local v23 = u5[v22.ID]
        v22.ModelScale = v23.Scale or 1
        v22.ModelOffset = v23.Offset or CFrame.new()
        v22.Offset = p21.Offset or CFrame.new()
        v22.Anchor = p21.Anchor
        v22.CFrame = p21.CFrame or CFrame.new()
        v22.Scale = p21.Scale or 1
        v22.Duration = p21.Duration or 1
        v22.Color = p21.Color or Color3.new(1, 1, 1)
        v22.Accent = p21.Accent or v22.Color
        v22.RotationDirection = p21.RotationDirection or 1
        v22.Transparency = p21.Transparency or 0.1
        local v24 = {
            ["__index"] = u50
        }
        return setmetatable(v22, v24):__init()
    end,
    ["__init"] = function(p25) --[[ Name: __init, Line 73 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        if p25.Reference then
            return p25
        end
        p25.Angle = 0
        p25.Reference = u3.Slashes:FindFirstChild(p25.ID):Clone()
        p25.ReferenceData = {}
        local u26 = p25.Reference.PrimaryPart.CFrame
        local v27 = next
        local v28, v29 = p25.Reference:GetChildren()
        for _, v30 in v27, v28, v29 do
            local v31 = v30.Name:find("2") and p25.Accent or p25.Color
            local v32 = p25.ReferenceData
            local v47 = {
                ["Part"] = v30,
                ["Size"] = v30.Size,
                ["CFrame"] = v30.CFrame,
                ["Transparency"] = v30.Transparency,
                ["CalculateOffset"] = function(p33, p34) --[[ Name: CalculateOffset, Line 93 ]]
                    --[[
                    Upvalues:
                        [1] = u26
                    --]]
                    local v35, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45, v46 = p33.CFrame:ToObjectSpace(u26):inverse():components()
                    return CFrame.new(v35 * p34, v36 * p34, v37 * p34, v38, v39, v40, v41, v42, v43, v44, v45, v46)
                end
            }
            table.insert(v32, v47)
            v30.Size = v30.Size * 0
            v30.Color = v31
            if v30:IsA("MeshPart") then
                v30.Transparency = 0
            else
                v30.Transparency = 1
            end
        end
        return p25
    end,
    ["Emit"] = function(p48) --[[ Name: Emit, Line 112 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u6
        --]]
        p48.Reference:PivotTo(p48.CFrame * p48.ModelOffset)
        p48.Reference.Parent = u2
        p48.Start = tick()
        u6[p48] = p48
    end,
    ["Destroy"] = function(p49) --[[ Name: Destroy, Line 119 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        p49.Reference:Destroy()
        u6[p49] = nil
    end
}
return u50