  

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

    local u2 = script.GoalEffectField:Clone();
    u2.Parent = workspace.Debris;
    u2:PivotTo(workspace.Field.Field:GetPivot());
    VfxManager.Enable(u2, true);
    local u3 = script.GoalEffectMain:Clone();
    u3.Parent = workspace.Debris;
    u3:PivotTo(p1.Pos);
    VfxManager.Emit(u3);
    task.delay(8, function() -- Line: 25
        -- upvalues: u2 (copy), u3 (copy)
        u2:Destroy();
        u3:Destroy();
    end);
end;