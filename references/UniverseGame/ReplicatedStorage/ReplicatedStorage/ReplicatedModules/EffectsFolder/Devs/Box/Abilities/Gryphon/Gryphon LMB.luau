  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
require(PathShortcuts.KnitPath.Knit);
local _ = game.ReplicatedStorage["Client Assets"];
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = { CFrame.new(0, 0.5, -0.25) * CFrame.Angles(-0.08726646259971647, 0.3490658503988659, -0.08726646259971647), CFrame.new(0, 0.22, 0) * CFrame.Angles(0, 0, 2.321287905152458), CFrame.new(0, 0.4, -0.25) * CFrame.Angles(0, -0.7853981633974483, 0.3490658503988659) };

return function(p2) -- Line: 17
    -- upvalues: u1 (copy), EffectsHandler (copy), AssetHandler (copy)
    local Character = p2.Character;
    local RootPart = p2.RootPart;

    if not (Character and RootPart) then
        return;
    end;

    local Count = p2.CharacterState["Rush Attack"].Count;
    local v3 = u1[Count];

    if Count >= 4 then
        EffectsHandler.CallEffect("Emit Particle V3", {
            AutoSerialize = true,
            Origin = RootPart.CFrame * CFrame.new(0, 0, -3.4) * CFrame.Angles(1.5707963267948966, 0, 0),
            Particle = AssetHandler.GetAsset("Particles/Misc/LMBPierce", p2),
            Scale = Character:GetScale()
        });

        return;
    end;

    EffectsHandler.CallEffect("FlipbookSlash", {
        Time = 0.18,
        Size = Vector3.new(9, 9, 9),
        SurfaceDirection = "Bottom",
        Origin = RootPart.CFrame * CFrame.new(0, 0, -1.5) * v3,
        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
        Color = Color3.fromRGB(472, 547, 637)
    });
end;