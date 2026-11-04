 

local v1 = {}
local u2 = game:GetService("RunService").Heartbeat
function v1.start(_, p3, u4) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u5 = p3.LowerTorso
    local u6 = p3.Head
    local u7 = 0
    spawn(function() --[[ Line: 16 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u7
            [4] = u4
        --]]
        while true do
            local v8 = (u5.Position - u6.Position).Magnitude
            local v9 = Vector3.new(1, 1, 1) * (math.clamp(v8, 0, 8) * 2)
            if u7 == 0 then
                u7 = v9.X
            end
            if u4.Size ~= v9 then
                u4.Size = v9
                u7 = v9.X
            end
            game["Run Service"].Heartbeat:Wait()
            if u4:IsDescendantOf(workspace) == false then
                return
            end
        end
    end)
    _G.PlaySound(u4, script.Expand)
    local u10 = script.wooshy:Clone()
    u10:PivotTo(p3.HumanoidRootPart.CFrame)
    _G.destroy(u10, 1)
    u10.Parent = workspace.Effects
    task.spawn(function() --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u2
        --]]
        local v11 = u10.SwooshA
        local v12 = u10.SwooshB
        local v13 = u10.SwooshC
        for v14 = 0, 1.2, 0.05 do
            v11.Mesh.Scale = v11.Mesh.Scale + Vector3.new(0.8, 0.8, 0.8)
            v12.Mesh.Scale = v11.Mesh.Scale + Vector3.new(1, 1, 1)
            v13.Mesh.Scale = v11.Mesh.Scale + Vector3.new(0.3, 0.5, 0.2)
            v11.Decal.Transparency = v14
            v12.Decal.Transparency = v14
            v13.Decal.Transparency = v14
            v11.CFrame = v11.CFrame * CFrame.Angles(0, 0.4, 0)
            v12.CFrame = v12.CFrame * CFrame.Angles(0, -0.3, 0)
            v13.CFrame = v13.CFrame * CFrame.Angles(0, 0.7, 0)
            u2:Wait()
        end
    end)
    local v15 = u4.CFrame
    _G.PlayEffect("Spheres", nil, {
        ["cf"] = v15,
        ["ti"] = 0.25,
        ["ti2"] = 0.1,
        ["range"] = 20,
        ["minThick"] = 5,
        ["maxThick"] = 10,
        ["part"] = u4,
        ["color"] = Color3.fromRGB(255, 255, 255),
        ["am"] = 15
    })
end
return v1