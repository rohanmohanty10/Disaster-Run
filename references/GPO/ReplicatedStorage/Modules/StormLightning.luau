 

game:GetService("Debris")
local u1 = require(script.Class)()
local u2 = Instance.new("Part")
u2.Anchored = true
u2.CanCollide = false
u2.TopSurface = Enum.SurfaceType.Smooth
u2.BottomSurface = Enum.SurfaceType.Smooth
u2.CastShadow = false
u2.CanTouch = false
u2.CanQuery = false
Instance.new("BlockMesh", u2)
function u1.init(p3, p4, p5, p6) --[[ Line: 50 ]]
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
    else
        p3.color2 = BrickColor.new("White").Color
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
function u1.GetOptions(p11) --[[ Line: 111 ]]
    local v12 = {}
    for v13, v14 in p11.options do
        v12[v13] = v14
    end
    return v12
end
function u1.GetLines(p15) --[[ Line: 119 ]]
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
function u1.IsDestroyed(p21) --[[ Line: 133 ]]
    return p21.destroyed or false
end
function u1.IsDrawn(p22) --[[ Line: 137 ]]
    return p22.drew or false
end
function u1.generateBolt(p23) --[[ Line: 141 ]]
    for _ = 1, p23.rep do
        p23:bend()
    end
end
function u1.displace(_, p24, p25, p26, p27) --[[ Line: 147 ]]
    local v28 = CFrame.new(p24, p25)
    local v29 = CFrame.new
    local v30 = 3.141592653589793 * p27 * 2
    local v31 = math.sin(v30) * p26
    local v32 = 3.141592653589793 * p27 * 2
    return (v28 * v29(v31, math.cos(v32) * p26, 0)).p
end
function u1.bend(p33) --[[ Line: 151 ]]
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
            ["depth"] = v35.depth
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
function u1.Draw(p40, _) --[[ Line: 178 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v41 = Instance.new("Model")
    p40.model = v41
    v41.Name = "LightningBolt"
    local _ = p40.color2
    local v42 = u2:Clone()
    v42.Material = p40.material
    v42.Color = p40.color
    local v43 = p40:GetLines()
    local _ = math.random(100, 500) / 100
    for v44 = 1, #v43 do
        local v45 = v43[v44]
        local v46 = v42:Clone()
        local v47 = (not p40:GetOptions().thickness and 1 or p40:GetOptions().thickness) - v45.depth * 0.1
        local v48 = (v45.origin - v45.goal).magnitude + 0.5
        local v49 = Vector3.new(v47, v47, v48)
        v46.CFrame = CFrame.new((v45.goal + v45.origin) / 2, v45.goal)
        v46.Size = Vector3.new(1, 1, 1)
        v46.Mesh.Scale = v49
        v46.Transparency = 0
        v46.Parent = v41
    end
    v41.Parent = workspace.Effects
    p40.drew = true
    if p40.options.decay then
        local v50 = _G.destroy
        local v51 = p40.options.decay
        v50(v41, tonumber(v51) or 0)
        p40.destroyed = true
    end
end
function u1.Destroy(p52) --[[ Line: 216 ]]
    if p52.model then
        p52.model:Destroy()
        p52.destroyed = true
    end
end
return setmetatable({
    ["new"] = u1
}, {
    ["__call"] = function(_, ...) --[[ Name: __call, Line 225 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1(...)
    end
})