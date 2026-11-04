 

game:GetService("Debris")
local u1 = require(script.Class)()
local u2 = Instance.new("Part")
u2.Anchored = true
u2.CanCollide = false
u2.TopSurface = Enum.SurfaceType.Smooth
u2.BottomSurface = Enum.SurfaceType.Smooth
function u1.init(p3, p4, p5, p6) --[[ Line: 19 ]]
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
    p3.origin = p4
    p3.goal = p5
    p3.depth = p3.options.depth or 0
    p3.thickness = p3.options.thickness or 1
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
    p3.material = p3.options.material or Enum.Material.Neon
    p3.branches = {}
    p3.lines = {
        {
            ["origin"] = p4,
            ["goal"] = p5,
            ["transparency"] = p3.options.transparency or 0.4,
            ["depth"] = p3.depth
        }
    }
    p3:generateBolt()
end
function u1.GetOptions(p9) --[[ Line: 69 ]]
    local v10 = {}
    for v11, v12 in p9.options do
        v10[v11] = v12
    end
    return v10
end
function u1.GetLines(p13) --[[ Line: 77 ]]
    local v14 = {}
    for v15 = 1, #p13.lines do
        v14[v15] = p13.lines[v15]
    end
    for v16 = 1, #p13.branches do
        local v17 = p13.branches[v16]:GetLines()
        for v18 = 1, #v17 do
            v14[#v14 + 1] = v17[v18]
        end
    end
    return v14
end
function u1.IsDestroyed(p19) --[[ Line: 91 ]]
    return p19.destroyed or false
end
function u1.IsDrawn(p20) --[[ Line: 95 ]]
    return p20.drew or false
end
function u1.generateBolt(p21) --[[ Line: 99 ]]
    for _ = 1, p21.rep do
        p21:bend()
    end
end
function u1.displace(_, p22, p23, p24, p25) --[[ Line: 105 ]]
    local v26 = CFrame.new(p22, p23)
    local v27 = CFrame.new
    local v28 = 3.141592653589793 * p25 * 2
    local v29 = math.sin(v28) * p24
    local v30 = 3.141592653589793 * p25 * 2
    return (v26 * v27(v29, math.cos(v30) * p24, 0)).p
end
function u1.bend(p31) --[[ Line: 109 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    for v32 = 1, #p31.lines do
        local v33 = p31.lines[v32]
        local v34 = v33.goal
        v33.goal = p31:displace(v33.origin + (v33.goal - v33.origin).unit * (v33.goal - v33.origin).magnitude * p31.random:NextInteger(40, 60) / 100, v33.goal, p31.random:NextInteger(-530, 530) / 100, p31.random:NextNumber())
        p31.lines[#p31.lines + 1] = {
            ["origin"] = v33.goal,
            ["goal"] = v34,
            ["transparency"] = v33.transparency,
            ["depth"] = v33.depth
        }
        if v33.depth <= (p31.options.max_depth or 3) then
            local v35 = (p31.origin - v33.goal).magnitude / (p31.origin - p31.goal).magnitude
            if p31.random:NextInteger(1, 100) < (p31.options.fork_chance or 50) * v35 then
                local v36 = p31:GetOptions()
                v36.depth = v33.depth + 1
                v36.bends = v36.fork_bends or 2
                local v37 = u1(v33.goal, v33.goal + (v33.goal - v33.origin).unit * p31.random:NextInteger(20, 40), v36)
                p31.branches[#p31.branches + 1] = v37
            end
        end
    end
end
function u1.Draw(p38, p39) --[[ Line: 136 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v40 = Instance.new("Model")
    v40.Name = "lightning"
    p38.model = v40
    v40.Name = "LightningBolt"
    p38.SegmentCache = {}
    local v41 = u2:Clone()
    v41.Material = p38.material
    v41.Color = p38.color
    local v42 = p38:GetLines()
    for v43 = 1, #v42 do
        local v44 = v42[v43]
        local v45 = v41:Clone()
        local v46 = p38.thickness - v44.depth * 2 * 0.1
        local v47 = p38.thickness - v44.depth * 2 * 0.1
        local v48 = (v44.origin - v44.goal).magnitude + 0.5
        v45.Size = Vector3.new(v46, v47, v48)
        v45.CFrame = CFrame.new((v44.goal + v44.origin) / 2, v44.goal)
        v45.Transparency = v44.transparency
        v45.Parent = v40
        local v49 = p38.SegmentCache
        table.insert(v49, v43, v45)
    end
    v40.Parent = p39 or workspace
    p38.drew = true
    if p38.options.decay then
        local v50 = _G.destroy
        local v51 = p38.options.decay
        v50(v40, tonumber(v51) or 0)
        p38.destroyed = true
    end
end
function u1.Update(p52, p53, p54, p55, p56, p57) --[[ Line: 170 ]]
    p52.color = p56
    p52.thickness = p57
    p52.transparency = p55
    p52.branches = {}
    p52.lines = {
        {
            ["origin"] = p53,
            ["goal"] = p54,
            ["transparency"] = 0,
            ["depth"] = p52.depth
        }
    }
    p52:generateBolt()
    local v58 = p52:GetLines()
    for v59 = 1, #v58 do
        local v60 = v58[v59]
        local v61 = p52.SegmentCache[v59]
        local v62 = p52.thickness - v60.depth * 2 * 0.1
        local v63 = p52.thickness - v60.depth * 2 * 0.1
        local v64 = (v60.origin - v60.goal).magnitude + 0.5
        v61.Size = Vector3.new(v62, v63, v64)
        v61.CFrame = CFrame.new((v60.goal + v60.origin) / 2, v60.goal)
        v61.Transparency = p55
        v61.Color = p56
    end
end
function u1.Destroy(p65) --[[ Line: 199 ]]
    if p65.model then
        p65.model:Destroy()
        p65.destroyed = true
    end
end
return setmetatable({
    ["new"] = u1
}, {
    ["__call"] = function(_, ...) --[[ Name: __call, Line 208 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1(...)
    end
})