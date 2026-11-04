 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    local BALL = Char:FindFirstChild("BALL", true);
    local u4 = script.Parent:GetAttribute("Color") or Color3.fromRGB(255, 255, 255);

    if p2.Task == "Fade" then
        SfxManager:playSound({
            Sound = "BBZ Emperor Fade",
            Parent = HumanoidRootPart
        });
        local Model = Instance.new("Model");
        Model.Parent = Debris;

        for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
            local v5 = Char:FindFirstChild(child.Name);

            if v5 then
                local v6 = child:Clone();
                v6.CFrame = v5.CFrame;
                v6.Parent = Model;
                Essentials:Weld(v6, v5);
            end;
        end;

        shared.vfx.emit(Model);
        task.delay(0.2833333333333333, function() -- Line: 46
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v7 = script.Fade.Bounce:Clone();
            v7.Parent = Debris;
            v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v7, 2);
            shared.vfx.emit(v7);
        end);
        task.delay(0.6666666666666666, function() -- Line: 55
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v8 = script.Fade.Bounce:Clone();
            v8.Parent = Debris;
            v8:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v8, 2);
            shared.vfx.emit(v8);
        end);
        task.delay(0.7833333333333333, function() -- Line: 64
            -- upvalues: Debris (ref), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
            local v9 = script.Fade.FlashStep:Clone();
            v9.Parent = Debris;
            v9.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v9, HumanoidRootPart);
            VfxManager.DestroyEffect(v9, 2);
            shared.vfx.emit(v9);
        end);
        task.delay(1.2333333333333334 - v3, function() -- Line: 74
            -- upvalues: VfxManager (ref), Model (copy), Debris (ref), HumanoidRootPart (copy), LocalPlayer (ref), Char (copy), Lighting (ref), TweenService (ref), u4 (copy)
            VfxManager.Enable(Model, false);
            VfxManager.DestroyEffect(Model, 2);
            local v10 = script.Fade.Shoot:Clone();
            v10.Parent = Debris;
            v10:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v10, 4);
            shared.vfx.emit(v10);

            if LocalPlayer.Character == Char then
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Name = "CC";
                ColorCorrectionEffect.Parent = Lighting;
                ColorCorrectionEffect.Enabled = true;
                task.delay(0.75, function() -- Line: 91
                    -- upvalues: ColorCorrectionEffect (copy)
                    ColorCorrectionEffect:Destroy();
                end);
                local BlurEffect = Instance.new("BlurEffect", Lighting);
                BlurEffect.Size = 5;
                TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = 0
                }):Play();
                VfxManager.DestroyEffect(BlurEffect, 0.5);
                ColorCorrectionEffect.Brightness = 0.45;
                ColorCorrectionEffect.TintColor = u4;
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                    Brightness = 0
                }):Play();
                local v11 = script.Fade.CameraFX:Clone();
                v11.Parent = Debris;
                VfxManager.DestroyEffect(v11, 2);
                shared.vfx.emit(v11);
            end;
        end);

        return;
    end;

    if p2.Task ~= "Forward" then
        if p2.Task ~= "Dribble" then
            local v12 = p2.Task == "Stun" and p2.otherRig;

            if v12 then
                local HumanoidRootPart2 = v12.HumanoidRootPart;
                task.delay(0.417 - v3, function() -- Line: 196
                    -- upvalues: HumanoidRootPart2 (copy), Debris (ref), VfxManager (ref)
                    if HumanoidRootPart2 then
                        local v13 = script.Dribble.Bounce:Clone();
                        v13.Parent = Debris;
                        v13:PivotTo(HumanoidRootPart2.CFrame * CFrame.new(0, -2.9, 0));
                        VfxManager.DestroyEffect(v13, 2);
                        shared.vfx.emit(v13);
                    end;
                end);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Emperor Dribble",
            Parent = HumanoidRootPart
        });
        task.delay(0.23333333333333334 - v3, function() -- Line: 172
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v14 = script.Dribble.Bounce:Clone();
            v14.Parent = Debris;
            v14:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v14, 2);
            shared.vfx.emit(v14);
        end);
        task.delay(0.4666666666666667 - v3, function() -- Line: 181
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v15 = script.Dribble.Bounce:Clone();
            v15.Parent = Debris;
            v15:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v15, 2);
            shared.vfx.emit(v15);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Emperor Forward",
        Parent = HumanoidRootPart
    });
    local Model = Instance.new("Model");
    Model.Parent = Debris;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v16 = Char:FindFirstChild(child.Name);

        if v16 then
            local v17 = child:Clone();
            v17.CFrame = v16.CFrame;
            v17.Parent = Model;
            Essentials:Weld(v17, v16);
        end;
    end;

    local v18 = script.Dribble.AuraEmit:Clone();
    v18.Parent = Debris;
    v18:PivotTo(HumanoidRootPart.CFrame);
    VfxManager.DestroyEffect(v18, 2);
    shared.vfx.emit(Model, v18);
    task.delay(0.2 - v3, function() -- Line: 138
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v19 = script.Dribble.Bounce:Clone();
        v19.Parent = Debris;
        v19:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v19, 2);
        shared.vfx.emit(v19);
    end);
    task.delay(0.5333333333333333 - v3, function() -- Line: 147
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v20 = script.Dribble.Bounce:Clone();
        v20.Parent = Debris;
        v20:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v20, 2);
        shared.vfx.emit(v20);
    end);
    task.delay(1.05 - v3, function() -- Line: 156
        -- upvalues: VfxManager (ref), Model (copy), Debris (ref), BALL (copy), HumanoidRootPart (copy)
        VfxManager.Enable(Model, false);
        VfxManager.DestroyEffect(Model, 2);
        local v21 = script.Dribble.Bounce:Clone();
        v21.Parent = Debris;
        v21:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v21, 2);
        shared.vfx.emit(v21);
    end);
end;