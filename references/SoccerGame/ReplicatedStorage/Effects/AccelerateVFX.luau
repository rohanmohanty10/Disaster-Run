  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: EmitModule (copy), Debris (copy)
    local HumanoidRootPart = p1.Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    local v3 = script.chigiriacceleratevfx:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.0193367004, -0.757774115, 1.18559837, -1, 0, 0, 0, 1, 0, 0, 0, -1);
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    EmitModule.emit(v3);
    Debris:AddItem(v3, 3);
    task.delay(3, function() -- Line: 32
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;