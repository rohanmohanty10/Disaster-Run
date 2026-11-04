 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 22, Name: LiberationDribble
    -- upvalues: LocalPlayer (copy), u5 (ref), Knit (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u6 (ref), Effects (copy), TweenService (copy), CameraShaker (copy), SfxManager (copy), RunService (copy), Cooldowns (copy)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u5 = Knit.GetController("CameraController");
    u2 = u7.MovementController;
    u4 = u7.BallController;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u6 = u7.Network;

    if not u7.LiberationDribble then
        u7.CanPressLiberation = true;
        u7.LiberationDribble = 0;
    end;

    if u7.DelayTask then
        task.cancel(u7.DelayTask);
        u7.DelayTask = nil;
    end;

    if u7.CanPressLiberation == false then
        Effects:Popup("Too early!", 1);
        u7.LiberationDribble = nil;

        if u7.LiberationGUI then
            u7.LiberationGUI:Destroy();
            u7.LiberationGUI = nil;
        end;

        return;
    end;

    u7.LiberationDribble = u7.LiberationDribble + 1;

    if u7.LiberationGUI then
        u7.LiberationGUI.Container.Circle.Size = UDim2.new(1.25, 0, 1.25, 0);
        TweenService:Create(u7.LiberationGUI.Container.Circle, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play();
    end;

    u7.CanPressLiberation = false;

    if u7.LiberationDribble > 3 then
        u7.LiberationDribble = nil;

        if u7.LiberationGUI then
            u7.LiberationGUI:Destroy();
            u7.LiberationGUI = nil;
        end;

        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u3:StopAll();
        u1.Ability:Fire("LiberationDribble", {
            State = "Cutscene",
            TimeSent = workspace:GetServerTimeNow()
        });
        task.delay(2.65, function() -- Line: 74
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);

        return;
    end;

    u2.States.Ability = true;
    u5.CamShake:Shake(CameraShaker.Presets.Explosion);
    u3:StopAll();
    u3:PlayChar("Rubberman", `LiberationDribble{u7.LiberationDribble}`, Enum.AnimationPriority.Action4);
    u3:PlayBall("Rubberman", `LiberationDribble{u7.LiberationDribble}Ball`, Enum.AnimationPriority.Action4);
    u1.Ability:Fire("LiberationDribble", {
        State = "Dribble",
        TimeSent = workspace:GetServerTimeNow()
    });
    SfxManager:playSound({
        Sound = "BBZ Rubber BrazilKick",
        RandomPitch = true,
        Parent = workspace
    });

    if not u7.LiberationGUI then
        Effects:Popup("Press ability again when green!");
        u7.LiberationGUI = script.ScreenGui:Clone();
        u7.LiberationGUI.Parent = LocalPlayer.PlayerGui;
        local u8 = nil;
        u8 = RunService.PreRender:Connect(function() -- Line: 98
            -- upvalues: u7 (copy), u8 (ref), u5 (ref)
            if u7.LiberationGUI == nil or u7.LiberationGUI.Parent == nil then
                u8:Disconnect();

                return;
            end;

            if u5.ShakeCF then
                local v9, _, _ = u5.ShakeCF:ToOrientation();
                u7.LiberationGUI.Container.Position = UDim2.new(0.5, u5.ShakeCF.X * 100, 0.3, u5.ShakeCF.Y * 100);
                u7.LiberationGUI.Container.Rotation = v9 * 100;
            end;
        end);
    end;

    u7.LiberationGUI.Container.Fill.BackgroundColor3 = Color3.fromRGB(222, 42, 42);
    u7.LiberationGUI.Container.Fill.Size = UDim2.new(0, 0, 0, 0);
    u7.LiberationGUI.Container.AgainText.Visible = false;
    TweenService:Create(u7.LiberationGUI.Container.Fill, TweenInfo.new(0.7, Enum.EasingStyle.Linear), {
        Size = UDim2.new(1, 0, 1, 0)
    }):Play();
    task.delay(0.5, function() -- Line: 118
        -- upvalues: u7 (copy), u2 (ref)
        u7.CanPressLiberation = false;
        u7:ResetCD(4);
        u2.States.Ability = false;
    end);
    task.wait(0.7);

    if u7.LiberationDribble == nil then
        return;
    end;

    u7.LiberationGUI.Container.Fill.BackgroundColor3 = Color3.fromRGB(42, 222, 42);
    u7.LiberationGUI.Container.AgainText.Visible = true;
    u7.CanPressLiberation = true;
    u7.DelayTask = task.delay(0.35, function() -- Line: 133
        -- upvalues: u7 (copy), Effects (ref), Cooldowns (ref)
        u7.CanPressLiberation = false;
        Effects:Popup("Too late!", 1);

        if u7.LiberationGUI then
            u7.LiberationGUI:Destroy();
            u7.LiberationGUI = nil;
        end;

        u7.LiberationDribble = nil;
        u7.CDS[4] = tick() + Cooldowns.Abilities.Rubberman[4];
        u7.DelayTask = nil;
    end);
end;