  

 

game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
require(ReplicatedStorage.ClientLibrary.Fusion);
local _ = game:GetService("Players").LocalPlayer;

return function(p1) -- Line: 12
    -- upvalues: TweenService (copy)
    local v2;

    if p1 then
        v2 = p1:FindFirstChild("HumanoidRootPart");
    else
        v2 = nil;
    end;

    if not v2 then
        return;
    end;

    local v3 = p1:WaitForChild("Khronos Walker", 2.5);

    if not v3 then
        return;
    end;

    local Hatch = v3:WaitForChild("Mech", 1):WaitForChild("Main", 1):WaitForChild("Hatch", 1);

    if not Hatch then
        return;
    end;

    local v4 = Hatch:FindFirstChildOfClass("Motor6D");

    if not v4 then
        return;
    end;

    local C0 = v4.C0;
    v4.C0 = C0 * CFrame.Angles(1.5707963267948966, 0, 0);
    task.wait(0.75);

    if not v3.Parent then
        return;
    end;

    TweenService:Create(v4, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        C0 = C0
    }):Play();
end;