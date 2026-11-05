  

 

local Angles = CFrame.Angles;
local cos = math.cos;
local sin = math.sin;
local _ = math.rad;
local _ = math.random;
local RunService = game:GetService("RunService");

local function getang(p1, p2) -- Line: 7
    -- upvalues: cos (copy), sin (copy)
    return { cos(p1) * p2, sin(p1) * p2 };
end;

local function createradians(p3, p4, p5) -- Line: 12
    -- upvalues: cos (copy), sin (copy)
    local v6 = p5 or 0;
    local v7 = {};

    for i = 1, p3 do
        local v8 = 6.283185307179586 / p3 * i + v6;
        local v9 = { cos(v8) * p4, sin(v8) * p4 };
        table.insert(v7, v9);
    end;

    return v7;
end;

return function(p10, p11, p12) -- Line: 22
    -- upvalues: Angles (copy), createradians (copy), RunService (copy)
    local v13 = game.ReplicatedStorage["Client Assets"].Umbra.katana:Clone();
    local Amount = p12.Amount;
    local Offset = p12.Offset;
    local Speed = p12.Speed;
    local v14 = {};

    for _ = 1, Amount do
        local v15 = v13:Clone();
        v15.Parent = workspace.Effects;
        table.insert(v14, v15);
        game:GetService("TweenService"):Create(v15, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Transparency = 0
        }):Play();
    end;

    local Block = p10.Values.Block;
    local v16 = Angles(0, 0, 3.141592653589793);
    local v17 = 0;

    while Block.Value == "Blocking" or Block.Value == "Perfect" do
        local v18 = createradians(Amount, Offset, v17 * Speed);

        for i, v in ipairs(v18) do
            v14[i].CFrame = p11.CFrame * CFrame.new(v[1], 1, v[2]) * v16;
        end;

        v17 = v17 + RunService.RenderStepped:Wait();
    end;

    for _, v in ipairs(v14) do
        v:Destroy();
    end;
end;