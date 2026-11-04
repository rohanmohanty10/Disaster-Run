 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    local _ = ReplicatedStorage.Basketball.Value;

    if p2.Task == "Dribble" then
        SfxManager:playSound({
            Sound = "BBZ Judgement Judgement Dribble",
            Parent = HumanoidRootPart
        });
        task.delay(0.2333333333333333 - u3, function() -- Line: 28
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v4 = script.Bounce:Clone();
            v4.Parent = Debris;
            v4:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v4);
            VfxManager.DestroyEffect(v4, 2);
        end);
        task.delay(0.611111111111111 - u3, function() -- Line: 36
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v5 = script.Bounce:Clone();
            v5.Parent = Debris;
            v5:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v5);
            VfxManager.DestroyEffect(v5, 2);
        end);
        task.delay(0.8555555555555556 - u3, function() -- Line: 44
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v6 = script.Bounce:Clone();
            v6.Parent = Debris;
            v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v6);
            VfxManager.DestroyEffect(v6, 2);
        end);
        task.delay(1.2444444444444445 - u3, function() -- Line: 52
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v7 = script.Bounce:Clone();
            v7.Parent = Debris;
            v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v7);
            VfxManager.DestroyEffect(v7, 2);
        end);
        local v8 = tick();

        repeat
            task.wait(0.1);
            local v9 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v9, 1);
        until tick() - v8 > 1.2444444444444445 - u3;
    else
        if p2.Task == "Forward" then
            SfxManager:playSound({
                Sound = "BBZ Judgement Judgement Drive",
                Parent = HumanoidRootPart
            });
            task.delay(0.39999999999999997 - u3, function() -- Line: 68
                -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), Essentials (ref), Character (copy), u3 (copy)
                local v10 = script.Bounce:Clone();
                v10.Parent = Debris;
                v10:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
                VfxManager.BetterEmit(v10);
                VfxManager.DestroyEffect(v10, 2);
                local v11 = tick();

                repeat
                    task.wait(0.1);
                    local v12 = Essentials:CreateClone(Character);
                    VfxManager.DestroyEffect(v12, 1);
                until tick() - v11 > 1.3666666666666665 - u3;
            end);
            task.delay(0.6666666666666666 - u3, function() -- Line: 82
                -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
                local v13 = script.Bounce:Clone();
                v13.Parent = Debris;
                v13:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
                VfxManager.BetterEmit(v13);
                VfxManager.DestroyEffect(v13, 2);
            end);
            task.delay(0.9333333333333332 - u3, function() -- Line: 90
                -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
                local v14 = script.Bounce:Clone();
                v14.Parent = Debris;
                v14:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
                VfxManager.BetterEmit(v14);
                VfxManager.DestroyEffect(v14, 2);
            end);
            task.delay(1.3444444444444443 - u3, function() -- Line: 98
                -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
                local v15 = script.Bounce:Clone();
                v15.Parent = Debris;
                v15:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
                VfxManager.BetterEmit(v15);
                VfxManager.DestroyEffect(v15, 2);
            end);
            task.delay(1.5777777777777777 - u3, function() -- Line: 106
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v16 = script.Dash:Clone();
                v16.Parent = Debris;
                v16:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0.25, 0));
                VfxManager.BetterEmit(v16);
                VfxManager.DestroyEffect(v16, 4);
            end);
            task.delay(1.7666666666666666 - u3, function() -- Line: 114
                -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
                local v17 = script.Bounce:Clone();
                v17.Parent = Debris;
                v17:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
                VfxManager.BetterEmit(v17);
                VfxManager.DestroyEffect(v17, 2);
            end);

            return;
        end;

        if p2.Task == "Swap" then
            local Other = p2.Other;

            if not (Other and Other:FindFirstChild("HumanoidRootPart")) then
                return;
            end;

            SfxManager:playSound({
                Sound = "BBZ Judgement Judgement Swap",
                Parent = Other.HumanoidRootPart
            });
            local u18 = script.Swap:Clone();
            u18.Parent = Debris;
            u18.CFrame = Other.HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
            Essentials:Weld(u18, Other.HumanoidRootPart);
            VfxManager.Enable(u18, true);
            task.delay(1.7666666666666666, function() -- Line: 132
                -- upvalues: VfxManager (ref), u18 (copy)
                VfxManager.Enable(u18, false);
                VfxManager.DestroyEffect(u18, 4);
            end);
        end;
    end;
end;