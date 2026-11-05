  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
game.ReplicatedStorage:WaitForChild("Client Assets");
game:GetService("TweenService");
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2) -- Line: 15
    -- upvalues: u1 (copy)
    local Part = p2.Part;
    local Name = p2.Name;
    local Particle = p2.Particle;
    local v3;

    if p2.Mode == nil then
        v3 = false;
    else
        v3 = p2.Mode;
    end;

    if not (Part and Part:IsDescendantOf(workspace)) then
        return;
    end;

    local v4 = Part:FindFirstChild(Name or "HandTrail");

    if not v4 then
        v4 = Particle:Clone();
        v4.Name = Name or "HandTrail";
        v4.CFrame = Part.CFrame;
        v4.Anchored = false;
        v4.CanCollide = false;
        v4.Massless = true;
        v4:SetAttribute("OriginalTransparency", v4.Transparency);
        v4.Transparency = 1;
        u1({
            Enabled = false,
            Clone = false,
            Destroy = false,
            Parent = false,
            Particle = v4,
            AbilityName = p2.AbilityName,
            SkinName = p2.SkinName,
            Player = p2.Player,
            Character = p2.Character
        });

        for _, descendant in pairs(v4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:SetAttribute("StandTrail", true);
            end;
        end;

        local Weld = Instance.new("Weld");
        Weld.Part0 = Part;
        Weld.Part1 = v4;
        Weld.C0 = p2.Offset or CFrame.identity;
        Weld.Parent = v4;
        v4.Parent = Part;
    end;

    for _, descendant in pairs(v4:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant.Enabled = v3 or false;
        end;
    end;
end;