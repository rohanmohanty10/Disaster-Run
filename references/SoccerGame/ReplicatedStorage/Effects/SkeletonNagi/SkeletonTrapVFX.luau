  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: EmitModule (copy), Debris (copy), SoundManager (copy), VfxManager (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if p1.Trapped then
        local v2 = script.Control:Clone();
        v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.847991943, 0.89802742, -2.15823364, 0.00298887724, 0, 1, 0, 1, 0, -1, 0, 0.00298887724));
        v2.Parent = workspace.Debris;
        EmitModule.emit(v2);
        Debris:AddItem(v2, 3);

        return;
    end;

    local u3 = {};
    SoundManager.SpawnSound("SkeletonTrap", 0.9, Char.HumanoidRootPart, 130, false);
    local Folder = Instance.new("Folder");
    Folder.Name = "PIsagiHighlight";
    Folder.Parent = Char;
    table.insert(u3, Folder);
    Debris:AddItem(Folder, 0.65);
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
    table.insert(u3, v4);
    EmitModule.emit(v4);
    Debris:AddItem(v4, 3);
    task.wait(0.03);
    local v5 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };

    for _, child in script.Body:GetChildren() do
        local v6 = child;

        for _, child2 in Char:GetChildren() do
            if v6:IsA("Attachment") and (string.match(child2.Name, "Arm") or string.match(child2.Name, "Leg")) then
                local v7 = v6:Clone();
                v7.Parent = child2;
                table.insert(u3, v7);
            elseif table.find(v5, child2.Name) then
                local v8 = v6:Clone();
                v8.Parent = child2;
                table.insert(u3, v8);
            end;
        end;
    end;

    for _, child in script.Torso:GetChildren() do
        local v9 = child:Clone();
        v9.Parent = Char.Torso;
        table.insert(u3, v9);
    end;

    VfxManager.Emit2(Char);
    task.wait(0.14);
    local v10 = script.Jump:Clone();
    v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.0129852295, -2.81917548, 0.666984558, 0, 0, 1, 0, 1, 0, -1, 0, 0);
    v10.Parent = workspace.Debris;
    table.insert(u3, v10);
    EmitModule.emit(v10);
    Debris:AddItem(v10, 3);
    task.delay(3, function() -- Line: 80
        -- upvalues: u3 (copy)
        for _, v in u3 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;