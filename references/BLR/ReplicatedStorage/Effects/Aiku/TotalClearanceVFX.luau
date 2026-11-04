  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), EmitModule (copy), VfxManager (copy), RunService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = p1.Char.HumanoidRootPart;

    if p1.Type == "Hit" then
        local v2 = script.aikutotalclearancetackle:Clone();
        v2:PivotTo(HumanoidRootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0));
        v2.Parent = workspace.Debris;
        EmitModule.emit(v2);
        task.wait(2);
        v2:Destroy();

        return;
    end;

    local u3 = script.aikutotalclearancedash1:Clone();
    u3.Parent = workspace.Debris;
    VfxManager.Enable(u3, true);
    local v4 = RunService.Heartbeat:Connect(function() -- Line: 39
        -- upvalues: u3 (copy), HumanoidRootPart (copy)
        u3:PivotTo(HumanoidRootPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    end);
    task.wait(0.5);
    VfxManager.Enable(u3, false);
    v4:Disconnect();
    task.wait(1);
    u3:Destroy();
end;