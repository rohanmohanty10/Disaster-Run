  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: SoundManager (copy), Debris (copy), EmitModule (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    SoundManager.SpawnSound("ForcePass", 0.9, Char.HumanoidRootPart, 130, false);
    task.wait(0.05);
    local Folder = Instance.new("Folder");
    Folder.Name = "AikuHighlight";
    Folder.Parent = Char;
    table.insert(u2, Folder);
    Debris:AddItem(Folder, 0.65);
    local v3 = script.Startup:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(
        0.0000305175781,
        -2.84800005,
        -0.758018494,
        0.00298885466,
        -2.61293986e-10,
        -0.99999553,
        -8.74227766e-8,
        -1,
        0,
        -0.99999553,
        8.74223858e-8,
        -0.00298885466
    ));
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    EmitModule.emit(v3);
    Debris:AddItem(v3, 3);
    task.wait(0.25);
    local v4 = script.AikuClear:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame * CFrame.new(1.11750793, -1.28499997, -3.12943268, 0, 0, -0.99999994, 0, 1, 0, 0.99999994, 0, 0));
    v4.Parent = workspace.Debris;
    table.insert(u2, v4);
    EmitModule.emit(v4);
    Debris:AddItem(v4, 3);
    task.delay(3, function() -- Line: 47
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;