  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
require(ReplicatedStorage.Controllers.CameraController);

return function(p1) -- Line: 11
    -- upvalues: SoundManager (copy), EmitModule (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    SoundManager.SpawnSound("FrostAcceleration", 0.9, Char.HumanoidRootPart, 130, false);
    task.wait(0.4);
    local v3 = script.GroundFX:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.366638184, -2, -1.04534912, 0, 0, -1, -1, 0, 0, 0, 1, 0);
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    EmitModule.emit(v3);
    task.wait(0.4);
    local v4 = script.Startup:Clone();
    v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.314025879, -2.81917524, 1.36401367, 0, 0, 1, 0, 1, 0, -1, 0, 0);
    v4.Parent = workspace.Debris;
    table.insert(u2, v4);
    EmitModule.emit(v4);
    task.wait(0.17);
    local v5 = script.Dash2:Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.0553970337, 0.0714998245, -8.59462643, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v5.Parent = workspace.Debris;
    table.insert(u2, v5);
    EmitModule.emit(v5);
    task.delay(3, function() -- Line: 43
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;