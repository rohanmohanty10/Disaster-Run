  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), Debris (copy), VfxManager (copy), RunService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local State = p1.State;
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if State ~= "Start" then
        if State == "Steal" then
            local v2 = script.Startup:Clone();
            v2.Parent = workspace.Debris;
            v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
            VfxManager.Emit(v2);
            task.wait(0.4);
            local v3 = script.Startup:Clone();
            v3.Parent = workspace.Debris;
            v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
            VfxManager.Emit(v3);
            task.wait(1);
            v2:Destroy();
            v3:Destroy();
        end;

        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "RaichiHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 3);
    local v4 = script.Startup:Clone();
    v4.Parent = workspace.Debris;
    v4:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    VfxManager.Emit(v4);
    local u5 = script.Particles:Clone();
    VfxManager.Enable(u5, true);
    u5.Parent = workspace.Debris;
    local v6 = RunService.Heartbeat:Connect(function() -- Line: 38
        -- upvalues: u5 (copy), HumanoidRootPart (copy)
        u5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 1.5707963267948966, 0);
    end);
    task.wait(3);
    Folder:Destroy();
    v6:Disconnect();
    v4:Destroy();
    VfxManager.Enable(u5, false);
    task.wait(1);
    u5:Destroy();
end;