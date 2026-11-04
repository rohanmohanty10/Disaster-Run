  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: SpectatorController (copy), VfxManager (copy), Debris (copy), RunService (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v2 = script.StartupSimple:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-1.1, -2.5, -3.5));
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 2);
    local u3 = script.SideToSideDribble:Clone();
    u3.Parent = workspace.Debris;
    VfxManager.Emit(u3);
    local u4 = nil;
    u4 = RunService.Heartbeat:Connect(function() -- Line: 42
        -- upvalues: Char (copy), u4 (ref), u3 (copy), HumanoidRootPart (copy)
        if Char and Char.Parent then
            u3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, -3.5));

            return;
        end;

        u4:Disconnect();
    end);
    local Folder = Instance.new("Folder");
    Folder.Name = "NelReoHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 1.8);
    task.wait(1.2);
    local v5 = script.DirectionSwitch:Clone();
    v5:PivotTo(HumanoidRootPart.CFrame * CFrame.fromOrientation(0, 0, 0));
    v5.Parent = workspace.Debris;
    VfxManager.Emit(v5);
    Debris:AddItem(v5, 2);
    task.wait(0.3);
    local v6 = script.EndDash:Clone();
    v6:PivotTo(HumanoidRootPart.CFrame * CFrame.fromOrientation(1.5707963267948966, -1.5707963267948966, 0));
    v6.Parent = workspace.Debris;
    VfxManager.Emit(v6);
    Debris:AddItem(v6, 2);
    task.wait(0.5);
    u3:Destroy();
end;