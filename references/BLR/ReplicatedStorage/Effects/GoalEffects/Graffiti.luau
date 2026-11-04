  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
Random.new(os.clock());

return function(p1) -- Line: 11
    -- upvalues: SpectatorController (copy), VfxManager (copy)
    local LocalPlayer = game.Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and (LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        return;
    end;

    local u2 = script.GoalEffectMain:Clone();
    u2.Parent = workspace.Debris;
    u2:PivotTo(p1.Pos);
    VfxManager.Emit(u2.Emit);
    VfxManager.Enable(u2.Enable, true);
    task.wait(1);
    VfxManager.Enable(u2.Enable, false);
    task.delay(8, function() -- Line: 23
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
end;