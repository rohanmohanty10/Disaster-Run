 

require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(game:GetService("ReplicatedStorage").Modules.LightningBolt)
local _ = workspace.CurrentCamera
game:GetService("RunService")
local u1 = game:GetService("RunService")
function playFlipbook(p2, p3)
    --[[
    Upvalues:
        [1] = u1
    --]]
    for v4 = 1, #p3:GetChildren() do
        p2.Texture = p3[v4].Texture
        u1.Heartbeat:Wait()
    end
end
function ScaleParticle(p5, p6, p7)
    p5.Speed = NumberRange.new(p6.Speed.Min * p7, p6.Speed.Max * p7)
    p5.Drag = p6.Drag * p7
    p5.Acceleration = p6.Acceleration * p7
    local v8 = {}
    for v9, v10 in pairs(p6.Size.Keypoints) do
        v8[v9] = NumberSequenceKeypoint.new(v10.Time, v10.Value * p7, v10.Envelope * p7)
    end
    p5.Size = NumberSequence.new(v8)
end
function dohit(p11, u12, p13, u14)
    local u15 = script.Hit:Clone()
    if u14 == false then
        u15.PointLight.Color = Color3.new(1, 1, 1)
    end
    local v16 = CFrame.Angles
    local v17 = p13 - 179
    u15.CFrame = p11 * v16(0, math.rad(v17), 0) * CFrame.new(0, 0, -5.25 * u12) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
    u15.Parent = workspace.Effects
    task.spawn(function() --[[ Line: 74 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u14
            [3] = u12
        --]]
        task.wait(0.075)
        for _, v18 in pairs(u15.Attachment:GetChildren()) do
            if u14 == false and v18.Name:lower():sub(1, 5) ~= "black" then
                v18.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                v18.Brightness = v18.Brightness * 0.25
            end
            ScaleParticle(v18, v18, u12 - 0.5)
            _G.customEmit(v18)
        end
        _G.tween(u15.PointLight, {
            0.3,
            "Quad",
            Enum.EasingDirection.Out,
            true,
            0
        }, {
            ["Brightness"] = 2
        })
    end)
    _G.destroy(u15, 3)
end
function slash(p19, p20, p21, p22)
    local v23 = script.Slash:Clone()
    v23.CFrame = p19 * CFrame.Angles(0, 1.9198621771937625, 0)
    v23.Parent = workspace.Effects
    local v24 = v23.Mesh
    v24.Scale = v24.Scale * p20
    if p22 == false then
        v23.Colored.Color3 = Color3.fromRGB(350, 350, 350)
    end
    _G.tween(v23, { 0.55, "Quart", Enum.EasingDirection.Out }, {
        ["CFrame"] = v23.CFrame * CFrame.Angles(0, math.rad(p21), 0)
    })
    _G.tween(v23.Colored, { 0.3, "Sine", Enum.EasingDirection.Out }, {
        ["Transparency"] = 1
    })
    _G.tween(v23.Black, { 0.45, "Linear", Enum.EasingDirection.In }, {
        ["Transparency"] = 1
    })
    _G.tween(v23.Mesh, { 0.6, "Sine", Enum.EasingDirection.Out }, {
        ["Scale"] = v23.Mesh.Scale + Vector3.new(1, -10, 1)
    })
    _G.destroy(v23, 1)
    dohit(p19, p20, p21, p22)
end
function aslash(p25, p26, p27, p28)
    local u29 = script.FlipbookSlash:clone()
    local v30 = u29.Mesh
    v30.Scale = v30.Scale * p26
    u29.CFrame = p25 * CFrame.Angles(0, 3.6651914291880923, 0)
    u29.Parent = workspace.Effects
    dohit(p25, p26, p27, p28)
    _G.tween(u29, { 1, "FabricDecelerate", Enum.EasingDirection.In }, {
        ["CFrame"] = u29.CFrame * CFrame.Angles(0, math.rad(p27), 0)
    })
    _G.tween(u29.Mesh, { 1, "Sine", Enum.EasingDirection.Out }, {
        ["Scale"] = Vector3.new(9, 3.15, 9) * p26
    })
    _G.tween(u29.PointLight, { 1, "Sine", Enum.EasingDirection.Out }, {
        ["Brightness"] = 0
    })
    task.spawn(function() --[[ Line: 122 ]]
        --[[
        Upvalues:
            [1] = u29
        --]]
        playFlipbook(u29.Decal, script.Flipbook)
        u29:Destroy()
    end)
end
return {
    ["start"] = function(_, p31, u32) --[[ Name: start, Line 8 ]]
        if _G.checkRenderDistance(p31.PrimaryPart.Position) ~= false then
            local u33 = p31.HumanoidRootPart
            task.spawn(function() --[[ Line: 14 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u32
                --]]
                task.wait(0.3)
                local v34 = CFrame.new(-0.375041962, 0.500095367, -0.462486267, 0.526540399, -0.573576748, -0.627506971, 0.368688524, 0.819151878, -0.439384907, 0.766044497, -6.81750805e-7, 0.642787695) * CFrame.Angles(0, 1.3089969389957472, 0)
                slash(u33.CFrame * v34, 1, 179, u32)
                _G.PlaySound(u33.CFrame * v34, script.DragonSlash1)
            end)
            task.spawn(function() --[[ Line: 22 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u32
                --]]
                task.wait(0.7)
                local v35 = CFrame.new(-0.375022888, 0.500106812, -0.462471008, -0.409194916, 0.905838907, 0.109619826, -0.906636357, -0.417180836, 0.0630106926, 0.102808788, -0.0736017972, 0.991974711) * CFrame.Angles(0, 1.5707963267948966, 0)
                slash(u33.CFrame * v35, 1, 100, u32)
                _G.PlaySound(u33.CFrame * v35, script.DragonSlash2)
            end)
            task.wait(1.0666666666666667)
            local u36 = CFrame.new(0.28163147, 0.264499664, -0.520072937, -0.903266728, -0.409347415, -0.128622085, 0.386800915, -0.906572044, 0.168854624, -0.185725346, 0.102769583, 0.977212787) * CFrame.Angles(0, 0.5235987755982988, 0)
            _G.PlaySound(u33.CFrame * u36, script.DragonSlash3)
            task.spawn(function() --[[ Line: 35 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u36
                    [3] = u32
                --]]
                slash(u33.CFrame * u36 * CFrame.new(0, 1.5, 0), 1.1, 160, u32)
            end)
            task.spawn(function() --[[ Line: 38 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u36
                    [3] = u32
                --]]
                slash(u33.CFrame * u36, 1.3, 160, u32)
            end)
            task.spawn(function() --[[ Line: 41 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u36
                    [3] = u32
                --]]
                slash(u33.CFrame * u36 * CFrame.new(0, -1.5, 0), 1.1, 160, u32)
            end)
        end
    end
}