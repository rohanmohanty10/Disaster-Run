  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), Debris (copy), EmitModule (copy), RunService (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local Folder = Instance.new("Folder");
    Folder.Name = "RinHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 0.9);
    local v2 = script.Startup:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    local u3 = script.Trail:Clone();
    u3.Parent = workspace.Debris;
    local v4 = RunService.Heartbeat:Connect(function() -- Line: 36
        -- upvalues: u3 (copy), HumanoidRootPart (copy)
        u3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, 0));
    end);
    task.wait(0.4);
    local v5 = script.DashStart:Clone();
    v5:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v5.Parent = workspace.Debris;
    EmitModule.emit(v5);
    task.wait(0.4);
    VfxManager.Enable(u3, false);
    v4:Disconnect();
    task.wait(2);
    u3:Destroy();
    Folder:Destroy();
    v5:Destroy();
end;