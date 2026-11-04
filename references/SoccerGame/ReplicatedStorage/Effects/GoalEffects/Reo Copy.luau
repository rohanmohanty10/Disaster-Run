  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
Random.new(os.clock());

return function(p1) -- Line: 11
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), VfxManager (copy)
    local LocalPlayer = game.Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and (LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        return;
    end;

    local u2 = ReplicatedStorage.Assets.GoalEffects["Reo Copy"].GlassImpact:Clone();
    u2.CFrame = p1.Pos;
    u2.Parent = workspace.Debris;
    VfxManager.Emit(u2);
    local u3 = ReplicatedStorage.Assets.GoalEffects["Reo Copy"].ReoGoal:Clone();
    u3.Parent = workspace.Debris;
    VfxManager.Emit(u3);
    task.delay(8, function() -- Line: 24
        -- upvalues: u2 (copy), u3 (copy)
        u2:Destroy();
        u3:Destroy();
    end);
end;