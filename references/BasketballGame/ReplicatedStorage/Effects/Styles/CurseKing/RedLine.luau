 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Lighting (copy), Debris (copy), VfxManager (copy), TweenService (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    local Value = ReplicatedStorage.Basketball.Value;

    if p2.Task ~= "Cleave" then
        if p2.Task == "Dribble" then
            SfxManager:playSound({
                Sound = "BBZ Curse King Red Line Dribble",
                Parent = HumanoidRootPart
            });
            task.delay(0.13333333333333333 - v3, function() -- Line: 89
                -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
                local v4 = script.Bounce:Clone();
                v4.Parent = Debris;
                v4:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
                VfxManager.BetterEmit(v4);
                VfxManager.DestroyEffect(v4, 4);
            end);
            task.delay(0.5333333333333333 - v3, function() -- Line: 97
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v5 = script.Dash:Clone();
                v5.Parent = Debris;
                v5:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0.5, 0) * CFrame.Angles(0, -1.0471975511965976, 0));
                VfxManager.BetterEmit(v5);
                VfxManager.DestroyEffect(v5, 4);
            end);
            task.delay(1.45 - v3, function() -- Line: 105
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v6 = script.Dash:Clone();
                v6.Parent = Debris;
                v6:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0.5, 0) * CFrame.Angles(0, 1.2566370614359172, 0));
                VfxManager.BetterEmit(v6);
                VfxManager.DestroyEffect(v6, 4);
            end);
            task.delay(0.7 - v3, function() -- Line: 113
                -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
                local v7 = script.Bounce:Clone();
                v7.Parent = Debris;
                v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
                VfxManager.BetterEmit(v7);
                VfxManager.DestroyEffect(v7, 4);
            end);
            task.delay(1.7 - v3, function() -- Line: 121
                -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
                local v8 = script.Bounce:Clone();
                v8.Parent = Debris;
                v8:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
                VfxManager.BetterEmit(v8);
                VfxManager.DestroyEffect(v8, 4);
            end);
            task.delay(2 - v3, function() -- Line: 129
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v9 = script.Dash:Clone();
                v9.Parent = Debris;
                v9:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0.5, 0));
                VfxManager.BetterEmit(v9);
                VfxManager.DestroyEffect(v9, 4);
            end);
            task.delay(2.7 - v3, function() -- Line: 137
                -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
                local v10 = script.Bounce:Clone();
                v10.Parent = Debris;
                v10:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
                VfxManager.BetterEmit(v10);
                VfxManager.DestroyEffect(v10, 4);
            end);
            local v11 = tick();

            repeat
                task.wait(0.1);
                local v12 = Essentials:CreateClone(Character);
                VfxManager.DestroyEffect(v12, 1);
            until tick() - v11 > 2.5 - v3;
        else
            if p2.Task == "Shot" then
                SfxManager:playSound({
                    Sound = "BBZ Curse King Red Line Shot",
                    Parent = HumanoidRootPart
                });
                task.delay(0.1 - v3, function() -- Line: 153
                    -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                    local v13 = script.TpDash:Clone();
                    v13.Parent = Debris;
                    v13:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0.5, 0));
                    VfxManager.BetterEmit(v13);
                    VfxManager.DestroyEffect(v13, 4);
                end);
                task.delay(0.7333333333333333 - v3, function() -- Line: 161
                    -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                    local v14 = script.Jump:Clone();
                    v14.Parent = Debris;
                    v14.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
                    VfxManager.BetterEmit(v14);
                    VfxManager.DestroyEffect(v14, 4);
                end);
                task.delay(1.3666666666666667 - v3, function() -- Line: 169
                    -- upvalues: BALL (copy), HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                    local v15 = script.Shoot:Clone();
                    v15:PivotTo(CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(-0.5235987755982988, 0, 0));
                    v15.Parent = Debris;
                    VfxManager.BetterEmit(v15);
                    VfxManager.DestroyEffect(v15, 4);
                end);

                return;
            end;

            if p2.Task == "Dismantle" then
                task.delay(0.16666666666666666 - v3, function() -- Line: 177
                    -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), Value (copy), VfxManager (ref)
                    SfxManager:playSound({
                        Sound = "BBZ Curse King Dismantle",
                        Parent = HumanoidRootPart
                    });
                    local v16 = script.Dismantle:Clone();
                    v16.Parent = Debris;
                    v16:PivotTo(CFrame.new(Value.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                    VfxManager.BetterEmit(v16);
                    VfxManager.DestroyEffect(v16, 4);
                end);
            end;
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Curse King Cleave Throw",
        Parent = HumanoidRootPart
    });
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u17 = ColorCorrection:Clone();
    u17.Name = "CC";
    u17.Parent = Lighting;
    u17.Enabled = true;
    task.delay(2.45 - v3, function() -- Line: 36
        -- upvalues: u17 (copy), Lighting (ref), ColorCorrection (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(0.43333333333333335 - v3, function() -- Line: 43
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v18 = script.Bounce:Clone();
        v18.Parent = Debris;
        v18:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
        VfxManager.BetterEmit(v18);
        VfxManager.DestroyEffect(v18, 4);
    end);
    task.delay(0.65 - v3, function() -- Line: 51
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v19 = script.Bounce:Clone();
        v19.Parent = Debris;
        v19:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
        VfxManager.BetterEmit(v19);
        VfxManager.DestroyEffect(v19, 4);
    end);
    task.delay(0.9 - v3, function() -- Line: 59
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v20 = script.Bounce:Clone();
        v20.Parent = Debris;
        v20:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
        VfxManager.BetterEmit(v20);
        VfxManager.DestroyEffect(v20, 4);
    end);
    task.delay(1.6 - v3, function() -- Line: 67
        -- upvalues: BALL (copy), HumanoidRootPart (copy), Debris (ref), VfxManager (ref), Lighting (ref), TweenService (ref), u17 (copy), ColorCorrection (copy)
        local v21 = script.Throw:Clone();
        v21:PivotTo(CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(0.7853981633974483, 0, 0));
        v21.Parent = Debris;
        VfxManager.BetterEmit(v21);
        VfxManager.DestroyEffect(v21, 4);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 30;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u17.Brightness = 1;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(155, 42, 42);
        TweenService:Create(u17, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
end;