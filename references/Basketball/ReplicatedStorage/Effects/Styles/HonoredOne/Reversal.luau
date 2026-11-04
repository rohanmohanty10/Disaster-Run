 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Lighting (copy), Debris (copy), Essentials (copy), VfxManager (copy), TweenService (copy), RunService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v4 = Character:FindFirstChild("Right Arm");
    local v5 = Character:FindFirstChild("Left Arm");
    local BALL = Character:FindFirstChild("BALL", true);
    local Value = ReplicatedStorage.Basketball.Value;

    if p2.Task ~= "Shot" then
        if p2.Task == "Dribble" then
            SfxManager:playSound({
                Sound = "BBZ Honored One Reversal Dribble",
                Parent = HumanoidRootPart
            });
            task.delay(0.35 - v3, function() -- Line: 139
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v6 = script.Throw:Clone();
                v6.Parent = Debris;
                v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.671, -0.402, -0.424) * CFrame.fromOrientation(-1.549084430900087, 0, 0);
                VfxManager.BetterEmit(v6);
                VfxManager.DestroyEffect(v6, 4);
            end);
            task.delay(0.7333333333333333 - v3, function() -- Line: 147
                -- upvalues: Debris (ref), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
                local v7 = script.Red:Clone();
                v7.Parent = Debris;
                v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.481, -0.522, -2.071) * CFrame.fromOrientation(0, 1.5707963267948966, 0);
                Essentials:Weld(v7, HumanoidRootPart);
                VfxManager.BetterEmit(v7);
                VfxManager.DestroyEffect(v7, 4);
            end);
            task.delay(1.5166666666666666 - v3, function() -- Line: 156
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v8 = script.Teleport1:Clone();
                v8.Parent = Debris;
                v8:PivotTo(HumanoidRootPart.CFrame * CFrame.new(1.705, -1.34, 0) * CFrame.fromOrientation(-0.03530801076784529, 0, 0));
                VfxManager.BetterEmit(v8);
                VfxManager.DestroyEffect(v8, 4);
                local v9 = script.Teleport2:Clone();
                v9.Parent = Debris;
                v9:PivotTo(HumanoidRootPart.CFrame * CFrame.new(1.705, -1.34, -7.064) * CFrame.fromOrientation(-0.03530801076784529, 0, 0));
                VfxManager.BetterEmit(v9);
                VfxManager.DestroyEffect(v9, 4);
            end);
            local v10 = tick();

            repeat
                task.wait(0.1);
                local v11 = Essentials:CreateClone(Character);
                VfxManager.DestroyEffect(v11, 1);
            until tick() - v10 > 1.5166666666666666 - v3;
        elseif p2.Task == "Dash" then
            SfxManager:playSound({
                Sound = "BBZ Honored One Hollow Dash",
                Parent = HumanoidRootPart
            });
            local u12 = script["Right Arm"]:Clone();
            u12.Parent = Debris;
            u12.CFrame = v4.CFrame;
            Essentials:Weld(u12, v4);
            local u13 = script["Left Arm"]:Clone();
            u13.Parent = Debris;
            u13.CFrame = v5.CFrame;
            Essentials:Weld(u13, v5);
            task.delay(0.4166666666666667 - v3, function() -- Line: 188
                -- upvalues: VfxManager (ref), u12 (copy), u13 (copy), Debris (ref), HumanoidRootPart (copy)
                VfxManager.BetterEmit(u12);
                VfxManager.BetterEmit(u13);
                VfxManager.DestroyEffect(u12, 4);
                VfxManager.DestroyEffect(u13, 4);
                local v14 = script.BlueEmit:Clone();
                v14.Parent = Debris;
                v14:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-2.189, -1.856, 2.241));
                VfxManager.BetterEmit(v14);
                VfxManager.DestroyEffect(v14, 4);
                local v15 = script.RedEmit:Clone();
                v15.Parent = Debris;
                v15:PivotTo(HumanoidRootPart.CFrame * CFrame.new(1.729, -1.856, 2.241));
                VfxManager.BetterEmit(v15);
                VfxManager.DestroyEffect(v15, 4);
            end);
            task.delay(1.1166666666666667 - v3, function() -- Line: 207
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v16 = script.PurpleEmit:Clone();
                v16.Parent = Debris;
                v16:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.376, -0.884, -1.934));
                VfxManager.BetterEmit(v16);
                VfxManager.DestroyEffect(v16, 4);
            end);
            task.delay(1.25 - v3, function() -- Line: 215
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v17 = script.Dash:Clone();
                v17.Parent = Debris;
                v17:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0.885, 10));
                VfxManager.BetterEmit(v17);
                VfxManager.DestroyEffect(v17, 4);
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Honored One Hollow Shot",
        Parent = HumanoidRootPart
    });
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u18 = ColorCorrection:Clone();
    u18.Name = "CC";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(3.15 - v3, function() -- Line: 39
        -- upvalues: u18 (copy), Lighting (ref), ColorCorrection (copy)
        u18:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local v19 = script.Ball:Clone();
    v19.Parent = Debris;
    v19.CFrame = BALL.CFrame;
    Essentials:Weld(v19, BALL);
    VfxManager.BetterEmit(v19);
    VfxManager.DestroyEffect(v19, 2.1333333333333333);
    local v20 = script.RedBall:Clone();
    v20.Parent = Debris;
    v20.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 3.673, -0.437);
    Essentials:Weld(v20, HumanoidRootPart);
    VfxManager.BetterEmit(v20);
    VfxManager.DestroyEffect(v20, 2.1333333333333333);
    local v21 = script.BlueAppear:Clone();
    v21.Parent = Debris;
    v21.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.709, -0.861, 0.182);
    VfxManager.BetterEmit(v21);
    VfxManager.DestroyEffect(v21, 2.1333333333333333);
    local v22 = script.RedAppear:Clone();
    v22.Parent = Debris;
    v22.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 3.663, -0.424);
    VfxManager.BetterEmit(v22);
    VfxManager.DestroyEffect(v22, 2.1333333333333333);
    local _, v23, _ = HumanoidRootPart.CFrame:ToOrientation();
    local u24 = script.AtmosphereGold:Clone();
    u24.Parent = Debris;
    u24.CFrame = CFrame.new(HumanoidRootPart.Position.X, 13.778, HumanoidRootPart.Position.Z) * CFrame.fromOrientation(0, v23, 0);
    task.delay(1.6333333333333333 - v3, function() -- Line: 77
        -- upvalues: TweenService (ref), u18 (copy)
        TweenService:Create(u18, TweenInfo.new(0.5), {
            Contrast = 1
        }):Play();
    end);
    task.delay(2.1333333333333333 - v3, function() -- Line: 81
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref), Lighting (ref), TweenService (ref), u18 (copy), u24 (copy)
        local v25 = script.PurpleAppear:Clone();
        v25.Parent = Debris;
        v25.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 3.663, -0.424);
        VfxManager.BetterEmit(v25);
        VfxManager.DestroyEffect(v25, 4);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u18.Brightness = -1;
        u18.Contrast = 2;
        u18.Saturation = -1;
        VfxManager.Enable(u24, false);
        VfxManager.DestroyEffect(u24, 10);
    end);
    task.delay(2.3 - v3, function() -- Line: 101
        -- upvalues: Debris (ref), Value (copy), VfxManager (ref), RunService (ref), Lighting (ref), TweenService (ref), u18 (copy), ColorCorrection (copy)
        local u26 = script.ShotBall:Clone();
        u26.Parent = Debris;
        u26.CFrame = Value.CFrame;
        VfxManager.BetterEmit(u26);
        VfxManager.DestroyEffect(u26, 10);
        local u27 = nil;
        u27 = RunService.RenderStepped:Connect(function() -- Line: 109
            -- upvalues: Value (ref), u26 (copy), u27 (ref)
            if Value and (Value.Parent and (u26 and u26.Parent)) then
                u26.CFrame = CFrame.new(Value.Position) * CFrame.fromOrientation(-0.33995523170345554, 3.0349879428779793, 2.303625173122276);

                return;
            end;

            u27:Disconnect();
        end);
        task.delay(2, function() -- Line: 117
            -- upvalues: u27 (ref)
            if u27 then
                u27:Disconnect();
            end;
        end);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u18.Brightness = 1;
        u18.Contrast = 2;
        u18.Saturation = -1;
        u18.TintColor = Color3.fromRGB(145, 28, 255);
        TweenService:Create(u18, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
end;