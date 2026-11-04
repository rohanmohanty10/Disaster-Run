  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
Random.new(os.clock());

return function(p1) -- Line: 11
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), VfxManager (copy)
    local LocalPlayer = game.Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and (LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        return;
    end;

    local u2 = ReplicatedStorage.Assets.GoalEffects["Water Park"].Main:Clone();
    u2.Parent = workspace.Debris;
    u2:PivotTo(workspace.Field.Field:GetPivot() * CFrame.new(0, 14, 0));
    local u3 = ReplicatedStorage.Assets.GoalEffects["Water Park"].MainModels:Clone();
    u3.Parent = workspace.Debris;
    u3:PivotTo(workspace.Field.Field:GetPivot());
    local u4 = ReplicatedStorage.Assets.GoalEffects["Water Park"].VFX:Clone();
    u4.Parent = workspace.Debris;
    u4:PivotTo(p1.Pos);
    VfxManager.Emit(u4);
    task.delay(8, function() -- Line: 34
        -- upvalues: u3 (copy), u2 (copy), u4 (copy)
        u3:Destroy();
        u2:Destroy();
        u4:Destroy();
    end);
end;