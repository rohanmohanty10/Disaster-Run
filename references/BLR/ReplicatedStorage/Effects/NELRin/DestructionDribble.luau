  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 10
    -- upvalues: RunService (copy), Debris (copy), VfxManager (copy)
    local Char = p1.Char;
    print(Char, "DestructionDribble");
    local u2 = script.RunEmit:Clone();
    u2.Parent = workspace.Debris;
    local u3 = script.SmokeRun:Clone();
    u3.Parent = workspace.Debris;
    local u4 = RunService.Heartbeat:Connect(function() -- Line: 22
        -- upvalues: u2 (copy), Char (copy), u3 (copy)
        u2:PivotTo(Char.HumanoidRootPart.CFrame);
        u3:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, -2.75, 0));
    end);
    task.delay(6.5, function() -- Line: 27
        -- upvalues: u4 (ref), Debris (ref), u2 (copy), u3 (copy)
        u4:Disconnect();
        Debris:AddItem(u2, 5);
        Debris:AddItem(u3, 5);
    end);
    coroutine.wrap(function() -- Line: 34
        -- upvalues: VfxManager (ref), u2 (copy)
        for i = 1, 4 do
            VfxManager.Emit(u2);
            task.wait(0.3);
            local _ = i;
        end;
    end)();
    task.delay(1.3, function() -- Line: 41
        -- upvalues: u3 (copy)
        for _, descendant in pairs(u3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(1.3, function() -- Line: 100
        -- upvalues: Char (copy), RunService (ref), VfxManager (ref)
        local u5 = script.SidetoSide:Clone();
        u5:PivotTo(Char.HumanoidRootPart.CFrame);
        u5.Parent = workspace.Debris;
        task.delay(2, function() -- Line: 104
            -- upvalues: u5 (copy)
            u5:Destroy();
        end);
        RunService.Heartbeat:Connect(function() -- Line: 108
            -- upvalues: u5 (copy), Char (ref)
            u5:PivotTo(Char.HumanoidRootPart.CFrame);
        end);
        VfxManager.Emit(u5);
        task.wait(0.35);
        VfxManager.Emit(u5);
        task.wait(0.35);
        VfxManager.Emit(u5);
        task.wait(0.35);
        VfxManager.Emit(u5);
        task.wait(0.15);

        for i = 1, 4 do
            VfxManager.Emit(u5);
            task.wait(0.1);
            local _ = i;
        end;

        local u6 = script.D1:Clone();
        u6:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0));
        u6.Parent = workspace.Debris;
        VfxManager.Emit(u6);
        task.delay(10, function() -- Line: 137
            -- upvalues: u6 (copy)
            if u6 then
                u6:Destroy();
            end;
        end);
        local v7 = RunService.Heartbeat:Connect(function() -- Line: 144
            -- upvalues: u6 (copy), Char (ref)
            u6:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0));
        end);
        task.wait(0.3);
        VfxManager.Emit(u6);
        task.wait(0.3);
        VfxManager.Emit(u6);
        task.wait(0.3);
        VfxManager.Emit(u6);
        task.wait(1);
        v7:Disconnect();
    end);
end;