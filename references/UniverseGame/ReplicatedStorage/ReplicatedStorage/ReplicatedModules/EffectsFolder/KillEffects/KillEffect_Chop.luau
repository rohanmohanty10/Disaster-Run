  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);

return function(p1) -- Line: 10
    -- upvalues: EffectsHandler (copy)
    local v2 = p1 or {};
    local TargetCharacter = v2.TargetCharacter;
    local KillerPlayer = v2.KillerPlayer;

    if not TargetCharacter then
        return;
    end;

    local v3 = TargetCharacter:FindFirstChildWhichIsA("Shirt");
    local v4 = TargetCharacter:FindFirstChildWhichIsA("BodyColors") or {
        RightArmColor3 = Color3.fromRGB(255, 205, 144),
        LeftArmColor3 = Color3.fromRGB(255, 205, 144)
    };
    local v5 = script.Container:Clone();
    v5.Parent = TargetCharacter;

    if v3 then
        v3:Clone().Parent = v5;
    end;

    if KillerPlayer and KillerPlayer.Data.Ability.Value == 27 then
        task.spawn(EffectsHandler.CallEffect, "Taunt", KillerPlayer.Character, { "I must bring all lose ends to a close.", "rbxassetid://1", {}, 1.5, 2 }, true);
    end;

    for _, v in { TargetCharacter["Left Arm"], TargetCharacter["Right Arm"] } do
        local v6 = v.Name ~= "Left Arm" and v4.RightArmColor3 or v4.LeftArmColor3;
        local v7 = v5:FindFirstChild(v.Name);
        v7.Color = v6;
        v7.CFrame = v.CFrame;
        v7.CollisionGroup = "Ghosted";
        v7.CanCollide = true;
        v.Transparency = 1;
        v7.Transparency = 0;
        local v8 = next;
        local v9, v10 = v:GetDescendants();

        for _, v11 in v8, v9, v10 do
            if v11:IsA("Decal") or (v11:IsA("BasePart") or v11:IsA("Texture")) then
                v11.Transparency = 1;
            elseif v11:IsA("ParticleEmitter") or (v11:IsA("Beam") or v11:IsA("Trail") and v11.Enabled == true) then
                v11.Enabled = false;
            end;
        end;
    end;
end;