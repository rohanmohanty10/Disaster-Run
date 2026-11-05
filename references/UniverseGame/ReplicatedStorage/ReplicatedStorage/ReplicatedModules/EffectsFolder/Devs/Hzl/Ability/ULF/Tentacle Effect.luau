  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
require(game.ReplicatedStorage.ReplicatedModules.Types);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: Trove (copy), AssetHandler (copy), ParticleHandler (copy)
    local Character = p1.Character;
    local Reference = p1.Reference;

    if not (Character and Reference) then
        return;
    end;

    local Side = p1.Side;
    local Offset = p1.Offset;
    local v2 = Trove.new();
    v2:AttachToInstance(Reference);
    local u3 = Character:FindFirstChild((`{Side} Arm`));

    if not u3 then
        return;
    end;

    u3.Transparency = 1;
    v2:Add(function() -- Line: 23
        -- upvalues: u3 (copy)
        if u3 then
            u3.Transparency = 0;
        end;
    end);
    local v4 = v2:Add(AssetHandler.CloneAsset("Models/" .. (Side == "Left" and "LeftTentacle" or "RightTentacle"), {
        AbilityName = "Ultimate Life Form"
    }));
    v4.Parent = Character;
    local v5 = v4:FindFirstChildWhichIsA("BasePart");

    if v5 then
        v5.Color = u3.Color;
        v2:Add((ParticleHandler.AttachTo(v5, {
            UseMotor6D = true,
            MakePartP0 = true,
            Part = u3,
            C0 = Offset
        })));
    end;
end;