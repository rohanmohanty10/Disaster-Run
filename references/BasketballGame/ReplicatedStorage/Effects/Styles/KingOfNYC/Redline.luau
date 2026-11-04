 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 18
    -- upvalues: SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy), Debris (copy), Essentials (copy), Part_Icles (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Start" then
        if p2.Task == "End" then
            if LocalPlayer.Character == Character or p2.Stunned and table.find(p2.Stunned, LocalPlayer.Character) then
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Name = "CCAddon";
                ColorCorrectionEffect.Parent = Lighting;
                ColorCorrectionEffect.Enabled = true;
                task.delay(1.5, function() -- Line: 129
                    -- upvalues: ColorCorrectionEffect (copy)
                    ColorCorrectionEffect:Destroy();
                end);
                local BlurEffect = Instance.new("BlurEffect", Lighting);
                BlurEffect.Size = 15;
                TweenService:Create(BlurEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = 0
                }):Play();
                VfxManager.DestroyEffect(BlurEffect, 0.75);
                ColorCorrectionEffect.Brightness = 0.45;
                ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 100, 100);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
                    Brightness = 0
                }):Play();
            end;

            local v4 = p2.CFrame or HumanoidRootPart.CFrame;
            local _, v5, _ = v4:ToOrientation();
            local Part = Instance.new("Part");
            Part.Parent = Debris;
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Size = Vector3.new(0, 0.1, 1);
            Part.CFrame = CFrame.new(v4.Position.X, 1, v4.Position.Z) * CFrame.fromOrientation(0, v5, 0);
            Part.Color = Color3.fromRGB(255, 0, 0);
            Part.Material = Enum.Material.Neon;
            TweenService:Create(Part, TweenInfo.new(0.25 - v3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = Vector3.new(32, 0.1, 1),
                CFrame = Part.CFrame * CFrame.new(16 * (p2.Side == "R" and 1 or -1), 1, 0)
            }):Play();
            task.delay(0.25 - v3, function() -- Line: 161
                -- upvalues: TweenService (ref), Part (copy), VfxManager (ref)
                TweenService:Create(Part, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = Vector3.new(35, 0.1, 0),
                    Transparency = 1
                }):Play();
                VfxManager.DestroyEffect(Part, 0.25);
            end);
            local v6 = script.Dash:Clone();
            v6.Parent = Debris;
            v6:PivotTo(HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(0, p2.Side == "R" and 3.141592653589793 or 0, 0));
            v6.FinalSlash.CFrame = CFrame.new(0, 0, -1.571);
            Part_Icles:AbsoluteEmit(v6);
            VfxManager.DestroyEffect(v6, 2);
            task.delay(0.5166666666666667 - v3, function() -- Line: 173
                -- upvalues: Debris (ref), HumanoidRootPart (copy), Part_Icles (ref), VfxManager (ref)
                local v7 = script.Jump:Clone();
                v7.Parent = Debris;
                v7:PivotTo(HumanoidRootPart.CFrame);
                Part_Icles:AbsoluteEmit(v7);
                VfxManager.DestroyEffect(v7, 2);
            end);
            task.delay(0.75 - v3, function() -- Line: 181
                -- upvalues: Debris (ref), HumanoidRootPart (copy), Part_Icles (ref), VfxManager (ref)
                local v8 = script.Throw:Clone();
                v8.Parent = Debris;
                v8:PivotTo(HumanoidRootPart.CFrame);
                Part_Icles:AbsoluteEmit(v8);
                VfxManager.DestroyEffect(v8, 2);
            end);
            local v9 = tick();

            repeat
                task.wait(0.05 * (1 + (tick() - v9) / 0.25));
                local v10 = Essentials:CreateClone(Character);
                VfxManager.DestroyEffect(v10, 1);
            until tick() - v9 > 0.25;
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ King Of NYC Redline",
        Parent = HumanoidRootPart
    });

    if LocalPlayer.Character == Character then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Name = "CCAddon";
        ColorCorrectionEffect.Parent = Lighting;
        ColorCorrectionEffect.Enabled = true;
        task.delay(0.75, function() -- Line: 36
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
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 170, 100);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
    end;

    local v11 = script.Aura:Clone();
    v11.Parent = Debris;
    v11:PivotTo(HumanoidRootPart.CFrame);
    Essentials:Weld(v11.PrimaryPart, HumanoidRootPart);
    Part_Icles:AbsoluteEmit(v11);
    VfxManager.DestroyEffect(v11, 4);
    local _, u12, _ = HumanoidRootPart.CFrame:ToOrientation();
    local v13 = script.Bounce:Clone();
    v13.Parent = Debris;
    v13.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.fromOrientation(0, u12, 0);
    Part_Icles:AbsoluteEmit(v13);
    VfxManager.DestroyEffect(v13, 2);
    task.delay(0.16666666666666666 - v3, function() -- Line: 67
        -- upvalues: Debris (ref), BALL (copy), u12 (copy), Part_Icles (ref), VfxManager (ref)
        local v14 = script.Bounce:Clone();
        v14.Parent = Debris;
        v14.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.fromOrientation(0, u12 * 3.141592653589793, 0);
        Part_Icles:AbsoluteEmit(v14);
        VfxManager.DestroyEffect(v14, 2);
    end);
    task.delay(0.2833333333333333 - v3, function() -- Line: 75
        -- upvalues: Debris (ref), BALL (copy), u12 (copy), Part_Icles (ref), VfxManager (ref)
        local v15 = script.Bounce:Clone();
        v15.Parent = Debris;
        v15.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.fromOrientation(0, u12, 0);
        Part_Icles:AbsoluteEmit(v15);
        VfxManager.DestroyEffect(v15, 2);
    end);
    task.delay(0.45 - v3, function() -- Line: 83
        -- upvalues: Debris (ref), BALL (copy), u12 (copy), Part_Icles (ref), VfxManager (ref)
        local v16 = script.Bounce:Clone();
        v16.Parent = Debris;
        v16.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.fromOrientation(0, u12 * 3.141592653589793, 0);
        Part_Icles:AbsoluteEmit(v16);
        VfxManager.DestroyEffect(v16, 2);
    end);
    task.delay(0.5166666666666667 - v3, function() -- Line: 91
        -- upvalues: Debris (ref), BALL (copy), u12 (copy), Part_Icles (ref), VfxManager (ref)
        local v17 = script.Bounce:Clone();
        v17.Parent = Debris;
        v17.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.fromOrientation(0, u12, 0);
        Part_Icles:AbsoluteEmit(v17);
        VfxManager.DestroyEffect(v17, 2);
    end);
    task.delay(0.6833333333333333 - v3, function() -- Line: 99
        -- upvalues: Debris (ref), BALL (copy), u12 (copy), Part_Icles (ref), VfxManager (ref)
        local v18 = script.Bounce:Clone();
        v18.Parent = Debris;
        v18.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.fromOrientation(0, u12 * 3.141592653589793, 0);
        Part_Icles:AbsoluteEmit(v18);
        VfxManager.DestroyEffect(v18, 2);
    end);
    task.delay(0.8 - v3, function() -- Line: 107
        -- upvalues: Debris (ref), BALL (copy), u12 (copy), Part_Icles (ref), VfxManager (ref)
        local v19 = script.Bounce:Clone();
        v19.Parent = Debris;
        v19.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.fromOrientation(0, u12, 0);
        Part_Icles:AbsoluteEmit(v19);
        VfxManager.DestroyEffect(v19, 2);
    end);
    task.delay(0.9166666666666666 - v3, function() -- Line: 115
        -- upvalues: Debris (ref), BALL (copy), u12 (copy), Part_Icles (ref), VfxManager (ref)
        local v20 = script.Bounce:Clone();
        v20.Parent = Debris;
        v20.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.fromOrientation(0, u12 * 3.141592653589793, 0);
        Part_Icles:AbsoluteEmit(v20);
        VfxManager.DestroyEffect(v20, 2);
    end);
end;