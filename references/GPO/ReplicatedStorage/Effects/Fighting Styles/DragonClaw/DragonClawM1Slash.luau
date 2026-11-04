 

local u1 = script
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("RunService")
local _ = workspace.Effects
game:GetService("Debris")
local u4 = game:GetService("TweenService")
require(v2.Modules.EffectsUtil)
Random.new()
function doSlash(u5, u6, u7, p8)
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local u9 = u1.Slash:Clone()
    u9.Parent = workspace.Effects
    if p8 == false then
        u9.Colored.Color3 = Color3.fromRGB(500, 500, 500)
        u9.Black.Transparency = 0
    end
    local u10 = 0
    local u11 = nil
    u11 = u3.Heartbeat:Connect(function(p12) --[[ Line: 23 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u11
            [3] = u4
            [4] = u9
            [5] = u6
            [6] = u7
            [7] = u5
        --]]
        u10 = u10 + p12
        if u10 > 0.3 then
            u11:Disconnect()
        else
            local v13 = u4:GetValue(u10 / 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            local v14 = u9
            local v15 = u6.CFrame * u7
            local v16 = CFrame.Angles
            local v17 = u5 * v13
            v14.CFrame = v15 * v16(0, math.rad(v17), 0)
        end
    end)
    _G.tween(u9.Colored, { 0.15, "Sine", Enum.EasingDirection.Out }, {
        ["Transparency"] = 1
    })
    _G.tween(u9.Black, { 0.3, "Sine", Enum.EasingDirection.Out }, {
        ["Transparency"] = 1
    })
    _G.tween(u9.Mesh, { 0.6, "Sine", Enum.EasingDirection.Out }, {
        ["Scale"] = u9.Mesh.Scale + Vector3.new(1, -10, 1)
    })
    _G.destroy(u9, 1)
end
function tweenCFrame(u18, u19, u20, u21, u22, u23, u24)
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local u25 = 0
    local u26 = nil
    u26 = u3.Heartbeat:Connect(function(p27) --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u24
            [3] = u26
            [4] = u4
            [5] = u23
            [6] = u22
            [7] = u18
            [8] = u20
            [9] = u21
            [10] = u19
        --]]
        u25 = u25 + p27
        if u24 < u25 then
            u26:Disconnect()
        else
            local v28 = u4:GetValue(u25 / u24, u23, u22)
            u18.CFrame = u20.CFrame * u21:Lerp(u21 * u19, v28)
        end
    end)
end
return {
    ["start"] = function(_, p29, p30) --[[ Name: start, Line 51 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if _G.checkRenderDistance(p30.Position) == false then
            return
        else
            local v31 = false
            local v32 = p30.Parent:findFirstChild("DragonClawStance")
            if v32 ~= nil then
                local v33 = v32 and v32.Value == true and true or v31
                if p29 == "1" then
                    doSlash(150, p30, CFrame.new(-0.408172607, 0.151538372, -0.652442932, -0.828702927, -0.340717435, -0.444030583, -0.255246848, 0.936117232, -0.241937444, 0.498096883, -0.0871568546, -0.862730145) * CFrame.Angles(0, -0.5235987755982988, 0), v33)
                end
                if p29 == "2" then
                    doSlash(170, p30, CFrame.new(0.244628906, 0.401259899, -0.198225021, -0.164680377, -0.198592514, 0.96614778, 0.0334625952, -0.980082154, -0.195753038, 0.985779166, 0.0000931255563, 0.168045759) * CFrame.Angles(0, -2.0943951023931953, 0), v33)
                end
                if p29 == "3" then
                    doSlash(170, p30, CFrame.new(0.244598389, 0.401265621, -0.198202133, 0.0373094454, 0.777796507, -0.627407968, 0.0640613884, 0.624690831, 0.77824086, 0.997250259, -0.0692279041, -0.0265194867) * CFrame.Angles(0, -2.0943951023931953, 0), v33)
                end
                if p29 == "4" then
                    doSlash(170, p30, CFrame.new(-0.101318359, 0.0904760361, -0.508447647, 0.473567605, 0.735019505, 0.48526296, 0.330861896, -0.659069955, 0.675394237, 0.816250086, -0.159289777, -0.55530411) * CFrame.Angles(0, -1.0471975511965976, 0), v33)
                end
                if p29 == "5" then
                    local v34 = {
                        ["Shockwave2"] = CFrame.new(-0.376495361, -0.038038969, -1.64731884, 3.22699868e-14, -7.10542397e-15, -1, -1, -1.70606626e-7, 3.22699868e-14, -1.70606626e-7, 1, 7.10543583e-15) * CFrame.new(0, 2.5, 0),
                        ["Shockwave1"] = CFrame.new(-0.376495361, -0.0380334854, -0.272319794, -0.99619472, -2.13162787e-14, -0.087155804, -0.087155804, -1.70606626e-7, 0.99619472, -1.48693644e-8, 1, 1.69957445e-7) * CFrame.new(0, 2.5, 0),
                        ["BlackShockwave"] = CFrame.new(-0.376495361, -0.0380394459, 0.852680206, 3.22699868e-14, -7.10542397e-15, -1, -1, -1.70606626e-7, 3.22699868e-14, -1.70606626e-7, 1, 7.10543583e-15) * CFrame.new(0, 2.5, 0)
                    }
                    local v35 = u1.Shockwave1:Clone()
                    local v36 = v35.Mesh
                    v36.Scale = v36.Scale * 0.45
                    v35.Parent = workspace.Effects
                    v35.CFrame = p30.CFrame * v34.Shockwave1
                    tweenCFrame(v35, CFrame.new(0, -3, 0) * CFrame.Angles(0, -1.5707963267948966, 0), p30, v34.Shockwave1, Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.7)
                    _G.tween(v35.Mesh, { 0.1, "Quint", Enum.EasingDirection.Out }, {
                        ["Scale"] = v35.Mesh.Scale * Vector3.new(1.2, 1.25, 1.2) * 2.2
                    })
                    _G.tween(v35.Decal, { 0.15, "Sine", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                    _G.destroy(v35, 1)
                    local v37 = u1.Shockwave2:Clone()
                    local v38 = v37.Mesh
                    v38.Scale = v38.Scale * 0.45
                    v37.Parent = workspace.Effects
                    v37.CFrame = p30.CFrame * v34.Shockwave2
                    tweenCFrame(v37, CFrame.new(0, -3, 0) * CFrame.Angles(0, 1.2217304763960306, 0), p30, v34.Shockwave2, Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.7)
                    _G.tween(v37.Mesh, { 0.15, "Quint", Enum.EasingDirection.Out }, {
                        ["Scale"] = v37.Mesh.Scale * Vector3.new(1.2, 1.25, 1.2) * 2.2
                    })
                    _G.tween(v37.Decal, { 0.2, "Sine", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                    _G.destroy(v37, 1)
                    if v33 == false then
                        v35.Decal.Color3 = Color3.fromRGB(500, 500, 500)
                        v37.Decal.Color3 = Color3.fromRGB(500, 500, 500)
                        v37.Black.Transparency = 0.5
                        v35.Black.Transparency = 0.5
                    end
                    _G.tween(v35.Black, { 0.35, "Sine", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                    _G.tween(v37.Black, { 0.3, "Sine", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                    local v39 = u1.BlackShockwave:Clone()
                    local v40 = v39.Mesh
                    v40.Scale = v40.Scale * 0.45
                    v39.Parent = workspace.Effects
                    v39.CFrame = p30.CFrame * v34.BlackShockwave
                    tweenCFrame(v39, CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 0.8726646259971648, 0), p30, v34.BlackShockwave, Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.6)
                    _G.tween(v39.Mesh, { 0.2, "Quint", Enum.EasingDirection.Out }, {
                        ["Scale"] = v39.Mesh.Scale * Vector3.new(1.2, 1.25, 1.2) * 2
                    })
                    _G.tween(v39.Decal, { 0.4, "Quad", Enum.EasingDirection.In }, {
                        ["Transparency"] = 1
                    })
                    _G.destroy(v39, 1)
                    local v41 = { 0.4, "Sine", Enum.EasingDirection.In }
                    task.wait(0.05)
                    _G.tween(v37.Mesh, v41, {
                        ["Scale"] = v37.Mesh.Scale * Vector3.new(0, 1.25, 0)
                    })
                    task.wait(0.05)
                    _G.tween(v35.Mesh, v41, {
                        ["Scale"] = v35.Mesh.Scale * Vector3.new(0, 1.25, 0)
                    })
                end
                if p29 == "Air-4" then
                    doSlash(140, p30, CFrame.new(-0.6, 0, 0) * CFrame.new(-0.101318359, 0.0904760361, -0.508447647, 0.473567605, 0.735019505, 0.48526296, 0.330861896, -0.659069955, 0.675394237, 0.816250086, -0.159289777, -0.55530411) * CFrame.Angles(0, -1.0471975511965976, 0), v33)
                end
                if p29 == "Air-5" then
                    doSlash(120, p30, CFrame.new(-0.3, 0, 0) * CFrame.Angles(0, 0, 0.5235987755982988) * CFrame.new(-0.408172607, 0.151538372, -0.652442932, -0.828702927, -0.340717435, -0.444030583, -0.255246848, 0.936117232, -0.241937444, 0.498096883, -0.0871568546, -0.862730145) * CFrame.Angles(0, -0.5235987755982988, 0), v33)
                end
            end
        end
    end
}