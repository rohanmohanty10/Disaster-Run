 

local v1 = {}
require(game.ReplicatedStorage.Modules.FastWait)
require(game.ReplicatedStorage.Modules.GLightning)
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
local u3 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
require(game.ReplicatedStorage.Modules.LightningBolt.LightningExplosion)
function cubicBezier(p4, p5, p6, p7, p8)
    return (1 - p4) ^ 3 * p5 + 3 * (1 - p4) ^ 2 * p4 * p6 + 3 * (1 - p4) * p4 ^ 2 * p7 + p4 ^ 3 * p8
end
local u9 = {}
function length(p10, p11, ...)
    local v12 = {}
    local v13 = 0
    local v14 = {}
    for v15 = 0, p10 - 1 do
        local v16 = p11(v15 / p10, ...)
        local v17 = p11((v15 + 1) / p10, ...)
        local v18 = (v17 - v16).Magnitude
        v12[v13] = { v18, v16, v17 }
        table.insert(v14, v13)
        v13 = v13 + v18
    end
    return v13, v12, v14
end
function u9.new(p19, p20, ...) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v21 = {
        ["__index"] = u9
    }
    local v22 = setmetatable({}, v21)
    local v23, v24, v25 = length(p20, p19, ...)
    v22.func = p19
    v22.n = p20
    v22.points = { ... }
    v22.length = v23
    v22.ranges = v24
    v22.sums = v25
    return v22
end
function u9.setPoints(p26, ...) --[[ Line: 39 ]]
    local v27, v28, v29 = length(p26.n, p26.func, ...)
    p26.points = { ... }
    p26.length = v27
    p26.ranges = v28
    p26.sums = v29
end
function u9.calc(p30, p31) --[[ Line: 48 ]]
    local v32 = p30.func
    local v33 = p30.points
    return v32(p31, unpack(v33))
end
function u9.calcFixed(p34, p35) --[[ Line: 53 ]]
    local v36 = p35 * p34.length
    local v37 = 0
    for _, v38 in next, p34.sums do
        if v36 - v38 < 0 then
            break
        end
        v37 = v38
    end
    local v39 = p34.ranges[v37]
    local v40 = (v36 - v37) / v39[1]
    return v39[2], v39[3], v40
end
local function u45(p41, u42) --[[ Line: 88 ]]
    local u43 = p41:GetChildren()
    for u44 = 1, #u43 do
        pcall(function() --[[ Line: 91 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u44
                [3] = u42
            --]]
            u43[u44].Color = _G.filterColor(u42, u43[u44].Color)
        end)
    end
end
function v1.start(_, p46, p47) --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u45
        [2] = u9
        [3] = u2
        [4] = u3
    --]]
    local v48 = game.Players:GetPlayerFromCharacter(p46)
    local v49 = CFrame.new(p47.start.Position)
    local v50 = p47.endPos
    if _G.checkRenderDistance(v50.Position) ~= false then
        local v51 = script.Dragon:Clone()
        u45(v51, v48)
        v51.Parent = workspace.Effects
        v51:PivotTo(v49)
        _G.PlaySound(v51.PrimaryPart, script.start)
        local _ = (v49.Position - v50.Position).Magnitude / 4
        local v52 = v49.Position
        local v53 = (v49 * CFrame.new(math.random(12.5, 25) * (math.random(1, 2) == 1 and -1 or 1), -12.5, 0)).Position
        local v54 = (v49 * CFrame.new(math.random(12.5, 25) * (math.random(1, 2) == 1 and -1 or 1), 50, 0)).Position
        local v55 = v50.Position
        local v56 = u9.new(cubicBezier, 100, v52, v53, v54, v55)
        local v57 = v49.Position
        tick()
        local v58 = p47.tim
        local v59 = tick()
        local v60 = v49
        local v61 = v60
        local v62 = v60
        v60 = v61
        v62 = v61
        local v63 = {}
        while tick() - v59 < v58 do
            local v64 = (tick() - v59) / v58
            local v65 = math.min(1, v64)
            local v66, v67, v68 = v56:calcFixed(v65)
            local v69 = v66 + (v67 - v66) * v68
            local v70 = CFrame.new(v69)
            v51:PivotTo(CFrame.new(v70.Position, v57) * CFrame.Angles(-0.7853981633974483, 3.141592653589793, 0))
            local _ = (v57 - v70.Position).Magnitude
            local v71 = (v49.Position - v70.Position).Magnitude
            if v71 >= 1 then
                local v72 = script.Part:Clone()
                v72.CFrame = CFrame.new(v49.Position:Lerp(v70.Position, 0.5), v70.Position) * CFrame.Angles(1.5707963267948966, 0, 0)
                v72.Size = Vector3.new(4, v71, 4)
                v72.Color = _G.filterColor(v48, v72.Color)
                v72.Parent = workspace.Effects
                _G.tween(v72.Mesh, {
                    0.25,
                    "Smooth",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(0, 1, 0)
                })
                _G.destroy(v72, 0.25)
                if (v61.Position - v70.Position).Magnitude >= 20 then
                    local v73 = v72.CFrame
                    local v74 = CFrame.Angles
                    local v75 = math.random(-360, 360)
                    v61 = v73 * v74(0, math.rad(v75), 1.5707963267948966)
                    local v76 = v65 * 25 * 2
                    local v77 = _G.PlayEffect
                    local v78 = BrickColor.new("White")
                    local v79 = Vector3.new(v76, v76, v76)
                    local v80 = v76 / 2
                    local v81 = v76 / 2
                    local v82 = v76 / 2
                    v77("Shockwave2", nil, v61, v61, v78, v79, Vector3.new(v80, v81, v82), 0.25, 0, Enum.EasingStyle.Quad, _G.filterColor(v48, Color3.fromRGB(0, 255, 255)), Enum.Material.Neon, "HShock")
                    table.insert(v63, v61)
                    v49 = v70
                else
                    v49 = v70
                end
            end
            v57 = v70.Position
            game["Run Service"].RenderStepped:Wait()
        end
        _G.PlaySound(v51.PrimaryPart, script.ex)
        _G.PlayEffect("DragonExplode", nil, CFrame.new(v57), v48)
        _G.destroy(v51, 0.1)
        for v83 = 1, #v63 do
            local v84 = Instance.new("Attachment")
            _G.destroy(v84, 5)
            v84.Parent = workspace.Terrain
            if typeof(v60) == "CFrame" then
                v84.WorldCFrame = v60
            end
            if typeof(v60) == "Vector3" then
                v84.Position = v60
            end
            local v85 = v63[v83]
            local v86 = Instance.new("Attachment")
            _G.destroy(v86, 5)
            v86.Parent = workspace.Terrain
            if typeof(v85) == "CFrame" then
                v86.WorldCFrame = v85
            end
            if typeof(v85) == "Vector3" then
                v86.Position = v85
            end
            local v87 = u2.new(v84, v86, 3)
            local v88 = math.random(5, 10)
            v87.CurveSize0 = 0
            v87.CurveSize1 = v88
            v87.PulseSpeed = 15
            v87.AnimationSpeed = math.random(15, 20)
            v87.PulseLength = 5
            v87.FadeLength = 0.5
            v87.Thickness = v83
            v87.Color = _G.filterColor(v48, Color3.fromRGB(89, 161, 255))
            v87.Frequency = math.random(15, 25)
            v87.MinThicknessMultiplier = 0.5
            v87.MaxThicknessMultiplier = 1
            v87.MinRadius = 0
            v87.MaxRadius = 10
            v87.ContractFrom = 0.5
            local v89 = u3.new(v87)
            v89.MaxDistance = 50
            v89.MinDistance = 25
            v89.MaxSparkCount = 2
            v89.MaxSpeed = 20
            v60 = v63[v83]
        end
    end
end
return v1