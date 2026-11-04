  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
require(ReplicatedStorage.Controllers.CameraController);

return function(p1) -- Line: 11
    -- upvalues: SoundManager (copy), VfxManager (copy), EmitModule (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    SoundManager.SpawnSound("ChristmasStampede", 0.9, Char.HumanoidRootPart, 130, false);
    local u2 = {};

    for _, child in Char:GetChildren() do
        if child.Name == "Reindeer" then
            local v3 = child;

            for _, child2 in script.VFX:GetChildren() do
                local v4 = child2:Clone();
                v4.Parent = v3:FindFirstChild("MeshesblrReindeerlowPoly4301");
                table.insert(u2, v4);
            end;

            VfxManager.Enable(v3, true);
        end;
    end;

    task.wait(0.15);
    local v5 = script.santaemit2:Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.214355469, 1.08700228, -7.82376862, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v5.Parent = workspace.Debris;
    table.insert(u2, v5);
    EmitModule.emit(v5);
    task.wait(1.3);

    for _, child in Char:GetChildren() do
        if child.Name == "Reindeer" then
            VfxManager.Enable(child, false);
        end;
    end;

    task.wait(0.08);
    local v6 = script.santaemit1:Clone();
    v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.214355469, -2.57746935, -0.994754791, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v6.Parent = workspace.Debris;
    table.insert(u2, v6);
    EmitModule.emit(v6);
    task.wait(0.02);
    local v7 = script.santaemit3:Clone();
    v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(-5.10604858, -2.57746935, -9.65227509, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v7.Parent = workspace.Debris;
    table.insert(u2, v7);
    EmitModule.emit(v7);
    local v8 = script.santaemit4:Clone();
    v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(5.31030273, -2.57746935, -9.65227509, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v8.Parent = workspace.Debris;
    table.insert(u2, v8);
    EmitModule.emit(v8);
    local v9 = script.santaemit5:Clone();
    v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.661621094, -2.57746935, -19.4381485, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v9.Parent = workspace.Debris;
    table.insert(u2, v9);
    EmitModule.emit(v9);
    task.delay(3, function() -- Line: 75
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;