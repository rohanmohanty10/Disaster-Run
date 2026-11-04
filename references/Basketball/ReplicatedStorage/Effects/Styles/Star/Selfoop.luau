 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 12
    -- upvalues: VfxManager (copy)
    local Character = p2.Character;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v4 = CFrame.new(2.628, 1.131, -4.634) * CFrame.Angles(0, -3.141592653589793, 0);
    local u5 = script.Root:Clone();
    u5.Parent = workspace.Debris;
    u5.PrimaryPart.CFrame = HumanoidRootPart.CFrame * v4;
    task.delay(0.35 - v3, function() -- Line: 25
        -- upvalues: VfxManager (ref), u5 (copy)
        VfxManager.Emit(u5);
        task.wait(10);
        u5:Destroy();
    end);
end;