 
 

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
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    local BALL = Char:FindFirstChild("BALL", true);

    if p2.Task == "Pass" then
        SfxManager:playSound({
            Sound = "BBZ Emperor Ultimate Pass",
            Parent = HumanoidRootPart
        });
        local v4 = script.Pass.Bounce:Clone();
        v4.Parent = Debris;
        v4:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v4, 2);
        shared.vfx.emit(v4);
        task.delay(0.23333333333333334 - v3, function() -- Line: 36
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v5 = script.Pass.Bounce:Clone();
            v5.Parent = Debris;
            v5:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v5, 2);
            shared.vfx.emit(v5);
        end);
        task.delay(0.6333333333333333 - v3, function() -- Line: 45
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v6 = script.Pass.Pass:Clone();
            v6.Parent = Debris;
            v6:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v6, 4);
            shared.vfx.emit(v6);
        end);

        return;
    end;

    if p2.Task == "ReturnPass" then
        SfxManager:playSound({
            Sound = "BBZ Emperor Ultimate Layup",
            Parent = HumanoidRootPart
        });

        if LocalPlayer.Character == Char or LocalPlayer.Character == p2.Other then
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Name = "CC";
            ColorCorrectionEffect.Parent = Lighting;
            ColorCorrectionEffect.Enabled = true;
            task.delay(0.75, function() -- Line: 64
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
        end;

        task.delay(0.18333333333333332 - v3, function() -- Line: 80
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v7 = script.Layup.Step1:Clone();
            v7.Parent = Debris;
            v7:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v7, 2);
            shared.vfx.emit(v7);
        end);
        task.delay(0.6333333333333333 - v3, function() -- Line: 89
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v8 = script.Layup.Step2:Clone();
            v8.Parent = Debris;
            v8:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v8, 2);
            shared.vfx.emit(v8);
        end);
        task.delay(1.0833333333333333 - v3, function() -- Line: 98
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v9 = script.Layup.Shoot:Clone();
            v9.Parent = Debris;
            v9:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v9, 2);
            shared.vfx.emit(v9);
        end);

        return;
    end;

    if p2.Task ~= "Highlight" then
        if p2.Task ~= "Dribble" then
            if p2.Task == "Block" then
                SfxManager:playSound({
                    Sound = "BBZ Emperor Reach",
                    Parent = HumanoidRootPart
                });

                if Char:FindFirstChild(script.Name .. "Highlight") then
                    Char:FindFirstChild(script.Name .. "Highlight"):Destroy();
                end;

                local v10 = script.Block.FlashStep:Clone();
                v10.Parent = Debris;
                v10.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(v10, HumanoidRootPart);
                VfxManager.DestroyEffect(v10, 2);
                shared.vfx.emit(v10);
                task.delay(0.16666666666666666 - v3, function() -- Line: 173
                    -- upvalues: Debris (ref), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
                    local v11 = script.Block.Steal:Clone();
                    v11.Parent = Debris;
                    v11:PivotTo(HumanoidRootPart.CFrame);
                    Essentials:Weld(v11.PrimaryPart, HumanoidRootPart);
                    VfxManager.DestroyEffect(v11, 2);
                    shared.vfx.emit(v11);
                end);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Emperor Nutmeg",
            Parent = HumanoidRootPart
        });
        local Model = Instance.new("Model");
        Model.Parent = Debris;

        for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
            local v12 = Char:FindFirstChild(child.Name);

            if v12 then
                local v13 = child:Clone();
                v13.CFrame = v12.CFrame;
                v13.Parent = Model;
                Essentials:Weld(v13, v12);
            end;
        end;

        shared.vfx.emit(Model);
        task.delay(0.15 - v3, function() -- Line: 143
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v14 = script.Dribble.Bounce:Clone();
            v14.Parent = Debris;
            v14:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v14, 2);
            shared.vfx.emit(v14);
        end);
        task.delay(0.5 - v3, function() -- Line: 152
            -- upvalues: VfxManager (ref), Model (copy)
            VfxManager.Enable(Model, false);
            VfxManager.DestroyEffect(Model, 2);
        end);

        return;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.Name = script.Name .. "Highlight";
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(255, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    task.delay(7, function() -- Line: 118
        -- upvalues: Highlight (copy)
        if Highlight then
            Highlight:Destroy();
        end;
    end);
end;