 
 

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

    if p2.Task == "Fade" then
        SfxManager:playSound({
            Sound = "BBZ Emperor Fade",
            Parent = HumanoidRootPart
        });
        local Model = Instance.new("Model");
        Model.Parent = Debris;

        for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
            local v4 = Char:FindFirstChild(child.Name);

            if v4 then
                local v5 = child:Clone();
                v5.CFrame = v4.CFrame;
                v5.Parent = Model;
                Essentials:Weld(v5, v4);
            end;
        end;

        shared.vfx.emit(Model);
        task.delay(0.2833333333333333, function() -- Line: 44
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v6 = script.Fade.Bounce:Clone();
            v6.Parent = Debris;
            v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v6, 2);
            shared.vfx.emit(v6);
        end);
        task.delay(0.6666666666666666, function() -- Line: 53
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v7 = script.Fade.Bounce:Clone();
            v7.Parent = Debris;
            v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v7, 2);
            shared.vfx.emit(v7);
        end);
        task.delay(0.7833333333333333, function() -- Line: 62
            -- upvalues: Debris (ref), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
            local v8 = script.Fade.FlashStep:Clone();
            v8.Parent = Debris;
            v8.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v8, HumanoidRootPart);
            VfxManager.DestroyEffect(v8, 2);
            shared.vfx.emit(v8);
        end);
        task.delay(1.2333333333333334 - v3, function() -- Line: 72
            -- upvalues: VfxManager (ref), Model (copy), Debris (ref), HumanoidRootPart (copy), LocalPlayer (ref), Char (copy), Lighting (ref), TweenService (ref)
            VfxManager.Enable(Model, false);
            VfxManager.DestroyEffect(Model, 2);
            local v9 = script.Fade.Shoot:Clone();
            v9.Parent = Debris;
            v9:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v9, 4);
            shared.vfx.emit(v9);

            if LocalPlayer.Character == Char then
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Name = "CC";
                ColorCorrectionEffect.Parent = Lighting;
                ColorCorrectionEffect.Enabled = true;
                task.delay(0.75, function() -- Line: 89
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
                ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 110, 110);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                    Brightness = 0
                }):Play();
                local v10 = script.Fade.CameraFX:Clone();
                v10.Parent = Debris;
                VfxManager.DestroyEffect(v10, 2);
                shared.vfx.emit(v10);
            end;
        end);

        return;
    end;

    if p2.Task ~= "Forward" then
        if p2.Task ~= "Dribble" then
            local v11 = p2.Task == "Stun" and p2.otherRig;

            if v11 then
                local HumanoidRootPart2 = v11.HumanoidRootPart;
                task.delay(0.417 - v3, function() -- Line: 194
                    -- upvalues: HumanoidRootPart2 (copy), Debris (ref), VfxManager (ref)
                    if HumanoidRootPart2 then
                        local v12 = script.Dribble.Bounce:Clone();
                        v12.Parent = Debris;
                        v12:PivotTo(HumanoidRootPart2.CFrame * CFrame.new(0, -2.9, 0));
                        VfxManager.DestroyEffect(v12, 2);
                        shared.vfx.emit(v12);
                    end;
                end);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Emperor Dribble",
            Parent = HumanoidRootPart
        });
        task.delay(0.23333333333333334 - v3, function() -- Line: 170
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v13 = script.Dribble.Bounce:Clone();
            v13.Parent = Debris;
            v13:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v13, 2);
            shared.vfx.emit(v13);
        end);
        task.delay(0.4666666666666667 - v3, function() -- Line: 179
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v14 = script.Dribble.Bounce:Clone();
            v14.Parent = Debris;
            v14:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v14, 2);
            shared.vfx.emit(v14);
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
        local v15 = Char:FindFirstChild(child.Name);

        if v15 then
            local v16 = child:Clone();
            v16.CFrame = v15.CFrame;
            v16.Parent = Model;
            Essentials:Weld(v16, v15);
        end;
    end;

    local v17 = script.Dribble.AuraEmit:Clone();
    v17.Parent = Debris;
    v17:PivotTo(HumanoidRootPart.CFrame);
    VfxManager.DestroyEffect(v17, 2);
    shared.vfx.emit(Model, v17);
    task.delay(0.2 - v3, function() -- Line: 136
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v18 = script.Dribble.Bounce:Clone();
        v18.Parent = Debris;
        v18:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v18, 2);
        shared.vfx.emit(v18);
    end);
    task.delay(0.5333333333333333 - v3, function() -- Line: 145
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v19 = script.Dribble.Bounce:Clone();
        v19.Parent = Debris;
        v19:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v19, 2);
        shared.vfx.emit(v19);
    end);
    task.delay(1.05 - v3, function() -- Line: 154
        -- upvalues: VfxManager (ref), Model (copy), Debris (ref), BALL (copy), HumanoidRootPart (copy)
        VfxManager.Enable(Model, false);
        VfxManager.DestroyEffect(Model, 2);
        local v20 = script.Dribble.Bounce:Clone();
        v20.Parent = Debris;
        v20:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v20, 2);
        shared.vfx.emit(v20);
    end);
end;