  

 

local u1 = {};
u1.__index = u1;
CFn = CFrame.new;
V3n = Vector3.new;
Ins = Instance.new;
R3n = Region3.new;
C3n = Color3.new;
V2n = Vector2.new;
Udn = UDim2.new;
Ang = CFrame.Angles;
Rad = math.rad;
Cos = math.cos;
Sin = math.sin;
Tan = math.tan;

function Rng(p2, p3, p4)
    return p4 and Random.new():NextNumber(p2, p3) or Random.new():NextInteger(p2, p3);
end;

BCn = BrickColor.new;
RGB = Color3.fromRGB;

function u1.Init(p5) -- Line: 26
    -- upvalues: u1 (copy)
    local v6 = next;
    local v7, v8 = script:GetChildren();
    local v9 = {};

    for i, v in v6, v7, v8 do
        v9[i] = require(v);
    end;

    u1.Variants = {};

    for i = 1, #v9 do
        local v10 = v9[i]:Mount(p5);
        u1.Variants[v10] = {
            Render = v9[i].Render
        };
    end;
end;

return u1;