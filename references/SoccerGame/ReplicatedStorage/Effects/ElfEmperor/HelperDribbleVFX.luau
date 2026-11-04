  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: EmitModule (copy), Debris (copy), Essentials (copy)
    local Elf = p1.Elf;
    local HumanoidRootPart = p1.Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    task.wait(0.38);
    local v3 = script.elfhelperkick1:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(
        1.04834747,
        -2.14171672,
        -3.61890411,
        0.939692616,
        0,
        -0.342020124,
        0,
        1,
        0,
        0.342020124,
        0,
        0.939692616
    );
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    EmitModule.emit(v3);
    Debris:AddItem(v3, 3);
    task.wait(0.14);
    local v4 = script.elfhelperdash:Clone();
    v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.295600891, -0.708960056, -0.596036911, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v4.Parent = workspace.Debris;
    table.insert(u2, v4);
    EmitModule.emit(v4);
    Essentials:WeldOffset(HumanoidRootPart, v4, CFrame.new(0.295600891, -0.708960056, -0.596036911, 1, 0, 0, 0, 1, 0, 0, 0, 1));
    Debris:AddItem(v4, 3);
    task.wait(0.6);
    local v5 = script.elfhelperkick1:Clone();
    v5.CFrame = Elf.RootPart.CFrame * CFrame.new(0, 0, 20);
    v5.Parent = workspace.Debris;
    table.insert(u2, v5);
    EmitModule.emit(v5);
    Debris:AddItem(v5, 3);
    task.wait(0.13);
    local v6 = script.elfhelperkick2:Clone();
    v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(
        -0.0560302734,
        -2.22014475,
        -4.22888756,
        0.500000119,
        0,
        -0.866025567,
        0,
        1,
        0,
        0.866025567,
        0,
        0.500000119
    );
    v6.Parent = workspace.Debris;
    table.insert(u2, v6);
    EmitModule.emit(v6);
    Debris:AddItem(v6, 3);
    task.delay(3, function() -- Line: 69
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;