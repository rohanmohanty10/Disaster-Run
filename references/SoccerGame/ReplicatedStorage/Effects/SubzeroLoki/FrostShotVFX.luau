  

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
    SoundManager.SpawnSound("FrostShot", 0.9, Char.HumanoidRootPart, 130, false);
    task.wait(0.35);
    local v3 = script.emit:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.141830444, -1.66709614, -3.5, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    EmitModule.emit(v3);
    task.delay(3, function() -- Line: 27
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;