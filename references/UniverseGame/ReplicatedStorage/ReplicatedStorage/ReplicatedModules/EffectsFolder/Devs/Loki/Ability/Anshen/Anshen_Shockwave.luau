  

 

local Anshen = game.ReplicatedStorage["Client Assets"]:FindFirstChild("Anshen");
local Petal = require(game.ReplicatedStorage.ReplicatedModules:WaitForChild("Petal"));
local v1 = Petal("Util");
Petal("New");
local Tween = v1.Tween;

return function(p2, p3) -- Line: 8
    -- upvalues: Anshen (copy), Tween (copy)
    local v4 = p3 == nil and 1 or p3;
    local u5 = Anshen.MeshEffects.Shockwave1:Clone();
    local u6 = Anshen.MeshEffects.Shockwave2:Clone();
    u5.Parent = workspace.Effects;
    u6.Parent = workspace.Effects;
    local v7 = { Vector3.new(17.297 * v4, 5.565, 17.297 * v4), (Vector3.new(22.082 * v4, 3.887, 22.082 * v4)) };
    u5.Size = Vector3.new(0, 6.5, 0);
    u6.Size = Vector3.new(0, 4.5, 0);
    u5.Position = p2 + Vector3.new(0, 1, 0);
    u6.Position = p2 + Vector3.new(0, 1, 0);
    local v8 = next;
    local v9, v10 = u5:GetChildren();

    for _, v in v8, v9, v10 do
        Tween(v, 0.38, "Sine", "InOut", {
            Transparency = 1
        });
    end;

    local v11 = next;
    local v12, v13 = u6:GetChildren();

    for _, v in v11, v12, v13 do
        Tween(v, 0.34, "Sine", "InOut", {
            Transparency = 1
        });
    end;

    Tween(u5, 0.4, "Quad", "InOut", {
        Size = v7[1]
    }).Completed:Once(function() -- Line: 30
        -- upvalues: u5 (copy)
        u5:Destroy();
    end);
    Tween(u6, 0.35, "Quad", "InOut", {
        Size = v7[2]
    }).Completed:Once(function() -- Line: 33
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;