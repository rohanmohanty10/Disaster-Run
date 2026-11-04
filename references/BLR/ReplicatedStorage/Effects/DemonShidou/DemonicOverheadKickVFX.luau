  

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
    SoundManager.SpawnSound("DemonicOverheadKick", 0.9, Char.HumanoidRootPart, 130, false);
    local u2 = {};
    task.wait(0.28);
    local v3 = script.Smoke:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.323523462, -1.69097757, -1.29146576, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 3);
    task.wait(0.24);
    local v4 = script.Kick:Clone();
    v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.747760773, 0.625253439, -3.30220032, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v4.Parent = workspace.Debris;
    table.insert(u2, v4);
    VfxManager.Emit(v4);
    Debris:AddItem(v4, 3);
    task.delay(3, function() -- Line: 40
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;