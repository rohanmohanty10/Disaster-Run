  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 8
    -- upvalues: Essentials (copy), VfxManager (copy)
    local Char = p1.Char;
    Char:SetAttribute("flashColor", Color3.fromRGB(47, 193, 255));
    Char:SetAttribute("flashTimestamp", workspace:GetServerTimeNow());
    local v2 = script.TargetVfx:Clone();
    v2.CFrame = Char.HumanoidRootPart.CFrame;
    v2.Parent = workspace.Debris;
    local v3 = Essentials:Weld(Char.HumanoidRootPart, v2);
    VfxManager.Emit(v2);
    task.wait(1);
    v2:Destroy();
    v3:Destroy();
end;