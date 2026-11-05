  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
require(PathShortcuts.KnitPath.Knit);
local u1 = game.ReplicatedStorage["Client Assets"];
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u2 = {
    [1] = CFrame.new(0, 0.5, -0.25) * CFrame.Angles(-3.141592653589793, -1.3089969389957472, -0.24434609527920614),
    [2] = CFrame.new(0, 0.22, 0) * CFrame.Angles(0, 0.7504915783575618, -0.4363323129985824),
    [4] = CFrame.new(0, 0.25, -0.45) * CFrame.Angles(0, 0.7853981633974483, 0.3141592653589793)
};

return function(p3) -- Line: 15
    -- upvalues: u2 (copy), EffectsHandler (copy), u1 (copy)
    local Character = p3.Character;
    local RootPart = p3.RootPart;

    if not RootPart then
        return;
    end;

    local v4 = u2[p3.CharacterState["Rush Attack"].Count];

    if v4 then
        EffectsHandler.CallEffect("FlipbookSlash", {
            Time = 0.18,
            SurfaceDirection = "Bottom",
            Origin = RootPart.CFrame * CFrame.new(0, 0, -1.5) * v4,
            EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
            Size = Vector3.new(7, 7, 7) * Character:GetScale(),
            Color = Color3.fromRGB(472, 547, 637)
        });

        return;
    end;

    task.wait(0.05);
    EffectsHandler.CallEffect("Emit Particle V3", {
        AutoSerialize = true,
        Origin = RootPart.CFrame * CFrame.new(0, 0, -3.4) * CFrame.Angles(1.5707963267948966, 0, 0),
        Particle = u1.Pirates.Cutlass.LMBPierce,
        Scale = Character:GetScale()
    });
end;