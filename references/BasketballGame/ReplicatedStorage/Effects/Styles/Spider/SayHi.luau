 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), VfxManager (copy), Essentials (copy)
    local Character = p2.Character;
    local Target = p2.Target;
    local Variant = p2.Variant;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if Variant ~= "Off-Ball" or not Target then
        if Variant == "On-Ball" then
            SfxManager:playSound({
                Sound = "BBZ Spider SlamBall",
                Parent = Character
            });
            local u4 = script.ballslam:Clone();
            u4.Parent = Character;
            local u5 = script.spin:Clone();
            u5.Parent = Character;
            local u6 = script.throw:Clone();
            u6.Parent = Character;
            local u7 = script.emit:Clone();
            u7.Parent = Character;
            local u8 = script.emit2:Clone();
            u8.Parent = Character;
            local u9 = script.RightWeb:Clone();
            u9.Parent = Character["Right Arm"];
            local u10 = script.BeamPart:Clone();
            u10.Parent = Character;
            local u11 = script.RightWeb:Clone();
            u11.Parent = Character["Right Arm"];
            task.delay(0.3666666666666667 - v3, function() -- Line: 119
                -- upvalues: u4 (copy), HumanoidRootPart (copy), VfxManager (ref)
                u4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.2943573, -2.03311586, -2.94937205, 0, 0, -1, 0, 1, 0, 1, 0, 0);
                VfxManager.Emit(u4);
            end);
            task.delay(0.7111111111111111 - v3, function() -- Line: 124
                -- upvalues: u8 (copy), HumanoidRootPart (copy), VfxManager (ref), Target (copy), u10 (copy), u9 (copy)
                u8.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                    -0.766647339,
                    3.2838788,
                    2.11062813,
                    1,
                    0,
                    0,
                    0,
                    0.42555812,
                    -0.904931128,
                    0,
                    0.904931128,
                    0.42555812
                );
                VfxManager.Emit(u8);

                if Target then
                    u10.CFrame = Target.HumanoidRootPart.CFrame;
                    u9.Beam.Attachment0 = u10.Attachment;
                    u9.Beam.Enabled = true;
                end;
            end);
            task.delay(1.011111111111111 - v3, function() -- Line: 136
                -- upvalues: u9 (copy), u5 (copy), HumanoidRootPart (copy), VfxManager (ref)
                u9.Beam.Enabled = false;
                u5.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                    0.922988892,
                    0.096124649,
                    -1.0974108,
                    -0.833592594,
                    0.0201854259,
                    -0.552010775,
                    -0.113313064,
                    0.971830964,
                    0.206651255,
                    0.540632486,
                    0.234812945,
                    -0.807823896
                );
                VfxManager.Emit(u5);
            end);
            task.delay(1.288888888888889 - v3, function() -- Line: 142
                -- upvalues: u6 (copy), HumanoidRootPart (copy), VfxManager (ref)
                u6.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                    -0.588111877,
                    0.91899395,
                    -3.11535025,
                    0.999863267,
                    0.0152884405,
                    0.00609110296,
                    -0.0152887097,
                    0.999885261,
                    0,
                    -0.00609070016,
                    -0.0000931278773,
                    0.999981999
                );
                VfxManager.Emit(u6);
            end);
            task.delay(1.7222222222222223 - v3, function() -- Line: 147
                -- upvalues: u7 (copy), HumanoidRootPart (copy), VfxManager (ref), u11 (copy), Character (copy)
                u7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.909355164, 0.555882931, -2.85637212, 1, 0, 0, 0, 1, 0, 0, 0, 1);
                VfxManager.Emit(u7);
                u11.Beam.Attachment0 = Character.PlrBall.Anims.BALL["1"];
                u11.Beam.Enabled = true;
            end);
            task.delay(2.088888888888889 - v3, function() -- Line: 154
                -- upvalues: u11 (copy), u5 (copy), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
                u11.Beam.Enabled = false;
                u5.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                    0.922988892,
                    0.096124649,
                    -1.0974108,
                    -0.833592594,
                    0.0201854259,
                    -0.552010775,
                    -0.113313064,
                    0.971830964,
                    0.206651255,
                    0.540632486,
                    0.234812945,
                    -0.807823896
                );
                u5.Anchored = false;
                Essentials:Weld(u5, HumanoidRootPart);
                VfxManager.Emit(u5);
            end);
            task.delay(2.6222222222222222 - v3, function() -- Line: 162
                -- upvalues: u8 (copy), u7 (copy), u4 (copy), u5 (copy), u6 (copy), u9 (copy), u10 (copy), u11 (copy)
                if u8 then
                    u8:Destroy();
                end;

                if u7 then
                    u7:Destroy();
                end;

                if u4 then
                    u4:Destroy();
                end;

                if u5 then
                    u5:Destroy();
                end;

                if u6 then
                    u6:Destroy();
                end;

                if u9 then
                    u9:Destroy();
                end;

                if u10 then
                    u10:Destroy();
                end;

                if u11 then
                    u11:Destroy();
                end;
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Spider WebCombo",
        Parent = Character
    }).PlaybackSpeed = 2;
    local u12 = script.emit:Clone();
    u12.Parent = Character;
    local u13 = script.emit2:Clone();
    u13.Parent = Character;
    local u14 = script.Dash:Clone();
    u14.Parent = Character;
    local u15 = script.spin:Clone();
    u15.Parent = Character;
    local u16 = script.throw:Clone();
    u16.Parent = Character;
    local u17 = script.HIT:Clone();
    u17.Parent = Character;
    local u18 = script.LeftWeb:Clone();
    u18.Parent = Character["Left Arm"];
    local u19 = script.RightWeb:Clone();
    u19.Parent = Character["Right Arm"];
    local u20 = script.BeamPart:Clone();
    u20.Parent = Character;
    local u21 = script.BeamPart:Clone();
    u21.Parent = Character;
    task.delay(0.2888888888888889 - v3, function() -- Line: 48
        -- upvalues: u13 (copy), HumanoidRootPart (copy), VfxManager (ref), Target (copy), u21 (copy), u19 (copy), u17 (copy)
        u13.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.255003005, 0.241876125, -3.15763807, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        VfxManager.Emit(u13);

        if Target then
            u21.CFrame = Target["Right Arm"].CFrame * CFrame.new(-0.816000938, 0.693998814, -2.63700199, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            u19.Beam.Attachment0 = u21.Attachment;
            u19.Beam.Enabled = true;
            u17.CFrame = Target.HumanoidRootPart.CFrame;
            VfxManager.Emit(u17);
        end;
    end);
    task.delay(0.43333333333333335 - v3, function() -- Line: 60
        -- upvalues: u12 (copy), HumanoidRootPart (copy), VfxManager (ref), Target (copy), u20 (copy), u18 (copy), u17 (copy)
        u12.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.910996974, 0.496879101, -2.87563801, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        VfxManager.Emit(u12);

        if Target then
            u20.CFrame = Target["Left Arm"].CFrame * CFrame.new(0.284999013, 0.693998814, -2.63700199, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            u18.Beam.Attachment0 = u20.Attachment;
            u18.Beam.Enabled = true;
            u17.CFrame = Target.HumanoidRootPart.CFrame;
            VfxManager.Emit(u17);
        end;
    end);
    task.delay(0.7222222222222222 - v3, function() -- Line: 72
        -- upvalues: u18 (copy), u19 (copy), u14 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u18.Beam.Enabled = false;
        u19.Beam.Enabled = false;
        u14.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.416458994, -2.10204983, 0.500629067, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        VfxManager.Emit(u14);
    end);
    task.delay(1.222222222222222 - v3, function() -- Line: 79
        -- upvalues: u15 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u15.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.210996002, -0.373121738, -0.142636955, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        VfxManager.Emit(u15);
    end);
    task.delay(1.4444444444444444 - v3, function() -- Line: 84
        -- upvalues: u16 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u16.CFrame = HumanoidRootPart.CFrame * CFrame.new(
            0.908526003,
            0.85999012,
            -0.166615963,
            0.999863267,
            0.0152884405,
            0.00609110296,
            -0.0152887097,
            0.999885261,
            0,
            -0.00609070016,
            -0.0000931278773,
            0.999981999
        );
        VfxManager.Emit(u16);
    end);
    task.delay(1.8 - v3, function() -- Line: 89
        -- upvalues: u13 (copy), u12 (copy), u14 (copy), u15 (copy), u16 (copy), u17 (copy), u19 (copy), u18 (copy), u20 (copy), u21 (copy)
        if u13 then
            u13:Destroy();
        end;

        if u12 then
            u12:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        if u15 then
            u15:Destroy();
        end;

        if u16 then
            u16:Destroy();
        end;

        if u17 then
            u17:Destroy();
        end;

        if u19 then
            u19:Destroy();
        end;

        if u18 then
            u18:Destroy();
        end;

        if u20 then
            u20:Destroy();
        end;

        if u21 then
            u21:Destroy();
        end;
    end);
end;