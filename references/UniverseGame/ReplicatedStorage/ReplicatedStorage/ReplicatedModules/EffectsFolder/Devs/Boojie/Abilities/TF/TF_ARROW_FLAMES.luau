  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
game:GetService("TweenService");
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2) -- Line: 18
    -- upvalues: AssetHandler (copy), u1 (copy)
    local v3 = p2 or {};
    local Character = v3.Character;
    local v4 = v3.Mode or false;
    local _ = v3.Beams or false;
    local v5 = Character:FindFirstChild("Left Arm");
    local v6;

    if v5 then
        v6 = v5:FindFirstChild("Flames");
    else
        v6 = v5;
    end;

    if v5 and not v6 then
        v6 = AssetHandler.CloneAsset("Particles/Open/LeftArm", v3);
        v6.Name = "Flames";
        v6:PivotTo(v5.CFrame);
        u1({
            Enabled = false,
            Clone = false,
            Destroy = false,
            Parent = false,
            Particle = v6,
            AbilityName = v3.AbilityName,
            SkinName = v3.SkinName,
            Player = v3.Player,
            Character = v3.Character
        });
        local Weld = Instance.new("Weld");
        Weld.Part0 = v5;
        Weld.Part1 = v6.PrimaryPart;
        Weld.Parent = v6.PrimaryPart;
        v6.Parent = v5;
    end;

    local v7 = Character:FindFirstChild("Right Arm");
    local v8;

    if v7 then
        v8 = v7:FindFirstChild("Flames");
    else
        v8 = v7;
    end;

    if v7 and not v8 then
        v8 = AssetHandler.CloneAsset("Particles/Open/RightArm", v3);
        v8.Name = "Flames";
        v8:PivotTo(v7.CFrame);
        u1({
            Enabled = false,
            Clone = false,
            Destroy = false,
            Parent = false,
            Particle = v8,
            AbilityName = v3.AbilityName,
            SkinName = v3.SkinName,
            Player = v3.Player,
            Character = v3.Character
        });
        local Weld = Instance.new("Weld");
        Weld.Part0 = v7;
        Weld.Part1 = v8.PrimaryPart;
        Weld.Parent = v8.PrimaryPart;
        local v9;

        if v6 then
            v9 = v6:FindFirstChild("BEAM ATTACH", true);
        else
            v9 = v6;
        end;

        local v10;

        if v8 then
            v10 = v8:FindFirstChild("BEAM ATTACH", true);
        else
            v10 = v8;
        end;

        if v9 and v10 then
            for _, descendant in pairs(v8:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Attachment0 = v10;
                    descendant.Attachment1 = v9;
                end;
            end;
        end;

        v8.Parent = v7;
    end;

    for _, descendant in pairs(v6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            local v11;

            if descendant:IsA("Beam") and v4 then
                v11 = v3.Beams;
            else
                v11 = v4;
            end;

            descendant.Enabled = v11 or false;
        end;
    end;

    for _, descendant in pairs(v8:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            local v12;

            if descendant:IsA("Beam") and v4 then
                v12 = v3.Beams;
            else
                v12 = v4;
            end;

            descendant.Enabled = v12 or false;
        end;
    end;
end;