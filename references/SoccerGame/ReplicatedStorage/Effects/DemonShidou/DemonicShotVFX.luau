  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 14
    -- upvalues: SoundManager (copy), VfxManager (copy), Debris (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    task.wait(0.3);
    SoundManager.SpawnSound("DemonicShot", 0.9, Char.HumanoidRootPart, 130, false);
    task.wait(1.45);
    local v3 = script.Kick:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.00375938416, 0.33239603, -0.666435242, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 3);
    task.delay(3, function() -- Line: 34
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;