 

local v1 = {}
function ConnectPoints(p2, p3, p4, p5)
    local v6 = Instance.new("Part")
    local v7 = (p3 - p2).magnitude
    v6.Anchored = true
    v6.CanCollide = false
    v6.TopSurface = "Smooth"
    v6.BottomSurface = "Smooth"
    v6.Material = Enum.Material.Neon
    v6.Color = p5
    v6.Size = Vector3.new(p4, v7, p4)
    v6.CFrame = CFrame.new(p2, p3) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -v7 / 2, 0)
    return v6
end
function TraceLine(p8, p9, p10, p11)
    local v12 = { p8 }
    local v13 = (p9 - p8).magnitude
    local v14 = math.random(4, 8)
    local v15 = p10.X
    local v16 = math.modf(v15)
    local v17 = p10.Y
    local v18 = math.modf(v17)
    local v19 = p10.Z
    local v20 = math.modf
    local v21 = Vector3.new(v16, v18, v20(v19))
    local v22 = p11.X
    local v23 = math.modf(v22)
    local v24 = p11.Y
    local v25 = math.modf(v24)
    local v26 = p11.Z
    local v27 = math.modf
    local v28 = Vector3.new(v23, v25, v27(v26))
    local v29, v30
    if v13 < v28.Z or (v13 < v21.Z or (v21.Z <= 0 or v28.Z <= 0)) then
        v29 = v13
        v30 = false
    else
        v29 = v13
        v30 = true
    end
    while v13 > 0 do
        local v31 = math.random(v21.X, v28.X)
        local v32 = math.random(v21.Y, v28.Y)
        local v33
        if v30 then
            local v34 = math.random(v21.Z, v28.Z)
            v33 = v13 - v34 > 0 and v34 and v34 or (p9 - v12[#v12]).magnitude
        else
            v33 = v29 / v14
        end
        v13 = v13 - v33
        if v13 <= 0 then
            break
        end
        local v35 = (CFrame.new(v12[#v12], p9) * CFrame.new(v31, v32, -v33)).p
        table.insert(v12, v35)
    end
    table.insert(v12, p9)
    return v12
end
function v1.Fire(_, _, p36, p37, p38, p39, _, _, _, _, _) --[[ Line: 69 ]]
    return TraceLine(p36, p37, p38, p39)
end
return v1