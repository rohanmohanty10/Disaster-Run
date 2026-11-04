  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 14
    -- upvalues: VfxManager (copy), SoundManager (copy)
    local Char = p1.Char;
    local State = p1.State;
    local Left = p1.Left;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};

    if State ~= "Hit" then
        if State == "Side" then
            SoundManager.SpawnSound("GoldenDefense1", 0.6, HumanoidRootPart, 130, false);
            local v3 = script.Body:Clone();
            v3.Parent = workspace.Debris;
            v3.CFrame = Char:FindFirstChild("Torso").CFrame;
            VfxManager.Emit(v3);
        end;

        return;
    end;

    local v4 = Left and script.AttachmentsLeft or script.Attachments;

    for _, child in v4:GetChildren() do
        child:Clone().Parent = HumanoidRootPart;
    end;

    for _, child in script:GetChildren() do
        if v4:FindFirstChild(child.Name) then
            local v5 = child:Clone();
            v5.Parent = workspace.Debris;
            v5.CFrame = HumanoidRootPart:FindFirstChild(v5.Name).WorldCFrame;
            u2[v5.Name] = v5;
        end;
    end;

    task.delay(0.083, function() -- Line: 39
        -- upvalues: HumanoidRootPart (copy), u2 (copy), VfxManager (ref)
        local headVFX = HumanoidRootPart:FindFirstChild("headVFX");
        local headVFX2 = u2.headVFX;

        if not headVFX2 then
            return;
        end;

        local v6 = HumanoidRootPart:FindFirstChild("caught ya");
        local v7 = u2["caught ya"];
        v7.CFrame = v6.WorldCFrame;
        VfxManager.Emit(v7);
        headVFX2.CFrame = headVFX.WorldCFrame;
        VfxManager.Emit(headVFX2);
    end);
    task.delay(0.25, function() -- Line: 56
        -- upvalues: HumanoidRootPart (copy), u2 (copy), VfxManager (ref)
        local Step = HumanoidRootPart:FindFirstChild("Step");
        local Step2 = u2.Step;

        if not Step2 then
            return;
        end;

        Step2.CFrame = Step.WorldCFrame;
        VfxManager.Emit(Step2);
    end);
    task.delay(1, function() -- Line: 67
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;

        table.clear(u2);
    end);
end;