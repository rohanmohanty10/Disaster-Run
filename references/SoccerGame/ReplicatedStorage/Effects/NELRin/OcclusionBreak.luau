  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 13
    -- upvalues: Essentials (copy), RunService (copy), VfxManager (copy), Debris (copy)
    local Char = p1.Char;

    if p1.Action ~= "DribbleStart" then
        if p1.Action == "Roulette" then
            local v2 = script.Roulette:Clone();
            v2.CFrame = Char.HumanoidRootPart.CFrame;
            v2.Parent = workspace.Debris;
            VfxManager.Emit(v2);
            Debris:AddItem(v2, 3);
        end;

        return;
    end;

    local u3 = script.Dash:Clone();
    u3.CFrame = Char.Torso.CFrame * CFrame.Angles(0.7853981633974483, 0, 0);
    u3.Parent = workspace.Debris;
    Essentials:Weld(u3, Char.Torso);
    local u4 = script.NewTrail:Clone();
    u4:PivotTo(Char.HumanoidRootPart.CFrame);
    u4.Parent = workspace.Debris;
    local u5 = RunService.Heartbeat:Connect(function() -- Line: 26
        -- upvalues: u4 (copy), Char (copy)
        u4:PivotTo(Char.HumanoidRootPart.CFrame);
    end);
    task.spawn(function() -- Line: 30
        -- upvalues: Char (copy), VfxManager (ref), RunService (ref), Debris (ref)
        local v6 = script.RunEmit:Clone();
        v6.CFrame = Char.HumanoidRootPart.CFrame * CFrame.Angles(0, -0.7853981633974483, 0);
        v6.Parent = workspace.Debris;
        VfxManager.Emit(v6);
        local v7 = script.WaterStep:Clone();
        v7.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
        v7.Parent = workspace.Debris;
        VfxManager.Emit(v7);
        local u8 = script.MiniSteps:Clone();
        u8.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
        u8.Parent = workspace.Debris;
        VfxManager.Emit(u8);
        local os_clock_ret = os.clock();
        local v9 = RunService.Heartbeat:Connect(function() -- Line: 48
            -- upvalues: os_clock_ret (ref), VfxManager (ref), u8 (copy), Char (ref)
            if os.clock() - os_clock_ret > 0.1 then
                VfxManager.Emit(u8);
                os_clock_ret = os.clock();
            end;

            u8.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
        end);
        task.wait(0.5);
        v7.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
        VfxManager.Emit(v7);
        v6.CFrame = Char.HumanoidRootPart.CFrame;
        VfxManager.Emit(v6);
        task.wait(0.5);
        v7.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
        VfxManager.Emit(v7);
        v6.CFrame = Char.HumanoidRootPart.CFrame;
        VfxManager.Emit(v6);
        Debris:AddItem(v6, 5);
        Debris:AddItem(v7, 3);
        Debris:AddItem(u8, 3);
        v9:Disconnect();
    end);
    task.delay(1.5, function() -- Line: 79
        -- upvalues: u5 (ref), VfxManager (ref), u3 (copy), u4 (copy), Debris (ref)
        u5:Disconnect();
        VfxManager.Enable(u3, false);
        VfxManager.Enable(u4, false);
        Debris:AddItem(u3, 1);
        Debris:AddItem(u4, 1);
    end);
end;