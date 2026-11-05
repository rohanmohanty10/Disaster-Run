  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local XenoFunctions = require(ReplicatedStorage.ReplicatedModules.XenoFunctions);
local u1 = EffectsHandler.GetEffect("ranNum");

return function(p2) -- Line: 9
    -- upvalues: u1 (copy), XenoFunctions (copy), TweenService (copy)
    local OrigPos = p2.OrigPos;
    local v3 = p2.Spread or 5;
    local u4 = p2.Time or 0.5;

    for _ = 1, p2.Amount or 10 do
        local v5 = u1(-v3, v3);
        local v6 = OrigPos + Vector3.new(v5, 0, u1(-v3, v3));
        local u7 = XenoFunctions.RayCastOnMap(v6, Vector3.new(0, -15, 0), true);

        if u7 then
            coroutine.wrap(function() -- Line: 20
                -- upvalues: u7 (copy), u1 (ref), u4 (copy), TweenService (ref)
                local Instance2 = u7.Instance;
                local Part = Instance.new("Part");
                Part.Anchored = true;
                Part.CanCollide = false;
                local v8 = u1(1, 2);
                local v9 = u1(1, 2);
                Part.Size = Vector3.new(v8, v9, u1(1, 2)) / 4;
                Part.Color = Instance2.Color;
                Part.Material = Instance2.Material;
                Part.CFrame = CFrame.new(u7.Position);
                Part.Parent = workspace.Effects;
                game.Debris:AddItem(Part, u4 + 2);
                local new = CFrame.new;
                local Position = Part.Position;
                local v10 = u1(5, 25);
                local v11 = new(Position + Vector3.new(0, v10, 0));
                local Angles = CFrame.Angles;
                local v12 = u1(-180, 180);
                local v13 = math.rad(v12);
                local v14 = u1(-180, 180);
                local v15 = math.rad(v14);
                local v16 = u1(-180, 180);
                local v17 = Angles(v13, v15, (math.rad(v16)));
                TweenService:Create(Part, TweenInfo.new(u4), {
                    CFrame = v11 * v17
                }):Play();
                wait(u4);
                game:GetService("PhysicsService"):SetPartCollisionGroup(Part, "FX");
                Part.CanCollide = true;
                Part.Anchored = false;
                TweenService:Create(Part, TweenInfo.new(2), {
                    Transparency = 1
                }):Play();
            end)();
        end;
    end;
end;