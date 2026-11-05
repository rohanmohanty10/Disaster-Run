  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
game.ReplicatedStorage:WaitForChild("Client Assets");
local TweenService = game:GetService("TweenService");
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3, p4, p5) -- Line: 15
    -- upvalues: AssetHandler (copy), u1 (copy), GenericModule (copy), TweenService (copy)
    if not (p2 and p2:IsDescendantOf(workspace)) then
        return;
    end;

    local u6 = p2:FindFirstChild(p4 or "HandTrail");

    if not u6 then
        u6 = AssetHandler.CloneAsset("Particles/" .. (p4 or "HandTrail"), p5);
        u6.CFrame = p2.CFrame;
        u6.Anchored = false;
        u6.CanCollide = false;
        u6.Massless = true;
        u6:SetAttribute("OriginalTransparency", u6.Transparency);
        u6.Transparency = 1;
        u1({
            Enabled = false,
            Clone = false,
            Destroy = false,
            Parent = false,
            Particle = u6,
            AbilityName = p5.AbilityName,
            SkinName = p5.SkinName,
            Player = p5.Player,
            Character = p5.Character
        });

        for _, descendant in pairs(u6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:SetAttribute("StandTrail", true);
            end;
        end;

        local Weld = Instance.new("Weld");
        Weld.Part0 = p2;
        Weld.Part1 = u6;
        Weld.C0 = p5.Offset or CFrame.identity;
        Weld.Parent = u6;
        u6.Parent = p2;
    end;

    if p3 then
        for _, descendant in pairs(u6:GetDescendants()) do
            if (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail"))) and (descendant.Name:match("Summon") or descendant.Parent.Name:match("Summon")) then
                GenericModule.Emit(descendant);
            end;
        end;
    end;

    for _, descendant in pairs(u6:GetDescendants()) do
        if (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail"))) and not (descendant.Name:match("Summon") or descendant.Parent.Name:match("Summon")) then
            descendant.Enabled = p3 or false;
        end;
    end;

    local v7 = TweenService:Create(u6, TweenInfo.new(p5.TweenTime or (u6:GetAttribute("TweenTime") or 0.25)), {
        Transparency = p3 == true and (u6:GetAttribute("OriginalTransparency") or 1) or 1
    });
    v7.Completed:Connect(function() -- Line: 77
        -- upvalues: u6 (ref)
        if u6.Transparency == 1 then
            u6:Destroy();
        end;
    end);
    v7:Play();
end;