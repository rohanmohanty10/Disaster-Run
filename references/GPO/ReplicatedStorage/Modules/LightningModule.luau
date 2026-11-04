 

game:GetService("Debris")
local u1 = require(script.Class)()
local u2 = Instance.new("Part")
u2.Anchored = true
u2.CanCollide = false
u2.CanQuery = false
u2.CanTouch = false
u2.TopSurface = Enum.SurfaceType.Smooth
u2.BottomSurface = Enum.SurfaceType.Smooth
Instance.new("BlockMesh", u2)
function u1.init(p3, p4, p5, p6) --[[ Line: 49 ]]
    if typeof(p4) ~= "Vector3" then
        error("LightningBolt: `from` must be a Vector3")
    end
    if typeof(p5) ~= "Vector3" then
        error("LightningBolt: `to` must be a Vector3")
    end
    p3.options = p6 or {}
    if p3.options.seed then
        p3.random = Random.new(p3.options.seed)
    else
        p3.random = Random.new()
    end
    p3.depth = p3.options.depth or 0
    p3.origin = p4
    p3.goal = p5
    p3.rep = p3.options.bends or 6
    if p3.options.color then
        local v7 = p3.options.color
        if typeof(v7) == "Color3" then
            p3.color = p3.options.color
        else
            local v8 = p3.options.color
            if typeof(v8) == "BrickColor" then
                p3.color = p3.options.color.Color
            else
                error("LightningBolt: `Options.color` must be a Color3 or BrickColor")
            end
        end
    else
        p3.color = BrickColor.new("White").Color
    end
    if p3.options.color2 then
        local v9 = p3.options.color2
        if typeof(v9) == "Color3" then
            p3.color2 = p3.options.color2
        else
            local v10 = p3.options.color2
            if typeof(v10) == "BrickColor" then
                p3.color2 = p3.options.color2.Color
            else
                error("LightningBolt: `Options.color2` must be a Color3 or BrickColor")
            end
        end
    end
    p3.thickness = p3.options.thickness
    p3.ti = p3.options.ti
    p3.material = p3.options.material or Enum.Material.Neon
    p3.branches = {}
    p3.lines = {
        {
            ["origin"] = p4,
            ["goal"] = p5,
            ["transparency"] = p3.options.transparency or 0.4,
            ["depth"] = p3.depth,
            ["num"] = 0,
            ["max"] = 0
        }
    }
    p3:generateBolt()
end
function u1.GetOptions(p11) --[[ Line: 113 ]]
    local v12 = {}
    for v13, v14 in p11.options do
        v12[v13] = v14
    end
    return v12
end
function u1.GetLines(p15) --[[ Line: 121 ]]
    local v16 = {}
    for v17 = 1, #p15.lines do
        v16[v17] = p15.lines[v17]
    end
    for v18 = 1, #p15.branches do
        local v19 = p15.branches[v18]:GetLines()
        for v20 = 1, #v19 do
            v16[#v16 + 1] = v19[v20]
        end
    end
    return v16
end
function u1.IsDestroyed(p21) --[[ Line: 135 ]]
    return p21.destroyed or false
end
function u1.IsDrawn(p22) --[[ Line: 139 ]]
    return p22.drew or false
end
function u1.generateBolt(p23) --[[ Line: 143 ]]
    for _ = 1, p23.rep do
        p23:bend()
    end
end
function u1.displace(_, p24, p25, p26, p27) --[[ Line: 149 ]]
    local v28 = CFrame.new(p24, p25)
    local v29 = CFrame.new
    local v30 = 3.141592653589793 * p27 * 2
    local v31 = math.sin(v30) * p26
    local v32 = 3.141592653589793 * p27 * 2
    return (v28 * v29(v31, math.cos(v32) * p26, 0)).p
end
function u1.bend(p33) --[[ Line: 153 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    for v34 = 1, #p33.lines do
        local v35 = p33.lines[v34]
        local v36 = v35.goal
        v35.goal = p33:displace(v35.origin + (v35.goal - v35.origin).unit * (v35.goal - v35.origin).magnitude * p33.random:NextInteger(40, 60) / 100, v35.goal, p33.random:NextInteger(-530, 530) / 100, p33.random:NextNumber())
        p33.lines[#p33.lines + 1] = {
            ["origin"] = v35.goal,
            ["goal"] = v36,
            ["transparency"] = v35.transparency,
            ["depth"] = v35.depth,
            ["num"] = v34,
            ["max"] = #p33.lines
        }
        if v35.depth <= (p33.options.max_depth or 3) then
            local v37 = (p33.origin - v35.goal).magnitude / (p33.origin - p33.goal).magnitude
            if p33.random:NextInteger(1, 100) < (p33.options.fork_chance or 50) * v37 then
                local v38 = p33:GetOptions()
                v38.depth = v35.depth + 1
                v38.bends = v38.fork_bends or 2
                local v39 = u1(v35.goal, v35.goal + (v35.goal - v35.origin).unit * p33.random:NextInteger(20, 40), v38)
                p33.branches[#p33.branches + 1] = v39
            end
        end
    end
end
function u1.Draw(u40, _) --[[ Line: 182 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u41 = Instance.new("Model")
    u40.model = u41
    u41.Name = "LightningBolt"
    local u42 = u40.color2
    local u43 = u2:Clone()
    u43.Material = u40.material
    u43.Color = u40.color
    local u44 = u40:GetLines()
    local _ = math.random(100, 500) / 100
    local u45 = u40.ti
    task.spawn(function() --[[ Line: 194 ]]
        --[[
        Upvalues:
            [1] = u44
            [2] = u43
            [3] = u40
            [4] = u41
            [5] = u45
            [6] = u42
        --]]
        for v46 = 1, #u44 do
            local v47 = u44[v46]
            local u48 = u43:Clone()
            local v49 = u40.thickness - v47.depth * 0.1
            local v50 = u40.thickness - v47.depth * 0.1
            local v51 = (v47.origin - v47.goal).magnitude
            local u52 = Vector3.new(v49, v50, v51)
            u48.CFrame = CFrame.new((v47.goal + v47.origin) / 2, v47.goal)
            u48.Size = Vector3.new(1, 1, 1)
            u48.Mesh.Scale = Vector3.new(0, 0, 0)
            u48.Parent = u41
            task.spawn(function() --[[ Line: 204 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u52
                    [3] = u45
                    [4] = u42
                --]]
                if u48 and u48.Parent ~= nil then
                    u48.Mesh.Scale = u52
                    u48.Transparency = 0
                    local v53 = math.random(1, 6)
                    local v54 = TweenInfo.new(u45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, v53, true, math.random(10, 75) / 1000)
                    local v55 = {}
                    local v56 = u52.Z
                    v55.Scale = Vector3.new(0, 0, v56)
                    game:GetService("TweenService"):Create(u48.Mesh, v54, v55):Play()
                end
                if u42 ~= nil then
                    task.wait(u45 / 2)
                    local v57 = TweenInfo.new(u45 / 2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)
                    local v58 = {
                        ["Color"] = u42,
                        ["Transparency"] = 1
                    }
                    game:GetService("TweenService"):Create(u48, v57, v58):Play()
                end
            end)
            game["Run Service"].Stepped:Wait()
        end
    end)
    u41.Parent = workspace.Effects
    u40.drew = true
    if u40.options.decay then
        local v59 = _G.destroy
        local v60 = u40.options.decay
        v59(u41, (tonumber(v60) or 0) + 3)
        u40.destroyed = true
    end
end
function u1.Destroy(p61) --[[ Line: 279 ]]
    if p61.model then
        p61.model:Destroy()
        p61.destroyed = true
    end
end
return setmetatable({
    ["new"] = u1
}, {
    ["__call"] = function(_, ...) --[[ Name: __call, Line 288 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1(...)
    end
})