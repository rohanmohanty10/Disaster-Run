 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
require(ReplicatedStorage.Shared.Utility.Raycast);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: Essentials (copy), VfxManager (copy), RunService (copy)
    local Character = p2.Character;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local BallController = p1.BallController;
    local u4 = script.DASH:Clone();
    u4.Parent = workspace.Debris;
    u4:PivotTo(HumanoidRootPart.CFrame);
    Essentials:Weld(u4.PrimaryPart, HumanoidRootPart);
    VfxManager.Enable(u4, true);
    local u5 = nil;
    u5 = RunService.RenderStepped:Connect(function() -- Line: 33
        -- upvalues: BallController (copy), Character (copy), u5 (ref), VfxManager (ref), u4 (copy)
        if BallController:GetCharacterPossessingBall() ~= Character then
            return;
        end;

        u5:Disconnect();
        VfxManager.Enable(u4, false);
        task.wait(3);
        u4:Destroy();
    end);
    task.delay(4 - v3, function() -- Line: 48
        -- upvalues: u5 (ref), VfxManager (ref), u4 (copy)
        if not u5 then
            return;
        end;

        u5:Disconnect();
        VfxManager.Enable(u4, false);
        task.wait(3);
        u4:Destroy();
    end);
end;