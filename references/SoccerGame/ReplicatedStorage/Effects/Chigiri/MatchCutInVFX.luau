  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), SoundManager (copy), EmitModule (copy), Debris (copy), RunService (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    SoundManager.SpawnSound("MACH CUT IN", 0.9, Char.HumanoidRootPart, 130, false);
    local v2 = script.TPDash:Clone();
    v2.Parent = workspace.Debris;
    v2:PivotTo(HumanoidRootPart.CFrame);
    EmitModule.emit(v2);
    local Folder = Instance.new("Folder");
    Folder.Name = "ChigiriHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 1.2);
    task.wait(0.2);
    local v3 = script.TPDash2:Clone();
    v3.Parent = workspace.Debris;
    v3:PivotTo(HumanoidRootPart.CFrame);
    EmitModule.emit(v3);
    task.wait(0.4);
    local u4 = script.RunEmit:Clone();
    u4.Parent = workspace.Debris;
    EmitModule.emit(u4);
    local v5 = RunService.Heartbeat:Connect(function() -- Line: 52
        -- upvalues: u4 (copy), HumanoidRootPart (copy)
        u4:PivotTo(HumanoidRootPart.CFrame);
    end);
    task.wait(0.6);
    task.wait(2);
    v5:Disconnect();
    u4:Destroy();
    v2:Destroy();
    v3:Destroy();
end;