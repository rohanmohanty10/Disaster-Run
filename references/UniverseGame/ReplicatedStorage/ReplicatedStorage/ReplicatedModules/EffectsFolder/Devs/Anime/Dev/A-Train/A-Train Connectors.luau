  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("Players");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

function RandSign()
    return math.random(0, 2) == 1 and -1 or 1;
end;

local LocalPlayer = game.Players.LocalPlayer;

return function(p2) -- Line: 20
    -- upvalues: u1 (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy), EffectsHandler (copy), LocalPlayer (copy)
    local Character = p2.Character;
    local Attribute = p2.Attribute;
    local v3 = p2.Lifetime or 0.2;
    local Torso = Character.Torso;
    local v4 = RandSign();
    local v5 = RandSign();
    local v6 = nil;

    while true do
        v4 = v4 * -1;
        v5 = v5 * -1;
        local v7 = u1:NextNumber(0, 3.141592653589793);
        local Position = Torso.Position;
        local v8 = math.cos(v7) * u1:NextNumber(13, 16) * v4;
        local v9 = u1:NextNumber(-5, 10);
        local v10 = math.sin(v7) * u1:NextNumber(13, 16) * v5;
        local v11 = Position + Vector3.new(v8, v9, v10);

        if v6 then
            v11 = v6.Position;
        end;

        local u12 = AssetHandler.CloneAsset("Particles/Beatdown/Connector", {
            AbilityName = "UGrain"
        }):Clone();
        u12.PrimaryPart.CFrame = CFrame.new(v11, Torso.Position) * CFrame.Angles(0, 1.5707963267948966, 0);
        u12.End.CFrame = u12.PrimaryPart.CFrame;
        ParticleHandler.Unusualify(u12, {
            Character = Character
        });
        u12.Parent = workspace.Effects;
        u12.Start.Sound:Play();
        local End = u12.End;
        local v13 = TweenInfo.new(u1:NextNumber(0.04, 0.075), Enum.EasingStyle.Linear);
        local v14 = {};
        local v15;

        if v6 then
            local Position2 = Torso.Position;
            local v16 = math.cos(v7) * u1:NextNumber(8, 12) * v4;
            local v17 = u1:NextNumber(-5, 10);
            local v18 = math.sin(v7) * u1:NextNumber(8, 12) * v5;
            v15 = Position2 + Vector3.new(v16, v17, v18) or (u12.PrimaryPart.CFrame * CFrame.new(0, 0, -u1:NextNumber(14, 22))).Position;
        else
            v15 = (u12.PrimaryPart.CFrame * CFrame.new(0, 0, -u1:NextNumber(14, 22))).Position;
        end;

        v14.Position = v15;
        local v19 = TweenService:Create(End, v13, v14);
        v19:Play();
        v19.Completed:Wait();
        v6 = u12.End;
        task.delay(v3, function() -- Line: 60
            -- upvalues: ParticleHandler (ref), u12 (copy), EffectsHandler (ref)
            ParticleHandler.EnableParticle(u12, false);
            ParticleHandler.DestroyEmit(u12);
            EffectsHandler.CallEffect("FadeBeams", u12);
        end);

        if game.Players:GetPlayerFromCharacter(Character) == LocalPlayer and p2.CameraShake then
            EffectsHandler.CallEffect("Camera Shake Preset", "Explosion");
        end;

        if not (Character:IsDescendantOf(game) and Character:GetAttribute(Attribute)) then
            return;
        end;
    end;
end;