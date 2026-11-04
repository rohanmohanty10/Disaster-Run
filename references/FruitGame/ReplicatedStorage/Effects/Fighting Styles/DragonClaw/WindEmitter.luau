 

game:GetService("ReplicatedStorage")
local u1 = game:GetService("RunService")
game:GetService("Debris")
local u2 = game:GetService("TweenService")
local u3 = {}
u3.__index = u3
local u4 = Random.new()
function u3.new(p5, p6, p7) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v8 = {
        ["lifetime"] = p7.lifetime,
        ["scale"] = p7.scale or 1,
        ["scaleEnvelope"] = p7.scaleEnvelope or 0,
        ["rate"] = p7.rate,
        ["acceleration"] = p7.acceleration,
        ["accelerationEnvelope"] = p7.accelerationEnvelope or Vector3.new(0, 0, 0),
        ["goalTransparency"] = p7.goalTransparency,
        ["cFrameOffset"] = p7.cFrameOffset or CFrame.new(0, 0, 0),
        ["attachment"] = p6,
        ["part"] = p5,
        ["_counter"] = 0
    }
    local v9 = u3
    return setmetatable(v8, v9)
end
function u3.Enable(u10) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if not u10._connection then
        u10._connection = u1.Heartbeat:Connect(function(p11) --[[ Line: 33 ]]
            --[[
            Upvalues:
                [1] = u10
            --]]
            local v12 = u10
            v12._counter = v12._counter + p11
            if u10._counter > u10.rate then
                u10._counter = 0
                u10:Emit()
            end
        end)
    end
end
function u3._emitOnce(u13) --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    task.spawn(function() --[[ Line: 44 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u13
            [3] = u2
        --]]
        local v14 = u4:NextNumber(u13.lifetime.Min, u13.lifetime.Max)
        local v15 = {
            ["fadeIn"] = 0.4,
            ["fadeOut"] = 0.6
        }
        local v16 = u13.part:Clone()
        v16.Parent = workspace.Effects
        v16.Decal.Transparency = 1
        local v17 = u13.attachment.CFrame * u13.cFrameOffset
        local v18 = CFrame.Angles
        local v19 = u4:NextNumber(0, 360)
        v16.CFrame = v17 * v18(0, math.rad(v19), 0)
        local v20 = u4:NextNumber(-0.15, 0.15)
        local v21 = v16.Mesh
        local v22 = u13.scale * v16.Mesh.scale
        local v23 = u4:NextNumber(-0.15, 0.15)
        v21.Scale = v22 + Vector3.new(v20, v23, v20) * u13.scale
        local v24 = TweenInfo.new(v14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v25 = TweenInfo.new(v14 * v15.fadeIn, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v26 = TweenInfo.new(v14 * v15.fadeOut, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v27 = CFrame.new
        local v28 = u13.acceleration
        local v29 = u4:NextNumber(-u13.accelerationEnvelope.X, u13.accelerationEnvelope.X)
        local v30 = u4:NextNumber(-u13.accelerationEnvelope.Y, u13.accelerationEnvelope.Y)
        local v31 = u4
        local v32 = -u13.accelerationEnvelope.Z
        local v33 = u13.accelerationEnvelope.Z
        local v34 = v27(v28 + Vector3.new(v29, v30, v31:NextNumber(v32, v33)))
        u2:Create(v16, v24, {
            ["CFrame"] = v16.CFrame * v34 * CFrame.Angles(0, -1.7453292519943295, 0)
        }):Play()
        u2:Create(v16.Mesh, v24, {
            ["Scale"] = v16.Mesh.Scale + Vector3.new(0.25, 0.25, 0.25) * (u13.scale + u4:NextNumber(-u13.scaleEnvelope, u13.scaleEnvelope))
        }):Play()
        u2:Create(v16.Decal, v25, {
            ["Transparency"] = u13.goalTransparency
        }):Play()
        task.wait(v14 * v15.fadeIn)
        u2:Create(v16.Decal, v26, {
            ["Transparency"] = 1
        }):Play()
        _G.destroy(v16, 2)
    end)
end
function u3.Emit(p35, p36) --[[ Line: 74 ]]
    if p36 then
        for _ = 1, p36 do
            p35:_emitOnce()
        end
    else
        p35:_emitOnce()
    end
end
function u3.Destroy(p37) --[[ Line: 84 ]]
    p37._connection:Disconnect()
end
return u3