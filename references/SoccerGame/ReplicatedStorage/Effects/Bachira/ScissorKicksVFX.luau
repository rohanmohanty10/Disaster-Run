  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: SoundManager (copy), Debris (copy), Essentials (copy), EmitModule (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    SoundManager.SpawnSound("ScissorKicks", 0.9, Char.HumanoidRootPart, 130, false);
    local Folder = Instance.new("Folder");
    Folder.Name = "BachiraHighlight";
    Folder.Parent = Char;
    table.insert(u2, Folder);
    Debris:AddItem(Folder, 0.6);
    local v3 = script.SideToSideDribble:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.474212646, -0.0264182091, 0.096660614, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v3.Parent = HumanoidRootPart;
    Essentials:WeldOffset(HumanoidRootPart, v3, CFrame.new(0.474212646, -0.0264182091, 0.096660614, 1, 0, 0, 0, 1, 0, 0, 0, 1));
    table.insert(u2, v3);
    EmitModule.emit(v3);
    Debris:AddItem(v3, 3);
    local v4 = script.Startup:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame * CFrame.new(
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
    v4.Parent = workspace.Debris;
    table.insert(u2, v4);
    EmitModule.emit(v4);
    Debris:AddItem(v4, 3);
    task.wait(0.89);
    local v5 = script.SideToSideDribble:Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.554702759, -1.78202963, -0.308822632, 0, 0, -1, 0, 1, 0, 1, 0, 0);
    v5.Parent = workspace.Debris;
    table.insert(u2, v5);
    EmitModule.emit(v5);
    Debris:AddItem(v5, 3);
    task.delay(3, function() -- Line: 53
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;