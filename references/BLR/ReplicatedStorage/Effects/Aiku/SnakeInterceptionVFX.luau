  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: SoundManager (copy), EmitModule (copy), Debris (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if p1.Hit then
        SoundManager.SpawnSound("SnakeInterceptionHit", 0.9, Char.HumanoidRootPart, 130, false);
        local v2 = script.snakeinterceptionemit:Clone();
        v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.359019279, 1.88812017, -2.07549572, 0, 0, -1, 1, 0, 0, 0, -1, 0);
        v2.Parent = workspace.Debris;
        EmitModule.emit(v2);
        Debris:AddItem(v2, 3);

        return;
    end;

    local u3 = {};
    SoundManager.SpawnSound("SnakeInterception", 0.9, Char.HumanoidRootPart, 130, false);
    local v4 = script.snakeinterceptiondust:Clone();
    v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.359019279, -2.15923309, -1.04187012, 0, 0, -1, 1, 0, 0, 0, -1, 0);
    v4.Parent = workspace.Debris;
    table.insert(u3, v4);
    EmitModule.emit(v4);
    Debris:AddItem(v4, 3);
    task.delay(3, function() -- Line: 40
        -- upvalues: u3 (copy)
        for _, v in u3 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;