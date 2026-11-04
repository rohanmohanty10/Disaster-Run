 

local v1 = {}
function recurse_bones(p2, p3)
    for _, v4 in p2:GetChildren() do
        local v5 = v4:GetAttribute("OrigPos")
        if v5 then
            v4.CFrame = CFrame.new(v5) * p3
            recurse_bones(v4, p3)
        end
    end
end
function add_length(p6, p7, p8)
    if p8 <= 4 then
        add_length(p6:FindFirstChildOfClass("Bone"), p7, p8 + 1)
        if p8 > 0 then
            p6.CFrame = p6.CFrame * CFrame.new(0, p7, 0)
        end
    end
end
function set_cf(p9, p10, p11)
    if p11 <= 5 then
        set_cf(p9:FindFirstChildOfClass("Bone"), p10, p11 + 1)
        if p11 > 0 then
            p9.CFrame = p10
        end
    end
end
function v1.start(_, p12, _) --[[ Line: 33 ]]
    if _G.checkRenderDistance(p12.HumanoidRootPart.Position) then
        local v13 = p12:FindFirstChild("mArm")
        if v13 then
            local v14 = v13.Value
            local v15 = v14.RootPart.MochiArmJoints
            local v16 = game:GetService("RunService").Heartbeat
            local v17 = 0
            while v17 < 0.5 do
                local v18 = v17 * 2 * 3
                set_cf(v15, CFrame.new(0, v18 + 2, 0) * CFrame.Angles(v18 * 0.18, v18 * -0.02, 0), -1)
                v17 = v17 + v16:Wait()
            end
            local v19 = v17 - 0.5
            while v19 < 1.75 do
                local v20 = v19 * 0.571428571 - 1
                local v21 = (1 - v20 * v20 * v20 * v20) * 3
                set_cf(v15, CFrame.new(0, 5 + v21, 0) * CFrame.Angles((3 - v21) * 0.18, (3 - v21) * -0.02, 0), -1)
                v19 = v19 + v16:Wait()
            end
            local v22 = v19 - 1.75
            while v22 < 0.6 do
                local v23 = v22 * 1.6666666667
                local v24 = v23 * v23
                local v25 = 4 * (v23 - 1)
                local v26 = v24 * math.exp(v25)
                set_cf(v15, CFrame.new(0, 8 - v26 * 9, 0), -1)
                v22 = v22 + v16:Wait()
            end
            v14.Dough.Transparency = 1
            v14.Haki.Transparency = 1
        end
    else
        return
    end
end
return v1