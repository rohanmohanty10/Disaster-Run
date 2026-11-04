 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = game.Players.LocalPlayer;

for _, child in ReplicatedStorage.Assets.StarterUI:GetChildren() do
    child:Clone().Parent = LocalPlayer.PlayerGui;
end;

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait();
end;

for _, descendant in pairs(ReplicatedStorage.Controllers:GetDescendants()) do
    if descendant:IsA("ModuleScript") then
        require(descendant);
    end;
end;

Knit.Start({
    ServicePromises = false
}):catch(warn):andThen(function() -- Line: 23
    -- upvalues: Knit (copy)
    game:GetService("ReplicatedFirst").KnitReady.Value = true;
    Knit.GetService("PlayerService").Ready:Fire();
end);