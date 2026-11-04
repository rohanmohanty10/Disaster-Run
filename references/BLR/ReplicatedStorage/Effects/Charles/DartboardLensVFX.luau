  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
local Players = game:GetService("Players");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 19
    local u2 = {};
    local u3 = {};
    task.spawn(function() -- Line: 23
        -- upvalues: u2 (copy), u3 (copy)
        local v4 = script.GoalFX:Clone();
        v4.Parent = workspace.Debris;

        for _, child in pairs(game:GetService("Lighting"):GetChildren()) do
            local v5 = child:Clone();
            table.insert(u2, v5);
            child:Destroy();
        end;

        for _, child in pairs(script.Lighting:GetChildren()) do
            local v6 = child:Clone();
            v6.Parent = game:GetService("Lighting");
            table.insert(u3, v6);
        end;

        task.wait(20);
        v4:Destroy();

        for _, v in pairs(u3) do
            v:Destroy();
        end;

        for _, v in pairs(u2) do
            v.Parent = game:GetService("Lighting");
        end;
    end);
end;