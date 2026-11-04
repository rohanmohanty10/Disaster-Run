  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 14
    -- upvalues: Essentials (copy), Debris (copy), VfxManager (copy)
    local HumanoidRootPart = p1.Char:FindFirstChild("HumanoidRootPart");
    local v2 = {};
    local v3 = script.speedstervfxRE:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.0256500244, -0.29255271, -0.614948273, 0, 0, 1, 0, 1, 0, -1, 0, 0);
    v3.Parent = workspace.Debris;
    table.insert(v2, v3);
    Essentials:WeldOffset(HumanoidRootPart, v3, CFrame.new(-0.0256500244, -0.29255271, -0.614948273, 0, 0, 1, 0, 1, 0, -1, 0, 0));
    Debris:AddItem(v3, 8);
    VfxManager.Enable(v3, true);
    task.wait(6);
    VfxManager.Enable(v3, false);
    task.wait(1);

    for _, v in v2 do
        if v then
            v:Destroy();
        end;
    end;
end;