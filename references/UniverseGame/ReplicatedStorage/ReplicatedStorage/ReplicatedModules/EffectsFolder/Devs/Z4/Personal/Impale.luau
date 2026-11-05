  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local LocalPlayer = Players.LocalPlayer;
local u1 = ReplicatedStorage["Client Assets"];

return function(p2) -- Line: 10
    -- upvalues: Players (copy), LocalPlayer (copy), EffectsHandler (copy), u1 (copy), ParticleHandler (copy)
    local v3 = p2 or {};
    local Character = v3.Character;
    local Target = v3.Target;
    local v4 = v3.Path or "Particles/Impale";
    local v5 = v3.AbilityName or "The World: High Voltage";
    local SkinName = v3.SkinName;
    local v6 = v3.Offset or CFrame.identity;

    if not (Character or Target) then
        warn("no target / attacker provided");

        return;
    end;

    local Torso = Target:FindFirstChild("Torso");

    if Torso == nil then
        return;
    end;

    local v7 = { Players:GetPlayerFromCharacter(Character), Players:GetPlayerFromCharacter(Target) };

    if table.find(v7, LocalPlayer) then
        EffectsHandler.CallEffect("Camera Shake Preset", "Explosion");
        EffectsHandler.CallEffect("Vignette Gui", {
            TweenTime = 0.3,
            Blur = 8,
            StartingColor = Color3.fromRGB(124, 0, 2),
            EndingColor = Color3.fromRGB(62, 12, 13)
        });
    end;

    EffectsHandler.CallEffect("Standalone_RingStroke", {
        Duration = 0.6,
        Thickness = { 35, 75 },
        CFrame = Torso.CFrame * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966),
        Size = { 2, 25 },
        Color = Color3.fromRGB(176, 0, 0)
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        AutoSerialize = true,
        AttachTo = {
            Part = Torso,
            Offset = CFrame.identity * v6
        },
        Character = Character,
        Player = Players:GetPlayerFromCharacter(Character),
        AbilityName = v5,
        SkinName = SkinName,
        Path = v4
    });
    EffectsHandler.CallEffect("Blood Rays", {
        Part = Torso,
        TrailRange = NumberRange.new(6, 9)
    });

    if LocalPlayer.Settings.Gore.Value == true and (not Torso:GetAttribute("NoRays") and Torso.Transparency == 0) then
        Torso.Transparency = 1;
        local u8 = u1["The World"].ImpaleTorso:Clone();
        u8.Color = Torso.Color;
        u8.Parent = workspace.Effects;
        task.delay(5, function() -- Line: 72
            -- upvalues: Torso (copy), u8 (copy)
            Torso.Transparency = 0;
            u8:Destroy();
        end);
        ParticleHandler.AttachTo(u8, {
            Part = Torso
        });

        if Target:FindFirstChildOfClass("Shirt") then
            local v9 = next;
            local v10, v11 = u8:GetChildren();

            for _, v in v9, v10, v11 do
                if v:IsA("Texture") then
                    v.Texture = Target:FindFirstChildOfClass("Shirt").ShirtTemplate;
                end;
            end;
        end;
    end;
end;