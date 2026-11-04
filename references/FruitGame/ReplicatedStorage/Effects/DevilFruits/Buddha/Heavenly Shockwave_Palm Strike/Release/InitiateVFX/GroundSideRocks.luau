 

local u1 = _G.Ess.Tween
local v2 = {}
local v3 = {
    [true] = {
        ["Rate"] = 0.08333333333333333,
        ["ScaleMult"] = 1.5,
        ["Offset"] = 15,
        ["Height"] = 9
    },
    [false] = {
        ["Rate"] = 0.03333333333333333,
        ["ScaleMult"] = 0.8,
        ["Offset"] = 10,
        ["Height"] = 6
    }
}
v2[true] = v3
v2[false] = {
    ["Rate"] = 0.013333333333333334,
    ["ScaleMult"] = 0.45,
    ["Offset"] = 8,
    ["Height"] = 6
}
function v2.Create(p4, p5, p6, p7, u8) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    for _ = 1, 2 do
        local v9 = Random.new()
        CFrame.fromAxisAngle(v9:NextUnitVector() * 12, v9:NextNumber(0, 1))
        local u10 = script.RockModel:Clone()
        u10:ScaleTo(p7)
        u10:PivotTo(p4 * CFrame.new(p5, 0, 0) * CFrame.Angles(0, 1.5707963267948966 * math.sign(p5), 0) * p6)
        local v11, _, _ = _G.getRayFloor(u10:GetPivot() + Vector3.new(0, 3, 0), 10)
        u10.Parent = workspace.Effects
        for _, u12 in u10:GetDescendants() do
            if u12:IsA("BasePart") then
                if v11 then
                    _G.matchMaterial(u12, v11)
                end
                u1(u12, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    ["CFrame"] = u12.CFrame + Vector3.new(0, 4, 0)
                })
                task.delay(0.5, function() --[[ Line: 61 ]]
                    --[[
                    Upvalues:
                        [1] = u1
                        [2] = u12
                        [3] = u8
                    --]]
                    u1(u12, TweenInfo.new(u8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["CFrame"] = u12.CFrame - Vector3.new(0, 15, 0)
                    })
                end)
            end
        end
        task.delay(u8 + 0.8, function() --[[ Line: 70 ]]
            --[[
            Upvalues:
                [1] = u10
            --]]
            u10:Destroy()
        end)
        p5 = -p5
    end
end
return v2