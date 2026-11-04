  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.TeamJerseys);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local LocalPlayer = Players.LocalPlayer;
local u1 = tick();

return function(p2) -- Line: 18
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), ReplicatedStorage (copy), u1 (ref)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Name = LocalPlayer.Team.Name;
    local GK = (ReplicatedStorage.Teams:FindFirstChild(Name) or ReplicatedStorage.Teams:FindFirstChild((`{Name}Team`))):FindFirstChild("GK");

    if GK and GK.Value == game.Players.LocalPlayer then
        return;
    end;

    if u1 > tick() then
        return;
    end;

    u1 = tick() + 3;
end;