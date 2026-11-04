  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), RunService (copy), EmitModule (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = p1.Char.HumanoidRootPart;
    local u2 = script["BLR Cannon Rig"]:Clone();
    u2.Parent = workspace.Debris;
    u2.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Abilities.GingerbreadCannonRig):Play();
    local v3 = RunService.Heartbeat:Connect(function() -- Line: 27
        -- upvalues: u2 (copy), HumanoidRootPart (copy)
        u2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0));
    end);
    task.wait(1.1);
    local v4 = script.CannonShotEmit:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame * CFrame.new(3.0199737548828125, 5.000008583068848, -0.004978179931640625) * CFrame.Angles(0, 1.5707963267948966, 0));
    v4.Parent = HumanoidRootPart;
    EmitModule.emit(v4);
    task.wait(0.73);
    v3:Disconnect();
    u2:Destroy();
    task.wait(2);
    v4:Destroy();
end;