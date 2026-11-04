  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 10
    -- upvalues: Debris (copy), VfxManager (copy)
    local Char = p1.Char;
    local v2 = script.KickStartUp:Clone();
    v2:PivotTo(Char.HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    Debris:AddItem(v2, 5);
    VfxManager.Emit(v2);
    task.wait(0.3);
    local v3 = script.Kick:Clone();
    v3:PivotTo(Char.HumanoidRootPart.CFrame);
    v3.Parent = workspace.Debris;
    Debris:AddItem(v3, 5);
    VfxManager.Emit(v3);
end;