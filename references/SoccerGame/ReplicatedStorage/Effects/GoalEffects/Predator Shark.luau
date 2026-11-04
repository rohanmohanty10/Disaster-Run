  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
Random.new(os.clock());

return function(p1) -- Line: 11
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy)
    local LocalPlayer = game.Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and (LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        return;
    end;

    local u2 = script.WaterEffect:Clone();
    u2.Parent = workspace.Debris;
    u2:PivotTo(workspace.Field.Field:GetPivot());
    local u3 = ReplicatedStorage.Assets.Misc.PredatorSharkModel:Clone();
    u3.Parent = workspace.Debris;
    u3:ScaleTo(1.5);
    local v4 = u3.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.Emotes["Predator Ride Shark"]);
    v4.Looped = true;
    v4:Play();
    local u5 = 0;
    local Position = workspace.Field.Field.Position;
    local u6 = Position.Y + 15;
    local u10 = game:GetService("RunService").RenderStepped:Connect(function(p7) -- Line: 29
        -- upvalues: u5 (ref), u3 (copy), Position (copy), u6 (copy)
        u5 = u5 + p7 * 100;
        local CFrame_new = CFrame.new;
        local math_rad_ret = math.rad(u5);
        local v8 = math.cos(math_rad_ret) * 50;
        local math_rad_ret2 = math.rad(u5);
        local v9 = math.sin(math_rad_ret2) * 50;
        u3:PivotTo(CFrame_new(Position + Vector3.new(v8, u6, v9), Position + Vector3.new(0, 15, 0)) * CFrame.Angles(0, -1.5707963267948966, 0));
    end);
    task.delay(8, function() -- Line: 34
        -- upvalues: u2 (copy), u10 (copy), u3 (copy)
        u2:Destroy();
        u10:Disconnect();
        u3:Destroy();
    end);
end;