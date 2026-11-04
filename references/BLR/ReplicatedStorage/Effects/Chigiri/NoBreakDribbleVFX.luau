  

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

    SoundManager.SpawnSound("No-break dribble new", 0.9, Char.HumanoidRootPart, 130, false);
    local v2 = script.Shot:Clone();
    v2.Parent = workspace.Debris;
    v2:PivotTo(HumanoidRootPart.CFrame);
    EmitModule.emit(v2);
    local Folder = Instance.new("Folder");
    Folder.Name = "ChigiriHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 0.7);
    task.wait(0.4);
    local u3 = script.RunEmit:Clone();
    u3.Parent = workspace.Debris;
    EmitModule.emit(u3);
    local v4 = RunService.Heartbeat:Connect(function() -- Line: 44
        -- upvalues: u3 (copy), HumanoidRootPart (copy)
        u3:PivotTo(HumanoidRootPart.CFrame);
    end);
    task.wait(2);
    v4:Disconnect();
    u3:Destroy();
    v2:Destroy();
end;