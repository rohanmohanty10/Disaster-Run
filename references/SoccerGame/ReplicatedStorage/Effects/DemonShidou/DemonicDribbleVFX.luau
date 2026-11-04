  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 14
    -- upvalues: SoundManager (copy), VfxManager (copy), Debris (copy), Essentials (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    SoundManager.SpawnSound("DemonicDribble", 0.9, Char.HumanoidRootPart, 130, false);
    task.wait(0.38);
    local v3 = script.Dashie:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.142410278, -0.00161552429, -1.77278137, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 3);
    local v4 = script.Enabled:Clone();
    v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.545639515, -1.05105257, -2.39554596, 0, 0, 1, 0, 1, 0, -1, 0, 0);
    v4.Parent = HumanoidRootPart;
    table.insert(u2, v4);
    Essentials:WeldOffset(HumanoidRootPart, v4, CFrame.new(-0.545639515, -1.05105257, -2.39554596, 0, 0, 1, 0, 1, 0, -1, 0, 0));
    VfxManager.Enable(v4, true);
    Debris:AddItem(v4, 3);
    task.wait(0.84);
    VfxManager.Enable(v4, false);
    task.delay(3, function() -- Line: 43
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;