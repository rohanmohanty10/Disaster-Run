 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, u2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy)
    local TimeSent = u2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = u2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if u2.Task == "Activate" then
        SfxManager:playSound({
            Sound = "BBZ LazyWorker 2 step dribble",
            Parent = HumanoidRootPart
        });
        task.delay(0.083, function() -- Line: 28
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v3 = script.Dribble:Clone();
                v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.11480389535427094, -2.8565738201141357, -0.6576004028320312) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0));
                v3.Parent = Debris;
                VfxManager.Emit(v3);
                VfxManager.DestroyEffect(v3, 3);
            end;
        end);
        task.delay(0.35, function() -- Line: 38
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v4 = script.Dribble2:Clone();
                v4:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-0.10519610345363617, -2.8565738201141357, 0.3323974609375) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0));
                v4.Parent = Debris;
                VfxManager.Emit(v4);
                VfxManager.DestroyEffect(v4, 3);
            end;
        end);
        task.wait(0.45);
        SfxManager:playSound({
            Sound = "BBZ LazyWorker alleydunk",
            Parent = HumanoidRootPart
        });
        task.delay(0.333, function() -- Line: 52
            -- upvalues: HumanoidRootPart (copy), u2 (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                if u2.Side == "Left" then
                    local v5 = script.Dribble:Clone();
                    v5:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-3.845196008682251, -2.8565738201141357, -1.9975967407226562) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0));
                    v5.Parent = Debris;
                    VfxManager.Emit(v5);
                    VfxManager.DestroyEffect(v5, 3);

                    return;
                end;

                local v6 = script.Dribble:Clone();
                v6:PivotTo(HumanoidRootPart.CFrame * CFrame.new(4.424804210662842, -2.8565738201141357, -0.78759765625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0));
                v6.Parent = Debris;
                VfxManager.Emit(v6);
                VfxManager.DestroyEffect(v6, 3);
            end;
        end);
        task.delay(0.8, function() -- Line: 74
            -- upvalues: HumanoidRootPart (copy), u2 (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                if u2.Side == "Left" then
                    local v7 = script.catch:Clone();
                    v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.5848374962806702, 4.016754627227783, 0.5674362182617188) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                    v7.Parent = Debris;
                    VfxManager.Emit(v7);
                    VfxManager.DestroyEffect(v7, 3);

                    return;
                end;

                local v8 = script.catch:Clone();
                v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.3282479047775269, 4.016754627227783, 0.6374359130859375) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v8.Parent = Debris;
                VfxManager.Emit(v8);
                VfxManager.DestroyEffect(v8, 3);
            end;
        end);
        task.delay(1.167, function() -- Line: 95
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v9 = script.Throw:Clone();
                v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.12307561933994293, 4.1512532234191895, -0.5618133544921875) * CFrame.fromEulerAnglesYXZ(0.30232658982276917, 0.02705835923552513, 0.008058200590312481);
                v9.Parent = Debris;
                VfxManager.Emit(v9);
                VfxManager.DestroyEffect(v9, 3);
            end;
        end);
    end;
end;