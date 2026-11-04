 
 

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

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task ~= "Snap" then
        if p2.Task ~= "Dribble" then
            if p2.Task == "Victim" then
                local Victim = p2.Victim;
                local HumanoidRootPart2 = Victim:FindFirstChild("HumanoidRootPart");
                SfxManager:playSound({
                    Sound = "BBZ Tatlis Snap VictimImpact + GetUp",
                    Parent = HumanoidRootPart2
                });
                local v3 = script.Warning:Clone();
                v3.CFrame = HumanoidRootPart2.CFrame * CFrame.new(-0.1602773666381836, -1.2812436819076538, -0.024661540985107422) * CFrame.fromEulerAnglesYXZ(-0, -1.134463906288147, 0);
                v3.Parent = Debris;
                VfxManager.Emit(v3);
                VfxManager.DestroyEffect(v3, 3);
                task.delay(0.35, function() -- Line: 95
                    -- upvalues: Victim (copy), HumanoidRootPart2 (copy), Debris (ref), VfxManager (ref)
                    if Victim then
                        local v4 = script.FallFX:Clone();
                        v4:PivotTo(HumanoidRootPart2.CFrame * CFrame.new(0.4205188751220703, -2.8898439407348633, 0.7431850433349609) * CFrame.fromEulerAnglesYXZ(-0, -2.7052602767944336, 0));
                        v4.Parent = Debris;
                        VfxManager.Emit(v4);
                        VfxManager.DestroyEffect(v4, 3);
                    end;
                end);
            end;

            return;
        end;

        local stunPart = p2.stunPart;
        local u5 = script.DribblePaint:Clone();

        if stunPart then
            u5:PivotTo(stunPart.CFrame * CFrame.Angles(0, 0, 1.5707963267948966));
        end;

        u5.Parent = Debris;
        VfxManager.Enable(u5, true);
        local u6 = SfxManager:playSound({
            Sound = "BBZ Tatlis Snap PaintPuddleLoop",
            Parent = u5.PrimaryPart
        });
        task.delay(2, function() -- Line: 72
            -- upvalues: VfxManager (ref), u5 (copy), u6 (copy)
            VfxManager.Enable(u5, false);
            VfxManager.DestroyEffect(u5, 3);
            u6:Destroy();
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Tatlis Snap Windup + Impact",
        Parent = HumanoidRootPart
    });
    local stunPart = p2.stunPart;
    local v7 = script.StartupImpact:Clone();
    v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.9828461408615112, -1.4171972274780273, 0.547882080078125) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    v7.Parent = Debris;
    VfxManager.Emit(v7);
    VfxManager.DestroyEffect(v7, 3);
    local u8 = script.PaintEnable:Clone();
    u8:PivotTo(stunPart.CFrame * CFrame.Angles(0, 0, 1.5707963267948966));
    u8.Parent = Debris;
    VfxManager.Enable(u8, true);
    local u9 = SfxManager:playSound({
        Sound = "BBZ Tatlis Snap PaintPuddleLoop",
        Parent = u8.PrimaryPart
    });
    task.delay(2, function() -- Line: 43
        -- upvalues: u8 (copy), VfxManager (ref), Debris (ref), u9 (copy), SfxManager (ref), HumanoidRootPart (copy)
        if u8 then
            VfxManager.Enable(u8, false);
            VfxManager.DestroyEffect(u8, 4);
            local v10 = script.End:Clone();
            v10.CFrame = u8.Enable.CFrame * CFrame.new(0, 2, 0);
            v10.Parent = Debris;
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 3);
            u9:Stop();
            SfxManager:playSound({
                Sound = "BBZ Tatlis Snap PaintEnd",
                Parent = HumanoidRootPart
            });
        end;
    end);
end;