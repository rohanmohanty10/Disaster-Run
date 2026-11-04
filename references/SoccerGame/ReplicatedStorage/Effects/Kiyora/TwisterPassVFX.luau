  

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
    -- upvalues: SpectatorController (copy), EmitModule (copy), RunService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local v2 = script.StartupSimple:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    local Folder = Instance.new("Folder");
    Folder.Name = "KiyoraHighlight";
    Folder.Parent = Char;

    if p1.Type == "Steal" then
        task.wait(0.3);
        local u3 = script.SideToSideDribble:Clone();
        u3:PivotTo(HumanoidRootPart.CFrame);
        u3.Parent = workspace.Debris;
        EmitModule.emit(u3);
        local v4 = RunService.Heartbeat:Connect(function() -- Line: 41
            -- upvalues: u3 (copy), HumanoidRootPart (copy)
            u3:PivotTo(HumanoidRootPart.CFrame);
        end);
        task.wait(1);
        v4:Disconnect();
        u3:Destroy();
    else
        task.wait(1.4);
        local v5 = script.Hit4Emit:Clone();
        v5:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
        v5.Parent = workspace.Debris;
        EmitModule.emit(v5);
        task.wait(1);
        v5:Destroy();
    end;

    Folder:Destroy();
    v2:Destroy();
end;