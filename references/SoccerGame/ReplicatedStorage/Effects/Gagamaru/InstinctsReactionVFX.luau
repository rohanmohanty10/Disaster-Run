  

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
    -- upvalues: SpectatorController (copy), RunService (copy), EmitModule (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local u2 = script.SideToSideDribble:Clone();
    u2.Parent = workspace.Debris;
    local u3 = p1.Dir == "Forward" and true or (p1.Dir == "Back" and 0 or 1.5707963267948966);
    local u4 = nil;
    u4 = RunService.Heartbeat:Connect(function() -- Line: 27
        -- upvalues: Char (copy), u4 (ref), u2 (copy), HumanoidRootPart (copy), u3 (copy)
        if Char and Char.Parent then
            u2.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, u3, 0);

            return;
        end;

        u4:Disconnect();
    end);
    EmitModule.emit(u2);
    task.wait(0.6);
    u4:Disconnect();
    task.wait(1);
    u2:Destroy();
end;