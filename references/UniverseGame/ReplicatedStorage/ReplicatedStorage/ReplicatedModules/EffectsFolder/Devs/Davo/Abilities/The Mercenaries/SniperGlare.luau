  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(p1) -- Line: 13
    -- upvalues: ParticleHandler (copy), EffectsHandler (copy), LocalPlayer (copy), Trove (copy), AssetHandler (copy), RunService (copy)
    local Character = p1.Character;
    local Part = p1.Part;
    local u2 = workspace.Effects:FindFirstChild(Character.Name .. "Glare");

    if u2 then
        u2.Name = "Disappear";
        local u3 = ParticleHandler.EnableAllParticles(u2, false);
        task.spawn(function() -- Line: 21
            -- upvalues: EffectsHandler (ref), u3 (copy), u2 (copy)
            EffectsHandler.Wait(u3);

            if u2 then
                u2:Destroy();
            end;
        end);
    end;

    if Character == LocalPlayer.Character or p1.Remove then
        return;
    end;

    local u4 = Trove.new();
    u4:AttachToInstance(Character);
    local u5 = AssetHandler.CloneAsset("Particles/SniperGlare", {
        AbilityName = "The Mercenaries"
    });
    u5.Name = Character.Name .. "Glare";
    u5.Parent = workspace.Effects;
    u5.CFrame = Part.CFrame * (p1.Offset or CFrame.identity);
    ParticleHandler.AttachTo(u5, {
        Part = Part,
        Offset = u5.CFrame:ToObjectSpace(Part.CFrame)
    });
    ParticleHandler.EnableAllParticles(u5, false);
    local u6 = false;
    u4:Connect(RunService.Heartbeat, function() -- Line: 46
        -- upvalues: EffectsHandler (ref), u5 (copy), Character (copy), u6 (ref), ParticleHandler (ref)
        local v7 = EffectsHandler.CallEffect("IsObjectInView", u5, "Sight", 400, {
            Character,
            u5,
            workspace.Living,
            workspace.Effects
        });

        if not v7 or u6 then
            if not v7 and u6 then
                u6 = false;
                ParticleHandler.EnableAllParticles(u5, false);
            end;

            return;
        end;

        u6 = true;
        ParticleHandler.EnableAllParticles(u5, true);
    end);
    u4:Connect(u5:GetPropertyChangedSignal("Name"), function() -- Line: 56
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;