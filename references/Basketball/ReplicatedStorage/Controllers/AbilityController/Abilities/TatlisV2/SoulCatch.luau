 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Parent = require(script.Parent.Parent);
local script_SetPowerChargeState = require(script.SetPowerChargeState);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u7 = { "W", "A", "S", "D" };
local u8 = { "R1", "R2", "L1", "L2" };
local u9 = 0;
local u10 = nil;
LocalPlayer.CharacterAdded:Connect(function() -- Line: 43
    -- upvalues: u9 (ref), u10 (ref), Parent (copy)
    u9 = 0;

    if u10 then
        u10:Destroy();
        u10 = nil;
    end;

    Parent.TatlisV2[2].Name = "Soul Catch";
    Parent.TatlisV2[2].BallName = "Soul Walk";
end);

return function(u11) -- Line: 55
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u9 (ref), Parent (copy), Effects (copy), CameraShaker (copy), TweenService (copy), workspace_CurrentCamera (copy), Trove (copy), SfxManager (copy), ReplicatedStorage (copy), u8 (copy), UserInputService (copy), u7 (copy), RunService (copy), Essentials (copy), u10 (ref), script_SetPowerChargeState (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u11.AbilityService;
    u2 = u11.MovementController;
    u3 = u11.BallController;
    u4 = u11.CameraController;
    u5 = u11.Animations;
    u6 = u11.Network;

    if u9 >= 3 then
        u9 = 0;
        Parent.TatlisV2[2].Name = "Soul Catch";
        Parent.TatlisV2[2].BallName = "Soul Walk";

        if u6.CharValues.HasBall then
            if math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) > 145 then
                u11.CDS[2] = tick() + 0.5;
                Effects:Popup("Only shootable from your half of the court!");
                u9 = 3;
                Parent.TatlisV2[2].Name = "Stare Down";
                Parent.TatlisV2[2].BallName = nil;

                return;
            end;

            u5:StopAll();
            local u12 = u5:PlayChar("TatlisV2", "StareDownB", Enum.AnimationPriority.Action3, true);
            local u13 = u5:PlayBall("TatlisV2", "StareDownBBall", Enum.AnimationPriority.Action3, true);
            u2.States.Ability = true;
            u2.States.NoWalk = true;
            u11.AC:Add(function() -- Line: 89
                -- upvalues: u2 (ref), u12 (copy), u13 (copy)
                u2.States.Ability = false;
                u2.States.NoWalk = false;
                u12:Stop();
                u13:Stop();
            end);
            u11.AC:Add(task.delay(2.6333333333333333, function() -- Line: 97
                -- upvalues: u11 (copy)
                u11.AC:Clean();
            end));
            u11.AC:Connect(u1.Ability, function() -- Line: 101
                -- upvalues: u11 (copy), u4 (ref), CameraShaker (ref), u3 (ref)
                u11.AC:Clean();
                u4.CamShake:Shake(CameraShaker.Presets.IgnitePass);
                u3:Dunk("TwohandHanging", "TwohandHanging", true);
            end);
        else
            local PlayerPossessingBall = u3:GetPlayerPossessingBall();

            if not PlayerPossessingBall or PlayerPossessingBall.Team == LocalPlayer.Team then
                u11.CDS[2] = tick() + 0.5;
                Effects:Popup("Enemy player must have the ball!");
                u9 = 3;
                Parent.TatlisV2[2].Name = "Stare Down";
                Parent.TatlisV2[2].BallName = nil;

                return;
            end;

            if not u3:LocalPlayerIsWithinDistanceOfBall(75) then
                u11.CDS[2] = tick() + 0.5;
                Effects:Popup("Must be close to the ball!");
                u9 = 3;
                Parent.TatlisV2[2].Name = "Stare Down";
                Parent.TatlisV2[2].BallName = nil;

                return;
            end;

            u2.States.Ability = true;
            u11.AC:Add(function() -- Line: 128
                -- upvalues: u2 (ref)
                task.delay(0.25, function() -- Line: 129
                    -- upvalues: u2 (ref)
                    u2.States.Ability = false;
                end);
                u2.States.NoWalk = false;
            end);
            u11.AC:Add(task.delay(3.6, function() -- Line: 135
                -- upvalues: u11 (copy)
                u11.AC:Clean();
            end));
            u11.AC:Connect(u1.Ability, function(p14) -- Line: 139
                -- upvalues: u11 (copy), Effects (ref), u9 (ref), Parent (ref), u2 (ref), u4 (ref), CameraShaker (ref), TweenService (ref), workspace_CurrentCamera (ref), u5 (ref), HumanoidRootPart (copy)
                if p14 then
                    if not p14.Fail then
                        u2.States.NoWalk = true;

                        return;
                    end;

                    u11.AC:Clean();
                    u11.CDS[2] = tick() + 0.5;
                    Effects:Popup("Unable to stare enemy down!");
                    u9 = 3;
                    Parent.TatlisV2[2].Name = "Stare Down";
                    Parent.TatlisV2[2].BallName = nil;

                    return;
                end;

                u11.AC:Clean();
                u4.CamShake:Shake(CameraShaker.Presets.IgnitePass);
                TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    FieldOfView = 90
                }):Play();
                u5:StopAll();
                u5:PlayChar("TatlisV2", "StareDownBDash", Enum.AnimationPriority.Action3);
                u5:PlayBall("TatlisV2", "StareDownBDashBall", Enum.AnimationPriority.Action3);
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
                LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
                LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
                LinearVelocity.Parent = HumanoidRootPart;
                LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 120;
                TweenService:Create(LinearVelocity, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    VectorVelocity = HumanoidRootPart.CFrame.LookVector * 60
                }):Play();
                task.delay(0.3333333333333333, function() -- Line: 173
                    -- upvalues: LinearVelocity (copy)
                    LinearVelocity:Destroy();
                end);
            end);
        end;

        local u15 = nil;
        local u16 = Trove.new();
        u11.AC:Add(task.delay(math.random() + 1, function() -- Line: 182
            -- upvalues: SfxManager (ref), u15 (ref), LocalPlayer (ref), TweenService (ref), u16 (copy), u1 (ref), ReplicatedStorage (ref), u8 (ref), UserInputService (ref), u7 (ref)
            SfxManager:playSound({
                Sound = "BBZ King Of NYC Clash Appear",
                Parent = workspace
            });
            u15 = script.Circle:Clone();
            u15.Frame.Position = UDim2.new(math.random(15, 85) / 100, 0, math.random(30, 70) / 100, 0);
            u15.Frame.Holder.GroupTransparency = 1;
            u15.Frame.Holder.UIScale.Scale = 0.6;
            u15.Frame.Radius.UIScale.Scale = 1.5;
            u15.Parent = LocalPlayer.PlayerGui;
            TweenService:Create(u15.Frame.Holder, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                GroupTransparency = 0
            }):Play();
            TweenService:Create(u15.Frame.Holder.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
            local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
            task.spawn(function() -- Line: 197
                -- upvalues: u15 (ref), Color3_fromRGB_ret (ref), TweenService (ref)
                while u15 and u15.Parent do
                    local v17 = script.InnerTemplate:Clone();
                    v17.Parent = u15.Frame.Holder.InnerContainer;
                    v17.BackgroundTransparency = 1;
                    local UIStroke = v17.UIStroke;
                    local UIScale = v17.UIScale;
                    UIStroke.Color = Color3_fromRGB_ret;
                    TweenService:Create(UIStroke, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                    TweenService:Create(UIScale, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Scale = 0.7
                    }):Play();
                    task.wait(1);
                    v17:Destroy();
                end;
            end);

            local function OutcomeText(p18) -- Line: 217
                -- upvalues: u15 (ref), Color3_fromRGB_ret (ref), TweenService (ref)
                local v19 = script.OutcomeTemplate:Clone();
                v19.Parent = u15.Frame;
                v19.TextColor3 = Color3_fromRGB_ret;
                v19.Text = p18;
                local UIStroke = v19.UIStroke;
                local UIScale = v19.UIScale;
                UIScale.Scale = 0.6;
                TweenService:Create(UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 1.2
                }):Play();
                TweenService:Create(v19, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = v19.Position - UDim2.new(0, 0, 0.75, 0)
                }):Play();
                task.wait(0.25);
                TweenService:Create(v19, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                task.wait(0.75);
                v19:Destroy();
            end;

            local function HitFx() -- Line: 240
                -- upvalues: u15 (ref), TweenService (ref)
                local v20 = script.HitFxTemplate:Clone();
                v20.Parent = u15.Frame;
                local UIScale = v20.UIScale;
                TweenService:Create(v20.UIStroke, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                TweenService:Create(UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = 2
                }):Play();
                task.wait(0.35);
                v20:Destroy();
            end;

            local function Click(p21) -- Line: 255
                -- upvalues: u16 (ref), u15 (ref), u1 (ref), SfxManager (ref), Color3_fromRGB_ret (ref), OutcomeText (copy), TweenService (ref), HitFx (copy)
                u16:Clean();

                if p21 then
                    u15.Frame.Radius.UIScale.Scale = 0.75;
                end;

                local math_abs_ret = math.abs(u15.Frame.Radius.UIScale.Scale - 1);

                if math_abs_ret <= 0.15 then
                    u1.Ability:Fire("Soul Catch", {
                        Result = "Success",
                        State = "Skill Check",
                        TimeSent = workspace:GetServerTimeNow()
                    });
                    SfxManager:playSound({
                        Sound = "BBZ King Of NYC Clash Success",
                        Parent = workspace
                    });
                    Color3_fromRGB_ret = Color3.fromRGB(55, 255, 55);
                    u15.Frame.Holder.KeybindText.TextColor3 = Color3_fromRGB_ret;
                    u15.Frame.Radius.GroupTransparency = 1;
                    task.spawn(OutcomeText, math_abs_ret <= 0.05 and "PERFECT!" or (math_abs_ret <= 1 and "GREAT!" or "NICE!"));
                    TweenService:Create(u15.Frame.Holder.UIScale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Scale = 0.875
                    }):Play();
                    task.wait(0.1);
                    HitFx();
                    TweenService:Create(u15.Frame.Holder.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play();
                    task.wait(0.5);
                    TweenService:Create(u15.Frame.Holder, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        GroupTransparency = 1
                    }):Play();
                    task.wait(0.25);
                    u15:Destroy();

                    return;
                end;

                u1.Ability:Fire("Soul Catch", {
                    Result = "Fail",
                    State = "Skill Check",
                    TimeSent = workspace:GetServerTimeNow()
                });
                SfxManager:playSound({
                    Sound = "BBZ King Of NYC Clash Fail",
                    Parent = workspace
                });
                Color3_fromRGB_ret = Color3.fromRGB(255, 55, 55);
                u15.Frame.Holder.KeybindText.TextColor3 = Color3_fromRGB_ret;
                TweenService:Create(u15.Frame.Radius, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    GroupTransparency = u15.Frame.Radius.UIScale.Scale > 1 and 0.5 or 0.75
                }):Play();
                task.spawn(OutcomeText, u15.Frame.Radius.UIScale.Scale > 1 and "TOO EARLY!" or "MISS!");
                TweenService:Create(u15.Frame.Holder.UIScale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = 0.92
                }):Play();
                task.wait(0.1);
                TweenService:Create(u15.Frame.Holder.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 1
                }):Play();
                task.wait(0.5);
                TweenService:Create(u15.Frame.Holder, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    GroupTransparency = 1
                }):Play();
                TweenService:Create(u15.Frame.Radius, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    GroupTransparency = 1
                }):Play();
                task.wait(0.25);
                u15:Destroy();
            end;

            local u22 = u16:Add(Instance.new("NumberValue"));
            u22.Value = u15.Frame.Radius.UIScale.Scale;
            u16:Connect(u22.Changed, function() -- Line: 320
                -- upvalues: u15 (ref), u22 (copy)
                u15.Frame.Radius.UIScale.Scale = u22.Value;
            end);
            TweenService:Create(u22, TweenInfo.new(1), {
                Value = 0.75
            }):Play();
            u16:Add(task.delay(1, function() -- Line: 325
                -- upvalues: u16 (ref), Click (copy)
                u16:Clean();
                Click();
            end));

            if ReplicatedStorage.Controllers.Device.Value == "Console" then
                local u23 = u8[math.random(1, #u8)];
                u15.Frame.Holder.KeybindText.Text = u23;
                u16:Connect(UserInputService.InputBegan, function(p24, p25) -- Line: 335
                    -- upvalues: u23 (copy), Click (copy)
                    if p25 then
                        return;
                    end;

                    if p24.KeyCode == Enum.KeyCode[`Button{u23}`] then
                        Click();

                        return;
                    end;

                    if p24.KeyCode == Enum.KeyCode.Unknown then
                        Click(true);
                    end;
                end);
            elseif ReplicatedStorage.Controllers.Device.Value == "PC" then
                local u26 = u7[math.random(1, #u7)];
                u15.Frame.Holder.KeybindText.Text = u26;
                u16:Connect(UserInputService.InputBegan, function(p27, p28) -- Line: 349
                    -- upvalues: u26 (copy), Click (copy)
                    if p28 then
                        return;
                    end;

                    if p27.KeyCode == Enum.KeyCode[u26] then
                        Click();

                        return;
                    end;

                    if p27.KeyCode == Enum.KeyCode.Unknown then
                        Click(true);
                    end;
                end);
            else
                u15.Frame.Holder.KeybindText.Visible = false;
                u15.Frame.Holder.TapIcon.Visible = true;
                u16:Connect(u15.Frame.Button.Activated, function() -- Line: 362
                    -- upvalues: Click (copy)
                    Click();
                end);
            end;
        end));
        u1.Ability:Fire("Soul Catch", {
            State = "Stare Down",
            TimeSent = workspace:GetServerTimeNow(),
            HasBall = u6.CharValues.HasBall
        });

        return;
    end;

    if u6.CharValues.HasBall then
        local v29 = u11:CheckInfront(25);

        if not v29 then
            u11:ResetCD(2);
            Effects:Popup("Someone must be infront of you!");

            return;
        end;

        local u30 = true;
        local CFrame = HumanoidRootPart.CFrame;
        u1.Ability:Fire("Soul Catch", {
            State = "Start",
            TimeSent = workspace:GetServerTimeNow(),
            Other = v29
        });
        local v31 = u2;
        v31.Boost = v31.Boost + 10;
        u11.AC:Add(function() -- Line: 387
            -- upvalues: u2 (ref)
            local v32 = u2;
            v32.Boost = v32.Boost - 10;

            if u2.Boost < 0 then
                u2.Boost = 0;
            end;
        end);
        u11.AC:Add(task.delay(5, function() -- Line: 394
            -- upvalues: u11 (copy), u1 (ref), u30 (ref), HumanoidRootPart (copy), CFrame (copy)
            u11.AC:Clean();
            u1.Ability:Fire("Soul Catch", {
                State = "End",
                TimeSent = workspace:GetServerTimeNow()
            });

            if u30 then
                HumanoidRootPart.CFrame = CFrame;
            end;
        end));
        u11.AC:Connect(RunService.Heartbeat, function() -- Line: 404
            -- upvalues: u30 (ref), u2 (ref), u3 (ref), LocalPlayer (ref), u11 (copy)
            u30 = not u2.States.AimAssist;

            if u3:GetPlayerPossessingBall() ~= LocalPlayer then
                u30 = false;
                u11.AC:Clean();
            end;
        end);

        return;
    end;

    if ReplicatedStorage.Cooldowns.SoulCatchCD.Value > workspace:GetServerTimeNow() then
        u11.CDS[2] = tick() + 0.5;
        local v33 = ReplicatedStorage.Cooldowns.SoulCatchCD.Value - workspace:GetServerTimeNow();
        local math_abs_ret = math.abs(v33);
        Effects:Popup(`Ability on global cooldown! Ready in {math.ceil(math_abs_ret)} seconds`, 2);

        return;
    end;

    local PlayerPossessingBall = u3:GetPlayerPossessingBall();

    if not PlayerPossessingBall or PlayerPossessingBall.Team == LocalPlayer.Team then
        u11.CDS[2] = tick() + 0.5;
        Effects:Popup("Enemy player must have the ball!");

        return;
    end;

    if not u3:LocalPlayerIsWithinDistanceOfBall(17.5) then
        u11.CDS[2] = tick() + 0.5;
        Effects:Popup("Must be close to the ball!");

        return;
    end;

    u1.Ability:Fire("Soul Catch", {
        State = "Snatch",
        TimeSent = workspace:GetServerTimeNow()
    });
    u2.States.Ability = true;
    u11.AC:Add(function() -- Line: 435
        -- upvalues: u2 (ref)
        task.delay(0.25, function() -- Line: 436
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u2.States.NoWalk = false;
    end);
    u11.AC:Add(task.delay(1.9166666666666667, function() -- Line: 442
        -- upvalues: u2 (ref)
        task.delay(0.25, function() -- Line: 443
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u2.States.NoWalk = false;
    end));
    u11.AC:Add(task.delay(2.1666666666666665, function() -- Line: 449
        -- upvalues: u11 (copy)
        u11.AC:Clean();
    end));
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u11.AC:Connect(RunService.Heartbeat, function(p34) -- Line: 454
        -- upvalues: FieldOfView (ref), Essentials (ref), workspace_CurrentCamera (ref)
        FieldOfView = Essentials:Lerp(FieldOfView, 30, p34);
        workspace_CurrentCamera.FieldOfView = FieldOfView;
    end);
    u11.AC:Connect(u1.Ability, function(p35) -- Line: 460
        -- upvalues: u11 (copy), Effects (ref), u2 (ref), u4 (ref), CameraShaker (ref), TweenService (ref), workspace_CurrentCamera (ref), u9 (ref), Parent (ref), u10 (ref), HumanoidRootPart (copy), script_SetPowerChargeState (ref)
        if p35 then
            if not p35.Fail then
                u2.States.NoWalk = true;

                return;
            end;

            u11.AC:Clean();
            u11.CDS[2] = tick() + 0.5;
            Effects:Popup("Unable to snatch enemy soul!");

            return;
        end;

        u11.AC:Clean();
        u4.CamShake:Shake(CameraShaker.Presets.IgnitePass);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = 90
        }):Play();
        u9 = u9 + 1;

        if u9 >= 3 then
            Parent.TatlisV2[2].Name = "Stare Down";
            Parent.TatlisV2[2].BallName = nil;
        end;

        local u36 = u10 or script.BillboardGui:Clone();
        u36.Parent = HumanoidRootPart;
        TweenService:Create(u36.Container, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            GroupTransparency = 0
        }):Play();
        u10 = u36;
        script_SetPowerChargeState(u36, u9);
        task.delay(4.75, function() -- Line: 495
            -- upvalues: u36 (copy), u10 (ref), TweenService (ref)
            if u36 ~= u10 then
                return;
            end;

            TweenService:Create(u36.Container, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                GroupTransparency = 1
            }):Play();
            task.delay(0.25, function() -- Line: 500
                -- upvalues: u36 (ref), u10 (ref)
                if u36 ~= u10 then
                    return;
                end;

                u36:Destroy();
                u10 = nil;
            end);
        end);
    end);
end;