  

 

local u1 = {};
u1.__index = u1;
local Funcs = require(game.ReplicatedStorage["Client Assets"].Goku["Goku Modules"].Funcs);
local _ = CFrame.new;
local _ = Vector3.new;
local _ = Instance.new;
local _ = Region3.new;
local _ = Color3.new;
local _ = Vector2.new;
local _ = UDim2.new;
local _ = CFrame.Angles;
local _ = math.rad;
local _ = math.cos;
local _ = math.sin;
local _ = math.tan;
local _ = BrickColor.new;
local _ = Color3.fromRGB;
local _ = Funcs.RNG;

function u1.Init(p2) -- Line: 15
    -- upvalues: u1 (copy)
    local v3 = {};

    for i, child in pairs(script:GetChildren()) do
        v3[i] = require(child);
    end;

    u1.Variants = {};

    for _, v in ipairs(v3) do
        local v4 = v:Mount(p2);
        u1.Variants[v4] = {
            Render = v.Render
        };
    end;
end;

return u1;