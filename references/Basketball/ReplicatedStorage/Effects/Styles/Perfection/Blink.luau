 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    local BALL = Char:FindFirstChild("BALL", true);

    if p2.Task ~= "Dribble" then
        if p2.Task == "Dunk" then
            SfxManager:playSound({
                Sound = "BBZ perfect defense base move",
                Parent = HumanoidRootPart
            });
            SfxManager:playSound({
                Sound = "BBZ perfect dunk",
                Parent = HumanoidRootPart
            });
            local v4 = script.Dunk.Jump:Clone();
            v4:PivotTo(CFrame.new(p2.Last.X, 5, p2.Last.Z));
            v4.Parent = Debris;
            VfxManager.Emit(v4);
            VfxManager.DestroyEffect(v4, 2);
            local v5 = script.Dunk.FlashStep:Clone();
            v5.Parent = Debris;
            v5.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v5, HumanoidRootPart);
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 2);
            task.wait(0.5);
            local Hoops = workspace:FindFirstChild("Hoops");
            local v6 = nil;

            if Hoops then
                local Hoop = Hoops.Away.Hoop;
                local Hoop2 = Hoops.Home.Hoop;

                if Hoop and Hoop2 then
                    local Magnitude = (HumanoidRootPart.Position - Hoop.Position).Magnitude;
                    local Magnitude2 = (HumanoidRootPart.Position - Hoop2.Position).Magnitude;

                    if Magnitude2 < Magnitude then
                        v6 = Hoop2.CFrame;
                    elseif Magnitude < Magnitude2 then
                        v6 = Hoop.CFrame;
                    end;
                end;
            end;

            if v6 then
                local v7 = script.Dunk.shoot:Clone();
                v7.CFrame = v6;
                v7.Parent = Debris;
                VfxManager.Emit(v7);
                VfxManager.DestroyEffect(v7, 2);

                return;
            end;
        else
            if p2.Task == "Punch" then
                SfxManager:playSound({
                    Sound = "BBZ perfect pass base",
                    Parent = HumanoidRootPart
                });
                local u8 = script.Punch.Flight:Clone();
                u8.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.992828369140625, 1.997544765472412, 1.1810379028320312) * CFrame.fromEulerAnglesYXZ(-0, 0.008901762776076794, 0);
                u8.Parent = Debris;
                VfxManager.DestroyEffect(u8, 4);
                VfxManager.Enable(u8, true);
                Essentials:Weld(u8, HumanoidRootPart);
                task.spawn(function() -- Line: 116
                    -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), u3 (copy)
                    if HumanoidRootPart.Parent == nil then
                        return;
                    end;

                    local v9 = script.Punch.Flashstep_1:Clone();
                    v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.3025932312011719, -0.43297433853149414, 5.4649505615234375) * CFrame.fromEulerAnglesYXZ(-0, -3.1326916217803955, 1.5707963705062866);
                    v9.Parent = Debris;
                    VfxManager.Emit(v9);
                    VfxManager.DestroyEffect(v9, 3);

                    for _, descendant in pairs(v9:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") and descendant.Name == "Flash" then
                            descendant.Enabled = true;
                        end;
                    end;

                    task.wait(0.115 - u3);

                    if v9.Parent ~= nil then
                        for _, descendant in pairs(v9:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") and descendant.Name == "Flash" then
                                descendant.Enabled = false;
                            end;
                        end;
                    end;
                end);
                task.delay(0.367 - u3, function() -- Line: 143
                    -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), u8 (copy)
                    if HumanoidRootPart.Parent == nil then
                        return;
                    end;

                    local v10 = script.Punch.MainImpact:Clone();
                    v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.3159027099609375, 0.7880187034606934, -4.418998718261719) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 3.1415927410125732);
                    v10.Parent = Debris;
                    VfxManager.Emit(v10);
                    VfxManager.DestroyEffect(v10, 3);
                    task.wait(0.3);

                    if u8.Parent ~= nil then
                        VfxManager.Enable(u8, false);
                        VfxManager.DestroyEffect(u8, 3);
                    end;
                end);

                return;
            end;

            if p2.Task == "Sidestep" then
                SfxManager:playSound({
                    Sound = "BBZ perfect defense base move",
                    Parent = HumanoidRootPart
                });
                local v11 = script.Sidestep.Startup:Clone();
                v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.04128265380859375, -0.18984508514404297, -0.8179855346679688) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v11.Parent = Debris;
                VfxManager.Emit(v11);
                VfxManager.DestroyEffect(v11, 3);
                task.delay(0.183 - u3, function() -- Line: 174
                    -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), u3 (copy)
                    if HumanoidRootPart.Parent == nil then
                        return;
                    end;

                    local v12 = script.Sidestep.Flashstep_1:Clone();
                    v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.3274078369140625, -0.5124607086181641, -1.0060577392578125) * CFrame.fromEulerAnglesYXZ(-0, -3.1326916217803955, 1.5707963705062866);
                    v12.Parent = Debris;
                    VfxManager.Emit(v12);
                    VfxManager.DestroyEffect(v12, 3);

                    for _, descendant in pairs(v12:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") and descendant.Name == "Flash" then
                            descendant.Enabled = true;
                        end;
                    end;

                    task.wait(0.115 - u3);

                    if v12.Parent ~= nil then
                        for _, descendant in pairs(v12:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") and descendant.Name == "Flash" then
                                descendant.Enabled = false;
                            end;
                        end;
                    end;
                end);
            end;
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ perfect dunk base move",
        Parent = HumanoidRootPart
    });
    task.delay(0.25 - u3, function() -- Line: 28
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v13 = script.Dunk.Bounce:Clone();
        v13.Parent = Debris;
        v13.CFrame = CFrame.new(BALL.Position);
        VfxManager.Emit(v13);
        VfxManager.DestroyEffect(v13, 2);
    end);
    task.delay(0.5166666666666667 - u3, function() -- Line: 36
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v14 = script.Dunk.Bounce:Clone();
        v14.Parent = Debris;
        v14.CFrame = CFrame.new(BALL.Position);
        VfxManager.Emit(v14);
        VfxManager.DestroyEffect(v14, 2);
    end);
    task.delay(0.8333333333333334 - u3, function() -- Line: 44
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v15 = script.Dunk.Bounce:Clone();
        v15.Parent = Debris;
        v15.CFrame = CFrame.new(BALL.Position);
        VfxManager.Emit(v15);
        VfxManager.DestroyEffect(v15, 2);
    end);
    task.delay(1.15 - u3, function() -- Line: 52
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v16 = script.Dunk.Bounce:Clone();
        v16.Parent = Debris;
        v16.CFrame = CFrame.new(BALL.Position);
        VfxManager.Emit(v16);
        VfxManager.DestroyEffect(v16, 2);
    end);
end;