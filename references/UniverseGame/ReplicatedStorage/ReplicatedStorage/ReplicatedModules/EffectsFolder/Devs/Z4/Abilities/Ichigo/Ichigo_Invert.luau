  

 

local _ = game.Players.LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local LocalPlayer = Players.LocalPlayer;
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function() -- Line: 15
    -- upvalues: LocalPlayer (copy), Lighting (copy), AssetHandler (copy)
    local Settings = LocalPlayer:FindFirstChild("Settings");

    if Settings and Settings.ImpactFrame.Value then
        local u1 = {};

        for _, child in Lighting:GetChildren() do
            if child:IsA("ColorCorrectionEffect") then
                u1[child] = child.Enabled;
                child.Enabled = false;
            end;
        end;

        local u2 = AssetHandler.GetAsset("Particles/Mes/Invert", {
            AbilityName = "Ope"
        }):Clone();
        u2.Parent = Lighting;
        task.delay(0.1, function() -- Line: 31
            -- upvalues: u2 (copy), u1 (copy)
            u2:Destroy();

            for i, v in u1 do
                if i:IsDescendantOf(game) and i.Enabled ~= v then
                    i.Enabled = v;
                end;
            end;
        end);
    end;
end;