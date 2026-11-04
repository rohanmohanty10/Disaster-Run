 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: Debris (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Model = Instance.new("Model");
    Model.Parent = Debris;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v4 = Character:FindFirstChild(child.Name);

        if v4 then
            local v5 = child:Clone();
            v5.CFrame = v4.CFrame;
            v5.Parent = Model;
            Essentials:Weld(v5, v4);
        end;
    end;

    task.wait(2 - v3);
    Model:Destroy();
end;