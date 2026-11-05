  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

local function SpecialMsg(p1, p2) -- Line: 7
    -- upvalues: EffectsHandler (copy)
    local v3 = { `You were magnificent, {p2}!`, "I won\'t forget you for as long as I live." };

    for i, v in v3 do
        EffectsHandler.CallEffect("BubbleChat", p1, v);

        if i < #v3 then
            task.wait(1);
        end;
    end;
end;

local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(p4) -- Line: 23
    -- upvalues: AssetHandler (copy), LocalPlayer (copy), EffectsHandler (copy), SpecialMsg (copy)
    local TargetCharacter = p4.TargetCharacter;
    local KillerPlayer = p4.KillerPlayer;

    if not (TargetCharacter and KillerPlayer) then
        return;
    end;

    local v5 = TargetCharacter:FindFirstChildOfClass("Humanoid");

    if v5 then
        v5 = v5:FindFirstChildOfClass("Animator");
    end;

    if not v5 then
        return;
    end;

    local u6 = math.random(1, 3);
    local u7 = v5:LoadAnimation((AssetHandler.GetAsset("Bisect/Victim" .. u6, {
        AbilityName = "KillEffects"
    })));

    if LocalPlayer == KillerPlayer or LocalPlayer == game:GetService("Players"):GetPlayerFromCharacter(TargetCharacter) then
        EffectsHandler.CallEffect("TF_WORLD_CUTTING_SLASH", {
            Attacker = KillerPlayer.Character,
            Targets = { TargetCharacter }
        });
    end;

    task.wait(1.4);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/WorldSlash/Slashed",
        AutoSerialize = true,
        AbilityName = "King of Curses",
        ScaleTo = 2,
        Origin = TargetCharacter.PrimaryPart,
        Player = KillerPlayer
    });
    u7:Play();
    task.delay(u6 == 3 and 0.4 or 0.5, function() -- Line: 56
        -- upvalues: u7 (copy), u6 (copy), SpecialMsg (ref), KillerPlayer (copy), TargetCharacter (copy)
        u7:AdjustSpeed(0);

        if u6 == 3 then
            task.spawn(function() -- Line: 60
                -- upvalues: SpecialMsg (ref), KillerPlayer (ref), TargetCharacter (ref)
                SpecialMsg(KillerPlayer.Character, TargetCharacter.Name);
            end);
        end;
    end);
end;