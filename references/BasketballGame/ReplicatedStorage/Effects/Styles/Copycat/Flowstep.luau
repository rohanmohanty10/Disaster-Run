 
 

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
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local _ = p2.speed;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local Torso = Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task ~= "F" then
        if p2.Task == "B" then
            SfxManager:playSound({
                Sound = "Flowburst",
                Parent = HumanoidRootPart
            });
            local u4 = script.Back.VFX:Clone();
            u4:PivotTo(HumanoidRootPart.CFrame);
            u4.Parent = Debris;
            Essentials:Weld(u4.PrimaryPart, HumanoidRootPart);
            VfxManager.Emit(u4.StartUpIntoSkill);
            task.delay(0.197 - v3, function() -- Line: 68
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Emit(u4.Dribbles.Dribble_0);
            end);
            task.delay(0.394 - v3, function() -- Line: 72
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Emit(u4.Dribbles.Dribble_1);
            end);
            task.delay(0.682 - v3, function() -- Line: 76
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Emit(u4.Dribbles.Dribble_2);
            end);
            task.delay(0.955 - v3, function() -- Line: 80
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Emit(u4.Dribbles.Dribble_2);
                VfxManager.DestroyEffect(u4, 2);
            end);

            return;
        end;

        if p2.Task == "R" or p2.Task == "L" then
            SfxManager:playSound({
                Sound = "Flowburst",
                Parent = HumanoidRootPart
            });
            local u5 = script.Right.VFX:Clone();
            u5:PivotTo(HumanoidRootPart.CFrame);
            u5.Parent = Debris;
            Essentials:Weld(u5.PrimaryPart, HumanoidRootPart);
            VfxManager.Emit(u5.StartUpIntoSkill);
            task.delay(0.15 - v3, function() -- Line: 95
                -- upvalues: Torso (copy), Debris (ref), Essentials (ref), VfxManager (ref)
                local u6 = script.Right["TorsoEnabling + Weld"]:Clone();
                u6.CFrame = Torso.CFrame;
                u6.Parent = Debris;
                Essentials:Weld(u6, Torso);
                VfxManager.Enable(u6, true);
                task.delay(0.533, function() -- Line: 102
                    -- upvalues: VfxManager (ref), u6 (copy)
                    VfxManager.Enable(u6, false);
                    VfxManager.DestroyEffect(u6, 2);
                end);
            end);
            task.delay(0.233 - v3, function() -- Line: 108
                -- upvalues: VfxManager (ref), u5 (copy)
                VfxManager.Emit(u5.Dribbles.Dribble_0);
            end);
            task.delay(0.833 - v3, function() -- Line: 112
                -- upvalues: VfxManager (ref), u5 (copy)
                VfxManager.Emit(u5.Dribbles.Dribble_1);
                VfxManager.DestroyEffect(u5, 2);
            end);

            return;
        end;

        if p2.Task ~= "Slasher" then
            if p2.Task == "Shooter" then
                SfxManager:playSound({
                    Sound = "FlowburstShooter",
                    Parent = HumanoidRootPart
                });
                local u7 = script.Shooter.VFX:Clone();
                u7:PivotTo(HumanoidRootPart.CFrame);
                u7.Parent = Debris;
                Essentials:Weld(u7.PrimaryPart, HumanoidRootPart);
                VfxManager.Emit(u7.StartUpIntoSkill);
                task.delay(0.2 - v3, function() -- Line: 163
                    -- upvalues: VfxManager (ref), u7 (copy)
                    VfxManager.Emit(u7.Dash);
                end);
                task.delay(0.235 - v3, function() -- Line: 167
                    -- upvalues: VfxManager (ref), u7 (copy)
                    VfxManager.Emit(u7.Dribbles.Dribble_0);
                end);
                task.delay(0.6 - v3, function() -- Line: 171
                    -- upvalues: VfxManager (ref), u7 (copy)
                    VfxManager.Emit(u7.Dribbles.Dribble_1);
                    VfxManager.DestroyEffect(u7, 2);
                end);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "FlowburstSlasher",
            Parent = HumanoidRootPart
        });
        local u8 = script.Slasher.VFX:Clone();
        u8:PivotTo(HumanoidRootPart.CFrame);
        u8.Parent = Debris;
        Essentials:Weld(u8.PrimaryPart, HumanoidRootPart);
        VfxManager.Emit(u8.StartUpIntoSkill);
        task.delay(0.4 - v3, function() -- Line: 127
            -- upvalues: VfxManager (ref), u8 (copy)
            VfxManager.Emit(u8.Dribbles.Dribble_0);
        end);
        task.delay(0.717 - v3, function() -- Line: 131
            -- upvalues: VfxManager (ref), u8 (copy)
            VfxManager.Emit(u8.Dribbles.Dribble_1);
        end);
        task.delay(1.067 - v3, function() -- Line: 135
            -- upvalues: VfxManager (ref), u8 (copy)
            VfxManager.Emit(u8.Dribbles.Dribble_1);
        end);
        task.delay(0.233 - v3, function() -- Line: 139
            -- upvalues: VfxManager (ref), u8 (copy)
            VfxManager.Enable(u8.Impact, true);
            VfxManager.Enable(u8.GroundEffect, true);
            VfxManager.Enable(u8.PlayerFlightWindBeams, true);
            task.delay(0.717, function() -- Line: 144
                -- upvalues: VfxManager (ref), u8 (ref)
                VfxManager.Enable(u8.Impact, false);
                VfxManager.Enable(u8.GroundEffect, false);
                VfxManager.Enable(u8.PlayerFlightWindBeams, false);
                VfxManager.DestroyEffect(u8, 2);
            end);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "Flowburst",
        Parent = HumanoidRootPart
    });
    local u9 = script.Forward["TorsoEnabling + Weld"]:Clone();
    u9.CFrame = Torso.CFrame;
    u9.Parent = Debris;
    Essentials:Weld(u9, Torso);
    VfxManager.Enable(u9, true);
    local u10 = script.Forward.VFX:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Debris;
    Essentials:Weld(u10.PrimaryPart, HumanoidRootPart);
    VfxManager.Emit(u10.StartUpIntoSkill);
    task.delay(0.317 - v3, function() -- Line: 42
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Emit(u10.Dribbles.Dribble_0);
    end);
    task.delay(0.75 - v3, function() -- Line: 46
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Emit(u10.Dribbles.Dribble_1);
    end);
    task.delay(1 - v3, function() -- Line: 50
        -- upvalues: VfxManager (ref), u10 (copy), u9 (copy)
        VfxManager.Emit(u10.Dribbles.Dribble_2);
        VfxManager.Enable(u9, false);
        VfxManager.DestroyEffect(u9, 2);
        VfxManager.DestroyEffect(u10, 2);
    end);
end;