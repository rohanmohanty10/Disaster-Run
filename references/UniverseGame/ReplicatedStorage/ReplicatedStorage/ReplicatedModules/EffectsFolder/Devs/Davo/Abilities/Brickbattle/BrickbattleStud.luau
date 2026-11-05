  

 

local Petal = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("Petal"));
local u1 = Petal("New");
Petal("Util");
local Debris = game:GetService("Debris");
local new = Vector3.new;
local _ = Random.new;
local random = math.random;
local _ = math.abs;
local _ = math.cos;
local _ = math.sin;
local _ = math.min;
local _ = math.max;
local _ = math.floor;
local _ = math.pow;
local _ = math.ceil;
local _ = math.rad;
local _ = math.clamp;
local u2 = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("RayCastOnMap");

return function(p3, p4, p5, p6) -- Line: 14
    -- upvalues: random (copy), new (copy), u2 (copy), u1 (copy), Debris (copy)
    for _ = 1, p5 or 1 do
        local v7 = new(random(-1, 1), random(0, 1), random(-1, 1));

        if p4 == "Ground" then
            local v8 = u2(typeof(p3) == "Vector3" and p3 and p3 or p3.Position, Vector3.new(0, -5, 0), true);

            if not (v8 and v8.Instance) then
                return;
            end;

            p4 = v8.Instance.Color;
        end;

        Debris:AddItem(u1("Part")({
            FormFactor = 2,
            Size = Vector3.new(1, 0.4, 1),
            Massless = true,
            CanTouch = false,
            CanQuery = false,
            Shape = Enum.PartType.Block,
            Color = p4,
            Velocity = v7 * (p6 or 1),
            CFrame = CFrame.new((typeof(p3) == "Vector3" and p3 and p3 or p3.Position) + v7, v7),
            Parent = workspace.Effects
        }), random(1, 35) / 10);
    end;
end;