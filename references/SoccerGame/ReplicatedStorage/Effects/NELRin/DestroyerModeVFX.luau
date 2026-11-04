  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.EmitModule);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), Debris (copy), AbilityBalancing (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = p1.Char.HumanoidRootPart;
    local v2 = script.Aura:Clone();
    v2.Parent = workspace.Debris;
    local Weld = Instance.new("Weld");
    Weld.Parent = v2;
    Weld.Part0 = v2;
    Weld.Part1 = HumanoidRootPart;
    Debris:AddItem(v2, AbilityBalancing.DestroyerMode.Duration);
end;