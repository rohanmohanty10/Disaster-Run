 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local u4 = Character:FindFirstChild("Right Leg");
    local u5 = Character:FindFirstChild("Left Leg");
    local Value = ReplicatedStorage.Basketball.Value;
    local BALL = Character:FindFirstChild("BALL", true);
    SfxManager:playSound({
        Sound = "BBZ Referee 3-Step Shot",
        Parent = HumanoidRootPart
    });
    local u6 = script.Ball:Clone();
    u6.CFrame = BALL.CFrame;
    u6.Parent = Debris;
    Essentials:Weld(u6, BALL);
    VfxManager.Enable(u6, true);
    task.delay(5 - v3, function() -- Line: 33
        -- upvalues: u6 (copy), VfxManager (ref)
        for _, descendant in pairs(u6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        VfxManager.DestroyEffect(u6, 2);
    end);
    task.delay(0.2 - v3, function() -- Line: 42
        -- upvalues: Debris (ref), u5 (copy), VfxManager (ref)
        local v7 = script.Step:Clone();
        v7.Parent = Debris;
        v7.CFrame = CFrame.new((u5.CFrame * CFrame.new(0, -1, 0)).Position) * CFrame.Angles(0, 0, 1.5707963267948966);
        VfxManager.Emit(v7);
        VfxManager.DestroyEffect(v7, 2);
    end);
    task.delay(0.5333333333333333 - v3, function() -- Line: 50
        -- upvalues: Debris (ref), u4 (copy), VfxManager (ref)
        local v8 = script.Step:Clone();
        v8.Parent = Debris;
        v8.CFrame = CFrame.new((u4.CFrame * CFrame.new(0, -1, 0)).Position) * CFrame.Angles(0, 0, 1.5707963267948966);
        VfxManager.Emit(v8);
        VfxManager.DestroyEffect(v8, 2);
    end);
    task.delay(0.95 - v3, function() -- Line: 58
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v9 = script.Jump:Clone();
        v9.Parent = Debris;
        v9.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(3.141592653589793, 0, 0) + Vector3.new(0, -2.9, 0);
        VfxManager.Emit(v9);
        VfxManager.DestroyEffect(v9, 2);
    end);
    task.delay(1.45 - v3, function() -- Line: 66
        -- upvalues: VfxManager (ref), u6 (copy), Value (copy), Essentials (ref), Debris (ref), BALL (copy), HumanoidRootPart (copy)
        VfxManager.Enable(u6, false);
        u6:FindFirstChild("WeldConstraint"):Destroy();
        u6.CFrame = Value.CFrame;
        Essentials:Weld(u6, Value);
        VfxManager.Enable(u6, true);
        local v10 = script.Shot:Clone();
        v10.Parent = Debris;
        v10.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.fromOrientation(0.7853981633974483, 0, 0);
        VfxManager.Emit(v10);
        VfxManager.DestroyEffect(v10, 2);
    end);
end;