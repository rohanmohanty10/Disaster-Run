 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: Players (copy), SfxManager (copy), Effects (copy), VfxManager (copy), Debris (copy), RunService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local u4 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "Drive" then
        SfxManager:playSound({
            Sound = "BBZ Referee Bench Drive",
            Parent = HumanoidRootPart
        });
        Effects:SubtitleV2({
            { u4, "Don\'t foul!", 0.5 }
        });
        local u5 = {};

        for _, child in pairs(script.Trail:GetChildren()) do
            local v6 = Character:FindFirstChild("Right Arm");
            local v7 = Character:FindFirstChild("Left Arm");

            if v6 then
                local v8 = child:Clone();
                v8.Parent = v6;
                table.insert(u5, v8);
            end;

            if v7 then
                local v9 = child:Clone();
                v9.Parent = v7;
                table.insert(u5, v9);
            end;
        end;

        local v10 = script.Book:Clone();
        v10.Parent = Character;
        v10.BookToRig.Handle.Part0 = Character:FindFirstChild("Left Arm");
        VfxManager.DestroyEffect(v10, 1.6666666666666667 - v3);
        local u11 = script.Enable:Clone();
        u11.Parent = Debris;
        u11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0.05, -0.825) * CFrame.Angles(0, -1.5707963267948966, 0);
        VfxManager.Enable(u11, true);
        VfxManager.DestroyEffect(u11, 4);
        local u12 = nil;
        u12 = RunService.RenderStepped:Connect(function() -- Line: 67
            -- upvalues: u11 (copy), u12 (ref), HumanoidRootPart (ref)
            if not u11 then
                u12:Disconnect();

                return;
            end;

            local _, v13, _ = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + HumanoidRootPart.Velocity):ToOrientation();
            u11.CFrame = CFrame.new(HumanoidRootPart.Position) * CFrame.fromOrientation(0, v13 + -1.5707963267948966, 0);
        end);
        task.delay(0.05 - v3, function() -- Line: 77
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v14 = script.Ball:Clone();
            v14.Parent = Debris;
            v14.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            VfxManager.Emit(v14);
            VfxManager.DestroyEffect(v14, 2);
        end);
        task.delay(0.3 - v3, function() -- Line: 85
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v15 = script.Ball:Clone();
            v15.Parent = Debris;
            v15.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            VfxManager.Emit(v15);
            VfxManager.DestroyEffect(v15, 2);
        end);
        task.delay(0.5333333333333333 - v3, function() -- Line: 93
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v16 = script.Ball:Clone();
            v16.Parent = Debris;
            v16.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            VfxManager.Emit(v16);
            VfxManager.DestroyEffect(v16, 2);
        end);
        task.delay(0.8 - v3, function() -- Line: 101
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v17 = script.Ball:Clone();
            v17.Parent = Debris;
            v17.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            VfxManager.Emit(v17);
            VfxManager.DestroyEffect(v17, 2);
        end);
        task.delay(1.1166666666666667 - v3, function() -- Line: 109
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v18 = script.Ball:Clone();
            v18.Parent = Debris;
            v18.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            VfxManager.Emit(v18);
            VfxManager.DestroyEffect(v18, 2);
        end);
        task.delay(1.2166666666666666 - v3, function() -- Line: 117
            -- upvalues: VfxManager (ref), u11 (copy), u5 (copy)
            VfxManager.Enable(u11, false);

            for _, v in u5 do
                if v and v:IsA("Trail") then
                    v.Enabled = false;
                end;

                VfxManager.DestroyEffect(v, 2);
            end;
        end);
        task.delay(1.2166666666666666 - v3 + 2, function() -- Line: 128
            -- upvalues: u12 (ref)
            u12:Disconnect();
        end);
    elseif p2.Task == "Bench" then
        local Enemy = p2.Enemy;
        local HumanoidRootPart2 = Enemy:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart2:FindFirstChild("BBZ Referee Bench Enemy") then
            SfxManager:playSound({
                Sound = "BBZ Referee Bench Enemy",
                Parent = HumanoidRootPart2
            });
            task.delay(0.5, function() -- Line: 138
                -- upvalues: Effects (ref), u4 (copy)
                Effects:SubtitleV2({
                    { u4, "Take a seat!", 1 }
                });
            end);
        end;

        local v19 = script.Bench:Clone();
        v19.Parent = Enemy;
        v19.Motor6D.Part0 = HumanoidRootPart2;
        VfxManager.Emit(v19);
        VfxManager.DestroyEffect(v19, 1.85 - v3);
        task.delay(1.85 - v3, function() -- Line: 155
            -- upvalues: Debris (ref), HumanoidRootPart2 (ref), VfxManager (ref)
            local v20 = script.Despawn:Clone();
            v20.Parent = Debris;
            v20.CFrame = HumanoidRootPart2.CFrame * CFrame.new(0.006, -0.555, 6.346);
            VfxManager.Emit(v20);
            VfxManager.DestroyEffect(v20, 2);
        end);
    end;
end;