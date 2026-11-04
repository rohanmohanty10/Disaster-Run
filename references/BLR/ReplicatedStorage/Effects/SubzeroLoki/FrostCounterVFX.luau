  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
require(ReplicatedStorage.Controllers.CameraController);

return function(p1) -- Line: 11
    -- upvalues: SoundManager (copy), EmitModule (copy), Essentials (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if p1 and p1.Hit then
        local Hit = p1.Hit;
        local u2 = {};
        SoundManager.SpawnSound("FrostCounterDash", 0.9, Char.HumanoidRootPart, 130, false);
        task.spawn(function() -- Line: 21
            -- upvalues: HumanoidRootPart (copy), u2 (copy), EmitModule (ref), Essentials (ref)
            task.wait(0.07);
            local v3 = script.dash:Clone();
            v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.145446777, -0.72964716, 3.9384346, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            v3.Parent = workspace.Debris;
            table.insert(u2, v3);
            EmitModule.emit(v3);
            task.wait(0.03);
            local v4 = script.aura:Clone();
            v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.184700012, -0.799626112, -2.75063419, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            Essentials:WeldOffset(HumanoidRootPart, v4, CFrame.new(-0.184700012, -0.799626112, -2.75063419, 1, 0, 0, 0, 1, 0, 0, 0, 1));
            v4.Parent = workspace.Debris;
            table.insert(u2, v4);
            EmitModule.emit(v4);
        end);
        local u5 = script.icecube:Clone();
        u5.CFrame = Hit.HumanoidRootPart.CFrame * CFrame.new(0.218505859, 0.342395782, 0.199998856, 0, 0, 1, 0, 1, 0, -1, 0, 0);
        Essentials:WeldOffset(Hit.HumanoidRootPart, u5, CFrame.new(0.218505859, 0.342395782, 0.199998856, 0, 0, 1, 0, 1, 0, -1, 0, 0));
        task.delay(1, function() -- Line: 43
            -- upvalues: u5 (copy)
            if u5 then
                u5:Destroy();
            end;
        end);
        task.delay(3, function() -- Line: 47
            -- upvalues: u2 (copy)
            for _, v in u2 do
                if v then
                    v:Destroy();
                end;
            end;
        end);

        return;
    end;

    local u6 = {};
    local Folder = Instance.new("Folder");
    Folder.Name = "SLokiHighlight";
    Folder.Parent = Char;
    task.delay(2, Folder.Destroy, Folder);
    SoundManager.SpawnSound("FrostCounter", 0.9, Char.HumanoidRootPart, 130, false);
    local v7 = script.dash:Clone();
    v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.145446777, -0.72964716, 3.9384346, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v7.Parent = workspace.Debris;
    table.insert(u6, v7);
    EmitModule.emit(v7);
    local v8 = script.aura:Clone();
    v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.184700012, -0.799626112, -2.75063419, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    Essentials:WeldOffset(HumanoidRootPart, v8, CFrame.new(-0.184700012, -0.799626112, -2.75063419, 1, 0, 0, 0, 1, 0, 0, 0, 1));
    v8.Parent = workspace.Debris;
    table.insert(u6, v8);
    EmitModule.emit(v8);
    task.delay(3, function() -- Line: 80
        -- upvalues: u6 (copy)
        for _, v in u6 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;