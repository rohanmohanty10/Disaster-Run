  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: Debris (copy), EmitModule (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    local Folder = Instance.new("Folder");
    Folder.Name = "BachiraHighlight";
    Folder.Parent = Char;
    table.insert(u2, Folder);
    Debris:AddItem(Folder, 0.6);
    task.wait(0.6);
    local v3 = script.scissorshotVFXemit:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(
        -1.73699164,
        0.111960649,
        -2.74611926,
        -1,
        0,
        0,
        0,
        0.00298897317,
        -0.999995708,
        0,
        -0.999995708,
        -0.00298897317
    );
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    EmitModule.emit(v3);
    Debris:AddItem(v3, 3);
    task.delay(3, function() -- Line: 38
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;