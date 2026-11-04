 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.FastWait)
local function u16(p3, p4, p5, p6, p7, p8) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u9 = script.floor:Clone()
    local v10 = math.random(p3, p4)
    local v11 = math.random(350, 425) / 1000
    u9.Size = Vector3.new(v10, v11, v10)
    u9.Name = "iceFloor"
    if p7 then
        u9.CFrame = p7
    else
        u9.CFrame = CFrame.new(p5, p5 + p6) * CFrame.Angles(-1.5707963267948966, 0, 0)
    end
    local v12 = u9.CFrame
    local v13 = CFrame.Angles
    local v14 = math.random(-360, 360)
    u9.CFrame = v12 * v13(0, math.rad(v14), 0)
    u9.Sound.Pitch = math.random(100, 120) / 100
    u9.Parent = workspace.Env
    u9.Sound:Play()
    _G.customEmit(u9.sm2)
    u9.CollisionGroup = "waterLogia"
    spawn(function() --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        task.wait(0.25)
        u9.sm3.Enabled = false
    end)
    local u15 = p8 == nil and 2 or p8
    task.spawn(function() --[[ Line: 31 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u15
            [3] = u9
        --]]
        u2(u15)
        _G.tween(u9, {
            0.5,
            "Smooth",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(u9, 0.5)
    end)
    return u9
end
local u17 = workspace.Env.WaterStuff.Falls.Position.Y + 0.125
function v1.start(_, p18, p19, p20, p21, p22, p23) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u16
    --]]
    if _G.checkRenderDistance(p18.Position) == false then
        return
    else
        local v24 = CFrame.new(p18.Position)
        local v25 = Ray.new(v24.Position, v24.upVector * -p19)
        local v26, v27, v28 = _G.raycastWhitelist(v25, { workspace.Islands, workspace.Ships, workspace.Env })
        if v26 and (v26.Name ~= "iceFloor" or p22 ~= nil) and (u17 < v27.Y or v27.Y < workspace.Env.WaterStuff.Sand.Position.Y) then
            local v29 = u16(p20, p21, v27, v28, nil, p23)
            if v26.CanCollide == true then
                v29.CanCollide = false
            else
                v29.CanCollide = true
            end
        else
            if v27.Y <= u17 and v27.Y > workspace.Env.WaterStuff.Sand.Position.Y then
                local v30 = CFrame.new(v27.X, u17 + 5, v27.Z)
                local v31 = Ray.new(v30.Position, v30.upVector * -6)
                local v32, v33, _ = _G.raycastWhitelist(v31, { workspace.Islands, workspace.Ships, workspace.Env })
                if v32 == nil then
                    u16(p20, p21, nil, nil, CFrame.new(v33.X, u17, v33.Z), p23)
                end
            end
            return
        end
    end
end
return v1