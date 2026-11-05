  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
require(PathShortcuts.KnitPath.Knit);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = game.ReplicatedStorage["Client Assets"];
local u1 = { CFrame.new(0, 0.4, 0) * CFrame.Angles(0, 0.7504915783575618, -0.4363323129985824), CFrame.new(0, 0.4, 0) * CFrame.Angles(0, 0.4363323129985824, -0.4363323129985824), CFrame.new(0, 0.4, -0.25) * CFrame.Angles(0, -0.7853981633974483, 3.490658503988659) };

return function(p2) -- Line: 15
    -- upvalues: u1 (copy), EffectsHandler (copy)
    local Character = p2.Character;
    local RootPart = p2.RootPart;

    if not (RootPart and RootPart:IsDescendantOf(game)) then
        return;
    end;

    local v3 = u1[p2.CharacterState["Rush Attack"].Count];

    if v3 then
        EffectsHandler.CallEffect("FlipbookSlash", {
            Time = 0.15,
            Size = Vector3.new(10, 10, 10),
            SurfaceDirection = "Bottom",
            Origin = RootPart.CFrame * CFrame.new(0, 0, -1.5) * v3,
            EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
            Color = Color3.fromRGB(472, 547, 637)
        });

        return;
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Misc/LMBPierce",
        AbilityName = "Gryphon",
        AutoSerialize = true,
        Origin = RootPart.CFrame * CFrame.new(0, 0, -3.4) * CFrame.Angles(1.5707963267948966, 0, 0),
        Scale = Character:GetScale()
    });
end;