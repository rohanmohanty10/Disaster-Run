  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 13
    -- upvalues: SpectatorController (copy)
    if game.Players.LocalPlayer.Team ~= game.Teams.Visitor or SpectatorController.IsSpectating then
        return;
    end;

    table.clear(p1);
end;