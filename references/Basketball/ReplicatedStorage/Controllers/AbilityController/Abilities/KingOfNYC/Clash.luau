 
 

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
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
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

return function(u9) -- Line: 40
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), Essentials (copy), workspace_CurrentCamera (copy), RunService (copy), TweenService (copy), CameraShaker (copy), ReplicatedStorage (copy), Trove (copy), SfxManager (copy), u8 (copy), UserInputService (copy), u7 (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u9.AbilityService;
    u2 = u9.MovementController;
    u3 = u9.BallController;
    u4 = u9.CameraController;
    u5 = u9.Animations;
    u6 = u9.Network;

    if not u6.CharValues.HasBall then
        if ReplicatedStorage.Cooldowns.ClashCD.Value > workspace:GetServerTimeNow() then
            u9.CDS[2] = tick() + 0.5;
            local v10 = ReplicatedStorage.Cooldowns.ClashCD.Value - workspace:GetServerTimeNow();
            local math_abs_ret = math.abs(v10);
            Effects:Popup(`Ability on global cooldown! Ready in {math.ceil(math_abs_ret)} seconds`, 2);

            return;
        end;

        local PlayerPossessingBall = u3:GetPlayerPossessingBall();

        if not PlayerPossessingBall or PlayerPossessingBall.Team == LocalPlayer.Team then
            u9.CDS[2] = tick() + 0.5;
            Effects:Popup("Enemy player must have the ball!");

            return;
        end;

        if not u3:LocalPlayerIsWithinDistanceOfBall(25) then
            u9.CDS[2] = tick() + 0.5;
            Effects:Popup("Must be close to the ball!");

            return;
        end;

        u1.Ability:Fire("Clash", {
            State = "Clash",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2.States.Ability = true;
        u9.AC:Add(function() -- Line: 146
            -- upvalues: u2 (ref)
            task.delay(0.25, function() -- Line: 147
                -- upvalues: u2 (ref)
                u2.States.Ability = false;
            end);
        end);
        u9.AC:Add(task.delay(2.183333333333333, function() -- Line: 152
            -- upvalues: u9 (copy)
            u9.AC:Clean();
        end));
        local u11 = nil;
        local u12 = Trove.new();
        u9.AC:Add(task.delay(math.random(), function() -- Line: 159
            -- upvalues: SfxManager (ref), u11 (ref), LocalPlayer (ref), TweenService (ref), u12 (copy), u1 (ref), ReplicatedStorage (ref), u8 (ref), UserInputService (ref), u7 (ref)
            SfxManager:playSound({
                Sound = "BBZ King Of NYC Clash Appear",
                Parent = workspace
            });
            u11 = script.Circle:Clone();
            u11.Frame.Position = UDim2.new(math.random(15, 85) / 100, 0, math.random(30, 70) / 100, 0);
            u11.Frame.Holder.GroupTransparency = 1;
            u11.Frame.Holder.UIScale.Scale = 0.6;
            u11.Frame.Radius.UIScale.Scale = 1.5;
            u11.Parent = LocalPlayer.PlayerGui;
            TweenService:Create(u11.Frame.Holder, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                GroupTransparency = 0
            }):Play();
            TweenService:Create(u11.Frame.Holder.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
            local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
            task.spawn(function() -- Line: 174
                -- upvalues: u11 (ref), Color3_fromRGB_ret (ref), TweenService (ref)
                while u11 and u11.Parent do
                    local v13 = script.InnerTemplate:Clone();
                    v13.Parent = u11.Frame.Holder.InnerContainer;
                    v13.BackgroundTransparency = 1;
                    local UIStroke = v13.UIStroke;
                    local UIScale = v13.UIScale;
                    UIStroke.Color = Color3_fromRGB_ret;
                    TweenService:Create(UIStroke, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                    TweenService:Create(UIScale, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Scale = 0.7
                    }):Play();
                    task.wait(1);
                    v13:Destroy();
                end;
            end);

            local function OutcomeText(p14) -- Line: 194
                -- upvalues: u11 (ref), Color3_fromRGB_ret (ref), TweenService (ref)
                local v15 = script.OutcomeTemplate:Clone();
                v15.Parent = u11.Frame;
                v15.TextColor3 = Color3_fromRGB_ret;
                v15.Text = p14;
                local UIStroke = v15.UIStroke;
                local UIScale = v15.UIScale;
                UIScale.Scale = 0.6;
                TweenService:Create(UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 1.2
                }):Play();
                TweenService:Create(v15, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = v15.Position - UDim2.new(0, 0, 0.75, 0)
                }):Play();
                task.wait(0.25);
                TweenService:Create(v15, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                task.wait(0.75);
                v15:Destroy();
            end;

            local function HitFx() -- Line: 217
                -- upvalues: u11 (ref), TweenService (ref)
                local v16 = script.HitFxTemplate:Clone();
                v16.Parent = u11.Frame;
                local UIScale = v16.UIScale;
                TweenService:Create(v16.UIStroke, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                TweenService:Create(UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = 2
                }):Play();
                task.wait(0.35);
                v16:Destroy();
            end;

            local function Click(p17) -- Line: 232
                -- upvalues: u12 (ref), u11 (ref), u1 (ref), SfxManager (ref), Color3_fromRGB_ret (ref), OutcomeText (copy), TweenService (ref), HitFx (copy)
                u12:Clean();

                if p17 then
                    u11.Frame.Radius.UIScale.Scale = 0.75;
                end;

                local math_abs_ret = math.abs(u11.Frame.Radius.UIScale.Scale - 1);

                if math_abs_ret <= 0.15 then
                    u1.Ability:Fire("Clash", {
                        Result = "Success",
                        State = "Skill Check",
                        TimeSent = workspace:GetServerTimeNow()
                    });
                    SfxManager:playSound({
                        Sound = "BBZ King Of NYC Clash Success",
                        Parent = workspace
                    });
                    Color3_fromRGB_ret = Color3.fromRGB(55, 255, 55);
                    u11.Frame.Holder.KeybindText.TextColor3 = Color3_fromRGB_ret;
                    u11.Frame.Radius.GroupTransparency = 1;
                    task.spawn(OutcomeText, math_abs_ret <= 0.05 and "PERFECT!" or (math_abs_ret <= 1 and "GREAT!" or "NICE!"));
                    TweenService:Create(u11.Frame.Holder.UIScale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Scale = 0.875
                    }):Play();
                    task.wait(0.1);
                    HitFx();
                    TweenService:Create(u11.Frame.Holder.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play();
                    task.wait(0.5);
                    TweenService:Create(u11.Frame.Holder, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        GroupTransparency = 1
                    }):Play();
                    task.wait(0.25);
                    u11:Destroy();

                    return;
                end;

                u1.Ability:Fire("Clash", {
                    Result = "Fail",
                    State = "Skill Check",
                    TimeSent = workspace:GetServerTimeNow()
                });
                SfxManager:playSound({
                    Sound = "BBZ King Of NYC Clash Fail",
                    Parent = workspace
                });
                Color3_fromRGB_ret = Color3.fromRGB(255, 55, 55);
                u11.Frame.Holder.KeybindText.TextColor3 = Color3_fromRGB_ret;
                TweenService:Create(u11.Frame.Radius, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    GroupTransparency = u11.Frame.Radius.UIScale.Scale > 1 and 0.5 or 0.75
                }):Play();
                task.spawn(OutcomeText, u11.Frame.Radius.UIScale.Scale > 1 and "TOO EARLY!" or "MISS!");
                TweenService:Create(u11.Frame.Holder.UIScale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = 0.92
                }):Play();
                task.wait(0.1);
                TweenService:Create(u11.Frame.Holder.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 1
                }):Play();
                task.wait(0.5);
                TweenService:Create(u11.Frame.Holder, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    GroupTransparency = 1
                }):Play();
                TweenService:Create(u11.Frame.Radius, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    GroupTransparency = 1
                }):Play();
                task.wait(0.25);
                u11:Destroy();
            end;

            local u18 = u12:Add(Instance.new("NumberValue"));
            u18.Value = u11.Frame.Radius.UIScale.Scale;
            u12:Connect(u18.Changed, function() -- Line: 297
                -- upvalues: u11 (ref), u18 (copy)
                u11.Frame.Radius.UIScale.Scale = u18.Value;
            end);
            TweenService:Create(u18, TweenInfo.new(1), {
                Value = 0.75
            }):Play();
            u12:Add(task.delay(1, function() -- Line: 302
                -- upvalues: u12 (ref), Click (copy)
                u12:Clean();
                Click();
            end));

            if ReplicatedStorage.Controllers.Device.Value == "Console" then
                local u19 = u8[math.random(1, #u8)];
                u11.Frame.Holder.KeybindText.Text = u19;
                u12:Connect(UserInputService.InputBegan, function(p20, p21) -- Line: 312
                    -- upvalues: u19 (copy), Click (copy)
                    if p21 then
                        return;
                    end;

                    if p20.KeyCode == Enum.KeyCode[`Button{u19}`] then
                        Click();

                        return;
                    end;

                    if p20.KeyCode == Enum.KeyCode.Unknown then
                        Click(true);
                    end;
                end);
            elseif ReplicatedStorage.Controllers.Device.Value == "PC" then
                local u22 = u7[math.random(1, #u7)];
                u11.Frame.Holder.KeybindText.Text = u22;
                u12:Connect(UserInputService.InputBegan, function(p23, p24) -- Line: 326
                    -- upvalues: u22 (copy), Click (copy)
                    if p24 then
                        return;
                    end;

                    if p23.KeyCode == Enum.KeyCode[u22] then
                        Click();

                        return;
                    end;

                    if p23.KeyCode == Enum.KeyCode.Unknown then
                        Click(true);
                    end;
                end);
            else
                u11.Frame.Holder.KeybindText.Visible = false;
                u11.Frame.Holder.TapIcon.Visible = true;
                u12:Connect(u11.Frame.Button.Activated, function() -- Line: 339
                    -- upvalues: Click (copy)
                    Click();
                end);
            end;
        end));
        u4.CamShake:Shake(CameraShaker.Presets.IgnitePass);
        local FieldOfView = workspace_CurrentCamera.FieldOfView;
        u9.AC:Connect(RunService.Heartbeat, function(p25) -- Line: 348
            -- upvalues: FieldOfView (ref), Essentials (ref), workspace_CurrentCamera (ref)
            FieldOfView = Essentials:Lerp(FieldOfView, 40, p25 * 5);
            workspace_CurrentCamera.FieldOfView = FieldOfView;
        end);
        u9.AC:Connect(u1.Ability, function(p26) -- Line: 354
            -- upvalues: u9 (copy), Effects (ref), u11 (ref), u12 (copy), u4 (ref), CameraShaker (ref), TweenService (ref), workspace_CurrentCamera (ref), u5 (ref), HumanoidRootPart (copy)
            u9.AC:Clean();

            if p26 and p26.Fail then
                u9.CDS[2] = tick() + 0.5;
                Effects:Popup("Unable to clash!");

                if u11 then
                    u11:Destroy();
                end;

                u12:Clean();

                return;
            end;

            u4.CamShake:Shake(CameraShaker.Presets.Dunk);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                FieldOfView = 120
            }):Play();
            u5:StopAll();
            u5:PlayChar("Flash", "DashFB", Enum.AnimationPriority.Action3);
            u5:PlayBall("Flash", "DashFBall", Enum.AnimationPriority.Action3);
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.Parent = HumanoidRootPart;
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 120;
            TweenService:Create(LinearVelocity, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = HumanoidRootPart.CFrame.LookVector * 60
            }):Play();
            task.delay(0.3333333333333333, function() -- Line: 384
                -- upvalues: LinearVelocity (copy)
                LinearVelocity:Destroy();
            end);
        end);

        return;
    end;

    local v27 = u9:CheckInfront(25);

    if not v27 then
        u9:ResetCD(2);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    if u9.MovementController.States.PumpFake then
        u9:ResetCD(2);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    local v28 = Essentials:ReturnRorL(u6.CharValues);
    u1.Ability:Fire("Clash", {
        State = "Counter Step",
        TimeSent = workspace:GetServerTimeNow(),
        Other = v27,
        Side = v28
    });
    u5:StopAll();
    u5:PlayChar("KingOfNYC", `CounterStep{v28}`, Enum.AnimationPriority.Action3);
    u5:PlayBall("KingOfNYC", `CounterStep{v28}Ball`, Enum.AnimationPriority.Action3);
    u2.States.Ability = true;
    u9.AC:Add(function() -- Line: 75
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u9.AC:Add(task.delay(1, function() -- Line: 79
        -- upvalues: u9 (copy)
        u9.AC:Clean();
    end));
    u2.Boost = 15;
    task.delay(2, function() -- Line: 84
        -- upvalues: u2 (ref)
        u2.Boost = 0;
    end);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    task.delay(1.1666666666666667, function() -- Line: 94
        -- upvalues: LinearVelocity (copy)
        LinearVelocity:Destroy();
    end);
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local v30 = RunService.Heartbeat:Connect(function(p29) -- Line: 99
        -- upvalues: FieldOfView (ref), Essentials (ref), workspace_CurrentCamera (ref)
        FieldOfView = Essentials:Lerp(FieldOfView, 40, p29 * 5);
        workspace_CurrentCamera.FieldOfView = FieldOfView;
    end);
    LinearVelocity.VectorVelocity = -((v27.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit:Cross(Vector3.new(0, 1, 0)) * (v28 == "R" and 1 or -1)) * 120;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = Vector3.new(0, 0, 0)
    }):Play();
    task.wait(0.6666666666666666);
    v30:Disconnect();
    u4.CamShake:Shake(CameraShaker.Presets.Dunk);
    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FieldOfView = 120
    }):Play();
    TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = (HumanoidRootPart.CFrame.LookVector / 2 + HumanoidRootPart.CFrame.RightVector * (v28 == "R" and 1 or -1)) * 90
    }):Play();
    task.wait(0.2);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = HumanoidRootPart.CFrame.LookVector * 90
    }):Play();
end;