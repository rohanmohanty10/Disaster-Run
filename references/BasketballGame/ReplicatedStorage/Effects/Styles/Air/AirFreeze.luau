 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: SfxManager (copy), Effects (copy), Debris (copy), Essentials (copy), RunService (copy), VfxManager (copy), Lighting (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local BallController = p1.BallController;
    local _ = p1.CameraController;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Air Dribble" then
        if p2.Task == "Air Freeze" then
            local ServerBallPosition = BallController:GetServerBallPosition();
            SfxManager:playSound({
                Sound = "BBZ Air Air Freeze",
                Parent = workspace
            });
            Effects:SubtitleV2({ { "Commentator", "Ball stops. Air rises. Blocked in mid-air!", 4.5 } });
            SfxManager:playSound({
                Sound = "BBZ Air Air Freeze Voice",
                Parent = workspace
            });
            local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
            ColorCorrection.Enabled = false;
            local u4 = ColorCorrection:Clone();
            u4.Name = "CC";
            u4.Parent = Lighting;
            u4.Enabled = true;
            task.delay(1.9666666666666668 - v3, function() -- Line: 145
                -- upvalues: u4 (copy), Lighting (ref), ColorCorrection (copy)
                u4:Destroy();

                if not Lighting:FindFirstChild("CC") then
                    ColorCorrection.Enabled = true;
                end;
            end);
            task.spawn(function() -- Line: 152
                -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u4 (copy)
                local BlurEffect = Instance.new("BlurEffect", Lighting);
                BlurEffect.Size = 20;
                TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
                    Size = 0
                }):Play();
                VfxManager.DestroyEffect(BlurEffect, 0.455);
                TweenService:Create(u4, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
                    Brightness = -0.15,
                    Saturation = -1
                }):Play();
            end);
            task.delay(0.4166666666666667 - v3, function() -- Line: 161
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                local v5 = script.Jump:Clone();
                v5.CFrame = CFrame.new(HumanoidRootPart.Position.X, 1.1, HumanoidRootPart.Position.Z) * CFrame.Angles(0, 0, 3.141592653589793);
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 2);
            end);
            task.delay(1.1166666666666667 - v3, function() -- Line: 169
                -- upvalues: ServerBallPosition (copy), HumanoidRootPart (copy), Debris (ref), VfxManager (ref), Lighting (ref), TweenService (ref), u4 (copy), ColorCorrection (copy)
                local v6 = script.Block:Clone();
                v6.CFrame = CFrame.new(ServerBallPosition) * CFrame.fromOrientation(CFrame.new(HumanoidRootPart.Position, (Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z))):ToOrientation()) * CFrame.Angles(-0.7853981633974483, 0, 0);
                v6.Parent = Debris;
                VfxManager.Emit(v6);
                VfxManager.DestroyEffect(v6, 2);
                local BlurEffect = Instance.new("BlurEffect", Lighting);
                BlurEffect.Size = 35;
                TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
                    Size = 0
                }):Play();
                VfxManager.DestroyEffect(BlurEffect, 0.7);
                u4.Brightness = 1;
                u4.Saturation = -1;
                u4.TintColor = Color3.fromRGB(229, 48, 48);
                TweenService:Create(u4, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
                    TintColor = ColorCorrection.TintColor
                }):Play();
                TweenService:Create(u4, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
                    Brightness = ColorCorrection.Brightness,
                    Saturation = ColorCorrection.Saturation
                }):Play();
            end);
        end;

        return;
    end;

    local Torso = Character:FindFirstChild("Torso");

    if not Torso then
        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Air Air Dribble",
        Parent = HumanoidRootPart
    });

    if p2.Number == 1 then
        Effects:SubtitleV2({ { "Commentator", "Air is dribbling. Look at that speed! He\'s breaking ankles without even moving forward!", 5 } });
    elseif p2.Number == 2 then
        Effects:SubtitleV2({ { "Commentator", "Lighting dribble from Air! Too fast!", 3 } });
    end;

    SfxManager:playSound({
        Sound = `BBZ Air Air Dribble Voice{p2.Number}`,
        Parent = workspace
    });
    local u7 = script.Ball:Clone();
    u7.Parent = Debris;
    u7.CFrame = BALL.CFrame;
    Essentials:Weld(u7, BALL);
    local u8 = script.Torso:Clone();
    u8.Parent = Debris;
    local u9 = nil;
    u9 = RunService.RenderStepped:Connect(function() -- Line: 64
        -- upvalues: Torso (copy), u8 (copy), Debris (ref), u9 (ref), HumanoidRootPart (copy)
        if Torso and (u8 and u8:IsDescendantOf(Debris)) then
            u8.CFrame = CFrame.new(Torso.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());

            return;
        end;

        u9:Disconnect();
    end);
    task.delay(0.2 - v3, function() -- Line: 73
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v10 = script.Bounce:Clone();
        v10.Parent = Debris;
        v10.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v10);
        VfxManager.DestroyEffect(v10, 2);
    end);
    task.delay(0.2833333333333333 - v3, function() -- Line: 81
        -- upvalues: VfxManager (ref), u7 (copy), u8 (copy), Essentials (ref), Character (copy)
        VfxManager.Enable(u7, true);
        VfxManager.Enable(u8, true);
        local v11 = tick();

        repeat
            task.wait(0.1);
            local v12 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v12, 1);
        until tick() - v11 > 1.1;
    end);
    task.delay(0.5166666666666667 - v3, function() -- Line: 92
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v13 = script.Bounce:Clone();
        v13.Parent = Debris;
        v13.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v13);
        VfxManager.DestroyEffect(v13, 2);
    end);
    task.delay(0.8333333333333334 - v3, function() -- Line: 100
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v14 = script.Bounce:Clone();
        v14.Parent = Debris;
        v14.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v14);
        VfxManager.DestroyEffect(v14, 2);
    end);
    task.delay(1.1333333333333333 - v3, function() -- Line: 108
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v15 = script.Bounce:Clone();
        v15.Parent = Debris;
        v15.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v15);
        VfxManager.DestroyEffect(v15, 2);
    end);
    task.delay(1.3833333333333333 - v3, function() -- Line: 116
        -- upvalues: VfxManager (ref), u7 (copy), u8 (copy)
        VfxManager.Enable(u7, false);
        VfxManager.Enable(u8, false);
        VfxManager.DestroyEffect(u7, 2);
        VfxManager.DestroyEffect(u8, 2);
    end);
end;