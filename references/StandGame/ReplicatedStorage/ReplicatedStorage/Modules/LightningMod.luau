 

 

local l__Debris__1 = game:GetService("Debris");
local u1 = require(script.Class)();
local u2 = Instance.new("Part");
u2.Anchored = true;
u2.CanCollide = false;
u2.TopSurface = Enum.SurfaceType.Smooth;
u2.BottomSurface = Enum.SurfaceType.Smooth;
function u1.init(p3, p4, p5, p6) --[[ Line: 44 ]]
    if typeof(p4) ~= "Vector3" then
        error("LightningBolt: `from` must be a Vector3");
    end;
    if typeof(p5) ~= "Vector3" then
        error("LightningBolt: `to` must be a Vector3");
    end;
    p3.options = p6 or {};
    if p3.options.seed then
        p3.random = Random.new(p3.options.seed);
    else
        p3.random = Random.new();
    end;
    p3.depth = p3.options.depth or 0;
    p3.origin = p4;
    p3.goal = p5;
    p3.rep = p3.options.bends or 6;
    if p3.options.color then
        if typeof(p3.options.color) == "Color3" then
            p3.color = p3.options.color;
        elseif typeof(p3.options.color) == "BrickColor" then
            p3.color = p3.options.color.Color;
        else
            error("LightningBolt: `Options.color` must be a Color3 or BrickColor");
        end;
    else
        p3.color = BrickColor.new("White").Color;
    end;
    p3.material = p3.options.material or Enum.Material.Neon;
    p3.branches = {};
    p3.lines = {
        {
            origin = p4,
            goal = p5,
            transparency = p3.options.transparency or 0.4,
            depth = p3.depth
        }
    };
    p3:generateBolt();
end;
function u1.GetOptions(p7) --[[ Line: 93 ]]
    local v8 = {};
    for v9, v10 in pairs(p7.options) do
        v8[v9] = v10;
    end;
    return v8;
end;
function u1.GetLines(p11) --[[ Line: 101 ]]
    local v12 = {};
    for v13 = 1, #p11.lines do
        v12[v13] = p11.lines[v13];
    end;
    for v14 = 1, #p11.branches do
        local v15 = p11.branches[v14]:GetLines();
        for v16 = 1, #v15 do
            v12[#v12 + 1] = v15[v16];
        end;
    end;
    return v12;
end;
function u1.IsDestroyed(p17) --[[ Line: 115 ]]
    return p17.destroyed or false;
end;
function u1.IsDrawn(p18) --[[ Line: 119 ]]
    return p18.drew or false;
end;
function u1.generateBolt(p19) --[[ Line: 123 ]]
    for _ = 1, p19.rep do
        p19:bend();
    end;
end;
function u1.displace(_, p20, p21, p22, p23) --[[ Line: 129 ]]
    return (CFrame.new(p20, p21) * CFrame.new(math.sin(3.141592653589793 * p23 * 2) * p22, math.cos(3.141592653589793 * p23 * 2) * p22, 0)).p;
end;
function u1.bend(p24) --[[ Line: 133 ]]
    -- upvalues: u1 (copy)
    for v25 = 1, #p24.lines do
        local v26 = p24.lines[v25];
        local l__goal__2 = v26.goal;
        v26.goal = p24:displace(v26.origin + (v26.goal - v26.origin).unit * (v26.goal - v26.origin).magnitude * p24.random:NextInteger(40, 60) / 100, v26.goal, p24.random:NextInteger(-530, 530) / 100, p24.random:NextNumber());
        p24.lines[#p24.lines + 1] = {
            origin = v26.goal,
            goal = l__goal__2,
            transparency = v26.transparency,
            depth = v26.depth
        };
        if v26.depth <= (p24.options.max_depth or 3) then
            local v27 = (p24.origin - v26.goal).magnitude / (p24.origin - p24.goal).magnitude;
            if p24.random:NextInteger(1, 100) < (p24.options.fork_chance or 50) * v27 then
                local v28 = p24:GetOptions();
                v28.depth = v26.depth + 1;
                v28.bends = v28.fork_bends or 2;
                local v29 = u1(v26.goal, v26.goal + (v26.goal - v26.origin).unit * p24.random:NextInteger(20, 40), v28);
                p24.branches[#p24.branches + 1] = v29;
            end;
        end;
    end;
end;
function u1.Draw(p30, p31) --[[ Line: 160 ]]
    -- upvalues: u2 (copy), l__Debris__1 (copy)
    local v32 = Instance.new("Model");
    p30.model = v32;
    v32.Name = "LightningBolt";
    local v33 = u2:Clone();
    v33.Material = p30.material;
    v33.Color = p30.color;
    local v34 = p30:GetLines();
    for v35 = 1, #v34 do
        local v36 = v34[v35];
        local v37 = v33:Clone();
        local v38 = (1 - v36.depth * 2 * 0.1) * p30.options.thickness;
        v37.Size = Vector3.new(v38, v38, (v36.origin - v36.goal).magnitude + 0.5);
        v37.CFrame = CFrame.new((v36.goal + v36.origin) / 2, v36.goal);
        v37.Transparency = v36.transparency;
        v37.Parent = v32;
    end;
    v32.Parent = p31 or workspace;
    p30.drew = true;
    if p30.options.decay then
        l__Debris__1:AddItem(v32, tonumber(p30.options.decay) or 0);
        if p30.options.tweendecayinfo then
            for _, v39 in pairs(v32:GetChildren()) do
                game:GetService("TweenService"):Create(v39, p30.options.tweendecayinfo.info, p30.options.tweendecayinfo.outcome):Play();
            end;
        end;
        p30.destroyed = true;
    end;
end;
function u1.Destroy(p40) --[[ Line: 198 ]]
    if p40.model then
        p40.model:Destroy();
        p40.destroyed = true;
    end;
end;
return setmetatable({
    new = u1
}, {
    __call = function(_, ...) --[[ Name: __call, Line 207 ]]
        -- upvalues: u1 (copy)
        return u1(...);
    end
});