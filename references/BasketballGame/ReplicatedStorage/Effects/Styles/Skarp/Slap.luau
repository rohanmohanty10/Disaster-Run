 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), SoundService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "Forward" then
        SfxManager:playSound({
            Sound = "BBZ Goat Forward",
            Parent = HumanoidRootPart
        });
        local u4 = script.Dribble.Ball:Clone();
        u4.Parent = Debris;
        u4.CFrame = BALL.CFrame;
        Essentials:Weld(u4, BALL);
        VfxManager.Enable(u4, true);
        task.delay(0.26666666666666666 - v3, function() -- Line: 31
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v5 = script.Dribble.FirstBounce:Clone();
            v5.Parent = Debris;
            v5:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 2);
        end);
        task.delay(0.5666666666666667 - v3, function() -- Line: 39
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v6 = script.Dribble.Bounce:Clone();
            v6.Parent = Debris;
            v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v6);
            VfxManager.DestroyEffect(v6, 2);
        end);
        task.delay(0.8833333333333333 - v3, function() -- Line: 47
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v7 = script.Dribble.Bounce:Clone();
            v7.Parent = Debris;
            v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v7);
            VfxManager.DestroyEffect(v7, 2);
        end);
        task.delay(1.25 - v3, function() -- Line: 55
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v8 = script.Dribble.Bounce:Clone();
            v8.Parent = Debris;
            v8:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v8);
            VfxManager.DestroyEffect(v8, 2);
        end);
        task.delay(1.6166666666666667 - v3, function() -- Line: 63
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v9 = script.Dribble.Bounce:Clone();
            v9.Parent = Debris;
            v9:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v9);
            VfxManager.DestroyEffect(v9, 2);
        end);
        task.delay(1.7666666666666666 - v3, function() -- Line: 71
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v10 = script.Dribble.Bounce:Clone();
            v10.Parent = Debris;
            v10:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 2);
        end);
        task.delay(1.5 - v3, function() -- Line: 79
            -- upvalues: VfxManager (ref), u4 (copy)
            VfxManager.Enable(u4, false);
            VfxManager.DestroyEffect(u4, 2);
        end);

        return;
    end;

    if p2.Task == "Dribble" then
        SfxManager:playSound({
            Sound = "BBZ Goat Dribble",
            Parent = HumanoidRootPart
        });
        local v11 = script.Dribble.Teleport:Clone();
        v11.Parent = Debris;
        v11.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v11, HumanoidRootPart);
        VfxManager.BetterEmit(v11);
        VfxManager.DestroyEffect(v11, 2);
        local u12 = { Character:FindFirstChild("BALL", true), Character:FindFirstChild("PlrBall") };
        Essentials:HideCharacter(Character, u12);
        task.delay(0.2, function() -- Line: 99
            -- upvalues: Essentials (ref), Character (copy), u12 (copy)
            Essentials:UnhideCharacter(Character, u12);
        end);

        return;
    end;

    if p2.Task == "Euro" then
        SfxManager:playSound({
            Sound = "BBZ perfect layup",
            Parent = HumanoidRootPart
        });
        local v13 = script.Euro.FirstDribble:Clone();
        v13.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.1801605224609375, -2.8731839656829834, -0.02066802978515625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
        v13.Parent = Debris;
        VfxManager.Emit(v13);
        VfxManager.DestroyEffect(v13, 2);
        task.delay(0.317, function() -- Line: 111
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart.Parent == nil then
                return;
            end;

            local v14 = script.Euro.Second:Clone();
            v14.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.2406959533691406, -2.8731839656829834, -1.2530975341796875) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v14.Parent = Debris;
            VfxManager.Emit(v14);
            VfxManager.DestroyEffect(v14, 2);
        end);
        task.delay(0.483, function() -- Line: 120
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart.Parent == nil then
                return;
            end;

            local v15 = script.Euro.Jump:Clone();
            v15:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.18754196166992188, -2.644024610519409, -0.21678924560546875) * CFrame.fromEulerAnglesYXZ(-0, 0, 0));
            v15.Parent = Debris;
            VfxManager.Emit(v15);
            VfxManager.DestroyEffect(v15, 2);
        end);
        task.delay(0.983, function() -- Line: 129
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart.Parent == nil then
                return;
            end;

            local v16 = script.Euro.shoot:Clone();
            v16:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-0.8473777770996094, 5.991437911987305, -2.818359375) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0));
            v16.Parent = Debris;
            VfxManager.Emit(v16);
            VfxManager.DestroyEffect(v16, 2);
        end);

        return;
    end;

    if p2.Task == "Fadeaway" then
        SfxManager:playSound({
            Sound = "BBZ perfect spin shot base",
            Parent = HumanoidRootPart
        }).TimePosition = 0.7;
        local u17 = script.Fadeaway.Enable:Clone();
        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        Highlight.FillColor = Color3.new(1, 0, 0);
        Highlight.FillTransparency = 0.5;
        Highlight.OutlineColor = Color3.new(1, 1, 1);
        Highlight.OutlineTransparency = 0;
        Highlight.Parent = u17;
        u17.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.6990280151367188, 1.4070186614990234, 0.0337371826171875) * CFrame.fromEulerAnglesYXZ(-1.5707963705062866, -0, 0);
        u17.Parent = Debris;
        VfxManager.DestroyEffect(u17, 3);
        VfxManager.Enable(u17, true);
        Essentials:Weld(u17, HumanoidRootPart);

        if HumanoidRootPart.Parent == nil then
            return;
        end;

        local v18 = script.Fadeaway.Jump:Clone();
        v18:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.18754196166992188, -2.644024610519409, -0.21678924560546875) * CFrame.fromEulerAnglesYXZ(-0, 0, 0));
        v18.Parent = Debris;
        VfxManager.Emit(v18);
        VfxManager.DestroyEffect(v18, 2);
        task.delay(0.383 - v3, function() -- Line: 166
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), u17 (copy)
            if HumanoidRootPart.Parent == nil then
                return;
            end;

            local v19 = script.Fadeaway.Release:Clone();
            v19.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.28606414794921875, 4.669114589691162, 0.8605880737304688) * CFrame.fromEulerAnglesYXZ(0.5759586691856384, 0, 0);
            v19.Parent = Debris;
            VfxManager.Emit(v19);
            VfxManager.DestroyEffect(v19, 2);
            task.wait(0.1);

            if u17 then
                VfxManager.Enable(u17, false);
                VfxManager.DestroyEffect(u17, 2);
            end;
        end);

        return;
    end;

    if p2.Task == "Slap" then
        task.delay(0.75, function() -- Line: 183
            -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), Essentials (ref), VfxManager (ref)
            SfxManager:playSound({
                Sound = "BBZ Skarp Lightning Slap",
                Parent = HumanoidRootPart
            });
            local v20 = script.Slap.MainImpact:Clone();
            v20.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -5);
            v20.Parent = Debris;
            Essentials:Weld(v20, HumanoidRootPart);
            VfxManager.Emit(v20);
            VfxManager.DestroyEffect(v20, 4);
        end);

        return;
    end;

    if p2.Task == "Hit" then
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
        local v21 = script.Vignette:Clone();
        v21.Parent = PlayerGui;
        v21.Enabled = true;
        local Vignette = v21.Vignette;
        local Vignette1 = v21.Vignette1;
        Vignette.ImageTransparency = 0;
        Vignette1.ImageTransparency = 0.5;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 0, 0);
        local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
        ColorCorrection.Enabled = false;
        local u22 = ColorCorrection:Clone();
        u22.Name = "CC";
        u22.Parent = Lighting;
        u22.Enabled = true;
        u22.Brightness = -0.15;
        u22.Contrast = 10;
        u22.Saturation = -1;
        task.wait(0.05);
        u22.Contrast = -10;
        task.wait(0.05);
        u22.Contrast = 10;
        task.wait(0.05);
        u22.Contrast = ColorCorrection.Contrast;
        u22.TintColor = Color3.fromRGB(155, 0, 0);
        TweenService:Create(u22, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Parent = Lighting;
        SoundService.AmbientReverb = Enum.ReverbType.UnderWater;
        local v23 = tick();

        while true do
            wait();

            if tick() - v23 > 9.65 or not (LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("IsRagdoll") and LocalPlayer.Character.IsRagdoll.Value)) then
                break;
            end;

            task.wait(1);
            TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Size = 20
            }):Play();

            if tick() - v23 > 9.65 or not (LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("IsRagdoll") and LocalPlayer.Character.IsRagdoll.Value)) then
                break;
            end;

            task.wait(1);
            TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = 15
            }):Play();

            if tick() - v23 > 9.65 or not (LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("IsRagdoll") and LocalPlayer.Character.IsRagdoll.Value)) then
                break;
            end;
        end;

        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        VfxManager.DestroyEffect(v21, 1);
        TweenService:Create(u22, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        task.delay(1, function() -- Line: 256
            -- upvalues: u22 (copy), Lighting (ref), ColorCorrection (copy), SoundService (ref)
            u22:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;

            SoundService.AmbientReverb = Enum.ReverbType.NoReverb;
        end);
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
    end;
end;