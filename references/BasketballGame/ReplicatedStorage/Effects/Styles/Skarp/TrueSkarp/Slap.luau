 
 

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
    local v4 = script.Parent:GetAttribute("Color") or Color3.fromRGB(255, 255, 255);

    if p2.Task == "Forward" then
        SfxManager:playSound({
            Sound = "BBZ Goat Forward",
            Parent = HumanoidRootPart
        });
        local u5 = script.Dribble.Ball:Clone();
        u5.Parent = Debris;
        u5.CFrame = BALL.CFrame;
        Essentials:Weld(u5, BALL);
        VfxManager.Enable(u5, true);
        task.delay(0.26666666666666666 - v3, function() -- Line: 33
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v6 = script.Dribble.FirstBounce:Clone();
            v6.Parent = Debris;
            v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v6);
            VfxManager.DestroyEffect(v6, 2);
        end);
        task.delay(0.5666666666666667 - v3, function() -- Line: 41
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v7 = script.Dribble.Bounce:Clone();
            v7.Parent = Debris;
            v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v7);
            VfxManager.DestroyEffect(v7, 2);
        end);
        task.delay(0.8833333333333333 - v3, function() -- Line: 49
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v8 = script.Dribble.Bounce:Clone();
            v8.Parent = Debris;
            v8:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v8);
            VfxManager.DestroyEffect(v8, 2);
        end);
        task.delay(1.25 - v3, function() -- Line: 57
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v9 = script.Dribble.Bounce:Clone();
            v9.Parent = Debris;
            v9:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v9);
            VfxManager.DestroyEffect(v9, 2);
        end);
        task.delay(1.6166666666666667 - v3, function() -- Line: 65
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v10 = script.Dribble.Bounce:Clone();
            v10.Parent = Debris;
            v10:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 2);
        end);
        task.delay(1.7666666666666666 - v3, function() -- Line: 73
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v11 = script.Dribble.Bounce:Clone();
            v11.Parent = Debris;
            v11:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0));
            VfxManager.Emit(v11);
            VfxManager.DestroyEffect(v11, 2);
        end);
        task.delay(1.5 - v3, function() -- Line: 81
            -- upvalues: VfxManager (ref), u5 (copy)
            VfxManager.Enable(u5, false);
            VfxManager.DestroyEffect(u5, 2);
        end);

        return;
    end;

    if p2.Task == "Dribble" then
        SfxManager:playSound({
            Sound = "BBZ Goat Dribble",
            Parent = HumanoidRootPart
        });
        local v12 = script.Dribble.Teleport:Clone();
        v12.Parent = Debris;
        v12.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v12, HumanoidRootPart);
        VfxManager.BetterEmit(v12);
        VfxManager.DestroyEffect(v12, 2);
        local u13 = { Character:FindFirstChild("BALL", true), Character:FindFirstChild("PlrBall") };
        Essentials:HideCharacter(Character, u13);
        task.delay(0.2, function() -- Line: 101
            -- upvalues: Essentials (ref), Character (copy), u13 (copy)
            Essentials:UnhideCharacter(Character, u13);
        end);

        return;
    end;

    if p2.Task == "Euro" then
        SfxManager:playSound({
            Sound = "BBZ perfect layup",
            Parent = HumanoidRootPart
        });
        local v14 = script.Euro.FirstDribble:Clone();
        v14.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.1801605224609375, -2.8731839656829834, -0.02066802978515625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
        v14.Parent = Debris;
        VfxManager.Emit(v14);
        VfxManager.DestroyEffect(v14, 2);
        task.delay(0.317, function() -- Line: 113
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart.Parent == nil then
                return;
            end;

            local v15 = script.Euro.Second:Clone();
            v15.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.2406959533691406, -2.8731839656829834, -1.2530975341796875) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v15.Parent = Debris;
            VfxManager.Emit(v15);
            VfxManager.DestroyEffect(v15, 2);
        end);
        task.delay(0.483, function() -- Line: 122
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart.Parent == nil then
                return;
            end;

            local v16 = script.Euro.Jump:Clone();
            v16:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.18754196166992188, -2.644024610519409, -0.21678924560546875) * CFrame.fromEulerAnglesYXZ(-0, 0, 0));
            v16.Parent = Debris;
            VfxManager.Emit(v16);
            VfxManager.DestroyEffect(v16, 2);
        end);
        task.delay(0.983, function() -- Line: 131
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart.Parent == nil then
                return;
            end;

            local v17 = script.Euro.shoot:Clone();
            v17:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-0.8473777770996094, 5.991437911987305, -2.818359375) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0));
            v17.Parent = Debris;
            VfxManager.Emit(v17);
            VfxManager.DestroyEffect(v17, 2);
        end);

        return;
    end;

    if p2.Task == "Fadeaway" then
        SfxManager:playSound({
            Sound = "BBZ perfect spin shot base",
            Parent = HumanoidRootPart
        }).TimePosition = 0.7;
        local u18 = script.Fadeaway.Enable:Clone();
        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        Highlight.FillColor = Color3.new(1, 0, 0);
        Highlight.FillTransparency = 0.5;
        Highlight.OutlineColor = Color3.new(1, 1, 1);
        Highlight.OutlineTransparency = 0;
        Highlight.Parent = u18;
        u18.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.6990280151367188, 1.4070186614990234, 0.0337371826171875) * CFrame.fromEulerAnglesYXZ(-1.5707963705062866, -0, 0);
        u18.Parent = Debris;
        VfxManager.DestroyEffect(u18, 3);
        VfxManager.Enable(u18, true);
        Essentials:Weld(u18, HumanoidRootPart);

        if HumanoidRootPart.Parent == nil then
            return;
        end;

        local v19 = script.Fadeaway.Jump:Clone();
        v19:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.18754196166992188, -2.644024610519409, -0.21678924560546875) * CFrame.fromEulerAnglesYXZ(-0, 0, 0));
        v19.Parent = Debris;
        VfxManager.Emit(v19);
        VfxManager.DestroyEffect(v19, 2);
        task.delay(0.383 - v3, function() -- Line: 168
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), u18 (copy)
            if HumanoidRootPart.Parent == nil then
                return;
            end;

            local v20 = script.Fadeaway.Release:Clone();
            v20.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.28606414794921875, 4.669114589691162, 0.8605880737304688) * CFrame.fromEulerAnglesYXZ(0.5759586691856384, 0, 0);
            v20.Parent = Debris;
            VfxManager.Emit(v20);
            VfxManager.DestroyEffect(v20, 2);
            task.wait(0.1);

            if u18 then
                VfxManager.Enable(u18, false);
                VfxManager.DestroyEffect(u18, 2);
            end;
        end);

        return;
    end;

    if p2.Task == "Slap" then
        task.delay(0.75, function() -- Line: 185
            -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), Essentials (ref), VfxManager (ref)
            SfxManager:playSound({
                Sound = "BBZ Skarp Lightning Slap",
                Parent = HumanoidRootPart
            });
            local v21 = script.Slap.MainImpact:Clone();
            v21.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -5);
            v21.Parent = Debris;
            Essentials:Weld(v21, HumanoidRootPart);
            VfxManager.Emit(v21);
            VfxManager.DestroyEffect(v21, 4);
        end);

        return;
    end;

    if p2.Task == "Hit" then
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
        local v22 = script.Vignette:Clone();
        v22.Parent = PlayerGui;
        v22.Enabled = true;
        local Vignette = v22.Vignette;
        local Vignette1 = v22.Vignette1;
        Vignette.ImageTransparency = 0;
        Vignette1.ImageTransparency = 0.5;
        Vignette1.ImageColor3 = v4;
        local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
        ColorCorrection.Enabled = false;
        local u23 = ColorCorrection:Clone();
        u23.Name = "CC";
        u23.Parent = Lighting;
        u23.Enabled = true;
        u23.Brightness = -0.15;
        u23.Contrast = 10;
        u23.Saturation = -1;
        task.wait(0.05);
        u23.Contrast = -10;
        task.wait(0.05);
        u23.Contrast = 10;
        task.wait(0.05);
        u23.Contrast = ColorCorrection.Contrast;
        u23.TintColor = v4;
        TweenService:Create(u23, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Parent = Lighting;
        SoundService.AmbientReverb = Enum.ReverbType.UnderWater;
        local v24 = tick();

        while true do
            wait();

            if tick() - v24 > 14.65 or not (LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("IsRagdoll") and LocalPlayer.Character.IsRagdoll.Value)) then
                break;
            end;

            task.wait(1);
            TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Size = 20
            }):Play();

            if tick() - v24 > 14.65 or not (LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("IsRagdoll") and LocalPlayer.Character.IsRagdoll.Value)) then
                break;
            end;

            task.wait(1);
            TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = 15
            }):Play();

            if tick() - v24 > 14.65 or not (LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("IsRagdoll") and LocalPlayer.Character.IsRagdoll.Value)) then
                break;
            end;
        end;

        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        VfxManager.DestroyEffect(v22, 1);
        TweenService:Create(u23, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        task.delay(1, function() -- Line: 258
            -- upvalues: u23 (copy), Lighting (ref), ColorCorrection (copy), SoundService (ref)
            u23:Destroy();

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