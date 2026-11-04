 

local u1 = workspace.Effects
local u2 = require(script.Info)
local u3 = _G.tween
return function(p4) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u2
    --]]
    local _, v5, v6 = _G.getRayFloor(p4, 8)
    local v7 = v5 + Vector3.new(0, 0.1, 0)
    local v8 = CFrame.new(v7, v7 + v6) * CFrame.Angles(1.5707963267948966, 0, 0)
    _G.PlaySound(v8, script.GoldTrap)
    local v9 = script.main:Clone()
    v9.Parent = u1
    v9.CFrame = v8
    _G.customEmit(v9.Emit)
    _G.destroy(v9, 3)
    local u10 = script.Solid:Clone()
    u10.Parent = u1
    u10.CFrame = v8
    u3(u10.Mesh, {
        1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["Scale"] = u10.Mesh.Scale * 7.5
    })
    _G.destroy(u10, 3.45)
    task.spawn(function() --[[ Line: 45 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u10
        --]]
        for _, v11 in u2.SolidMesh do
            u10.Decal.Texture = v11
            game["Run Service"].Heartbeat:Wait()
        end
    end)
    u10.Decal.Transparency = 1
end