  

local UserInputService = game:GetService("UserInputService");
game:GetService("PathfindingService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observers = require(ReplicatedStorage.Packages.Observers);
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local environment = require(ReplicatedStorage.Shared.environment);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.Popup);
local FindCurveDirection = require(ReplicatedStorage.Shared.utils.FindCurveDirection);
local getActiveFlowStats = require(ReplicatedStorage.Shared.utils.getActiveFlowStats);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local Raycast = require(ReplicatedStorage.Shared.Raycast);
local LocalPlayer = game.Players.LocalPlayer;
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local canRequestCR = require(ReplicatedStorage.Shared.utils.canRequestCR);
local PlrStyles = require(ReplicatedStorage.Shared.PlrStyles);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local script_BalancingVisualiser = require(script.BalancingVisualiser);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local getCurrentStyle = require(ReplicatedStorage.ClientModules.getCurrentStyle);
local u1 = nil;
local PlayerData = ClientGlobals.PlayerData;
local u2 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u2:WaitForChild("Humanoid");
local HumanoidRootPart = u2:WaitForChild("HumanoidRootPart");
local workspace_CurrentCamera = workspace.CurrentCamera;
local u3 = 50;
local u4 = 1;
local u5 = 1;
local u6 = 0;
local u7 = false;
local u8 = false;
local u9 = tick();
local u10 = tick();
local u11 = tick();
tick();
local u12 = {
    Name = "BallController"
};

local function ProjectVector(p13) -- Line: 61
    return (p13 * Vector3.new(1, 0, 1)).Unit;
end;

local function ClampDirection(p14, p15, p16) -- Line: 65
    local math_rad_ret = math.rad(p16);
    local Unit = p14.Unit;
    local Unit2 = p15.Unit;
    local v17 = Unit:Dot(Unit2);
    local math_clamp_ret = math.clamp(v17, -1, 1);
    local math_acos_ret = math.acos(math_clamp_ret);

    if math_acos_ret <= math_rad_ret then
        return Unit2;
    end;

    local _ = math_rad_ret / math_acos_ret;
    local v18 = Unit:Cross(Unit2);

    if v18.Magnitude == 0 then
        v18 = Unit:Cross(Vector3.new(1, 0, 0));

        if v18.Magnitude == 0 then
            v18 = Unit:Cross(Vector3.new(0, 1, 0));
        end;
    end;

    return (CFrame.fromAxisAngle(v18.Unit, math_rad_ret) * Unit).Unit;
end;

local function quadraticSolver(p19, p20, p21) -- Line: 93
    local v22 = (-p20 + math.sqrt(p20 * p20 - 4 * p19 * p21)) / (2 * p19);
    local v23 = (-p20 - math.sqrt(p20 * p20 - 4 * p19 * p21)) / (2 * p19);

    if v22 < v23 then
        return v23;
    end;

    return v22;
end;

local function findLandingPosition(p24: vector, p25: vector) -- Line: 100
    local Football = workspace:FindFirstChild("Football");
    local v26;

    if Football then
        v26 = -(workspace.Gravity - 60 - Football.Mass / 20);
    else
        v26 = -(workspace.Gravity - 75);
    end;

    local v27 = v26 * 0.5;
    local Y = p24.Y;
    local Y2 = p25.Y;
    local v28 = (-Y + math.sqrt(Y * Y - 4 * v27 * Y2)) / (2 * v27);
    local v29 = (-Y - math.sqrt(Y * Y - 4 * v27 * Y2)) / (2 * v27);

    if v28 < v29 then
        v28 = v29;
    end;

    return p25 + Vector3.new(p24.x, 0, p24.Z) * v28 + Vector3.new(0, -p25.Y, 0);
end;

function u12.BallFollowPlayer(u30: table, u31: any, p32: any, u33: number) -- Line: 115
    -- upvalues: LocalPlayer (copy), u12 (copy), RunService (copy)
    local HumanoidRootPart2 = LocalPlayer.Character.HumanoidRootPart;
    local HumanoidRootPart3 = p32.HumanoidRootPart;
    local u34 = (HumanoidRootPart3.Position + HumanoidRootPart3.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart2.Position).Unit + Vector3.new(0, 0.5, 0);
    local math_clamp_ret = math.clamp((HumanoidRootPart3.Position - HumanoidRootPart2.Position).Magnitude * 1.5, 0, 150);
    local u35 = time();

    local function finish() -- Line: 126
        -- upvalues: u30 (copy), u31 (copy), u12 (ref)
        u30.BallTargeting:Disconnect();

        if u31.Parent and not u31.OnPlayer.Value then
            u12:DragBall(u31);
        end;

        print("ended.");
    end;

    u30.BallTargeting = RunService.Heartbeat:Connect(function(p36) -- Line: 133
        -- upvalues: u35 (copy), u33 (copy), u31 (copy), finish (copy), HumanoidRootPart3 (copy), u34 (ref), math_clamp_ret (ref), HumanoidRootPart2 (copy)
        if time() > u35 + u33 or (not u31 or u31.OnPlayer.Value) then
            return finish();
        end;

        local _ = HumanoidRootPart3.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
        local v37 = time() > u35 + 0.75;
        u34 = u34:Lerp((HumanoidRootPart3.Position - u31.Position).Unit + Vector3.new(0, v37 and 0.15 or 0.35, 0), 6 * p36);
        math_clamp_ret = math.clamp((HumanoidRootPart3.Position - HumanoidRootPart2.Position).Magnitude * 2.45, 0, 140);

        if u31.Position.Y < 5 or (HumanoidRootPart3.Position - u31.Position).Magnitude <= 7 then
            return finish();
        end;

        u31.AssemblyLinearVelocity = u31.AssemblyLinearVelocity:Lerp(u34 * math_clamp_ret, 6.5 * p36);
    end);
end;

local u38 = tick();
local u39 = nil;

function u12.Shoot(u40) -- Line: 171
    -- upvalues: HumanoidRootPart (ref), u38 (ref), u2 (ref), LocalPlayer (copy), TweenService (copy), Humanoid (ref), Debris (copy), ReplicatedStorage (copy), u3 (ref), StatesController (copy), workspace_CurrentCamera (copy), u7 (ref), u6 (ref), getActiveFlowStats (copy), Trove (copy), u39 (ref), RunService (copy), getCurrentStyle (copy)
    if HumanoidRootPart.AssemblyRootPart ~= HumanoidRootPart then
        return;
    end;

    if u38 > tick() then
        return;
    end;

    if u40.ShootTrove then
        u40.ShootTrove:Destroy();
    end;

    u38 = tick() + 1;
    u40.HoldingShoot = true;
    local Value = u2.Values.HasBall.Value;
    u40.Animations:StopAnims();
    u40.Animations.Shots.Shoot:AdjustSpeed(1);

    if u2.Values.Goalie.Value and u2.Values.IsInPenalty.Value then
        u40.Animations.Movement.ThrowBall.Priority = Enum.AnimationPriority.Action3;
        u40.Animations.Movement.ThrowBall:Play();
        u40.Animations.Movement.ThrowBall:AdjustSpeed(1.35);
        u40.Animations.Ball.ThrowBall.Priority = Enum.AnimationPriority.Action3;
        u40.Animations.Ball.ThrowBall:Play();
        u40.Animations.Ball.ThrowBall:AdjustSpeed(1.35);
    else
        u40.Animations.Shots.Shoot.Priority = Enum.AnimationPriority.Action3;
        u40.Animations.Shots.Shoot:Play();
        u40.Animations.Shots.Shoot:AdjustSpeed(1);
    end;

    LocalPlayer.PlayerGui.ForceBar.Enabled = true;
    local v41 = TweenService:Create(Humanoid, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CameraOffset = Vector3.new(1.25, 1.5, 0)
    });
    v41:Play();
    Debris:AddItem(v41, 0.25);
    local Descendants = u2:GetDescendants();

    for _, v in pairs(Descendants) do
        if not (v.Name == "Football" or (v.Name == "TrajectoryLine" or (v.Name == "DiveHitbox" or (v.Name == "GHitbox" or (v.Name == "Activate" or (ReplicatedStorage.Assets.Vfx:FindFirstChild(v.Name) ~= nil or (v.Name:match("ball") ~= false or (v.Name == "Hitbox" or (v.Parent.Name == "Football" or not (v:IsA("BasePart") and (v.Name ~= "HumanoidRootPart" and (v.Parent == u2 or (v.Parent.Name == "Handle" or v.Name == "Handle")))))))))))) or (v.Name == "VFXPart" or (v:HasTag("VFXPart") or v:GetAttribute("Invis")))) then
            v.Transparency = 0.45;
        end;
    end;

    local function u48(p42, p43) -- Line: 216
        -- upvalues: u38 (ref), TweenService (ref), Humanoid (ref), Debris (ref), LocalPlayer (ref), u40 (copy), u2 (ref), u3 (ref), StatesController (ref), workspace_CurrentCamera (ref), u7 (ref), Value (copy), HumanoidRootPart (ref), u6 (ref), Descendants (copy), ReplicatedStorage (ref)
        u38 = tick() + 0.4;
        local v44 = TweenService:Create(Humanoid, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CameraOffset = Vector3.new(0, 0, 0)
        });
        v44:Play();
        Debris:AddItem(v44, 0.25);
        LocalPlayer.PlayerGui.ForceBar.Enabled = false;

        if p43 then
            u40.Animations.Shots.Shoot:Stop(0.05);
            u40.Animations.Movement.ThrowBall:Stop(0.05);
            u40.Animations.Ball.ThrowBall:Stop(0.05);
        else
            u40.Animations.Shots.Shoot:AdjustSpeed(1);
            u40.Animations.Movement.ThrowBall:AdjustSpeed(1);
            u40.Animations.Ball.ThrowBall:AdjustSpeed(1);
        end;

        u40.HoldingShoot = false;
        u40.ShootTrove:Destroy();

        if u2.Values.HasBall.Value and not p42 then
            if u2.Values.Goalie.Value and u2.Values.IsInPenalty.Value then
                local u45 = u3;
                task.delay(0.2, function() -- Line: 241
                    -- upvalues: u40 (ref), StatesController (ref), u45 (copy), workspace_CurrentCamera (ref)
                    if not u40.Camera.Cutscene then
                        StatesController.CharacterEvents.OnShoot:Fire("Shoot");
                        u40.BallService.Shoot:Fire(u45, nil, nil, workspace_CurrentCamera.CFrame.LookVector);
                    end;
                end);
            else
                if u7 then
                    return;
                end;

                local u46 = u3;

                if Value == false then
                    local RaycastParams_new_ret = RaycastParams.new();
                    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Field };
                    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
                    local u47;

                    if workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -7, 0), RaycastParams_new_ret) == nil then
                        u47 = Instance.new("BodyVelocity");
                        u47.MaxForce = Vector3.new(0, workspace.Gravity * HumanoidRootPart.AssemblyMass * 0.8, 0);
                        u47.Velocity = Vector3.new(0, 0, 0);
                        u47.Parent = HumanoidRootPart;
                    else
                        u47 = nil;
                    end;

                    local Volley = u40.Animations.Shots.Volley;
                    local Volley2 = u40.Animations.Ball.Volley;
                    u40.Animations:StopAnims();
                    Volley.Priority = Enum.AnimationPriority.Action4;
                    Volley:Play();
                    Volley:AdjustSpeed(1.15);
                    Volley2.Priority = Enum.AnimationPriority.Action4;
                    Volley2:Play();
                    Volley2:AdjustSpeed(1.15);
                    u40.Animations.StopBallMovementAnims = true;
                    task.delay(0.3, function() -- Line: 291
                        -- upvalues: u47 (ref), u40 (ref), StatesController (ref), u46 (copy), workspace_CurrentCamera (ref)
                        if u47 then
                            u47:Destroy();
                        end;

                        if not u40.Camera.Cutscene then
                            StatesController.CharacterEvents.OnShoot:Fire("Volley");
                            u40.BallService.Shoot:Fire(u46, nil, nil, workspace_CurrentCamera.CFrame.LookVector, "Volley");
                        end;
                    end);
                    task.delay(1.5, function() -- Line: 301
                        -- upvalues: u40 (ref)
                        u40.Animations.StopBallMovementAnims = false;
                    end);
                elseif not u40.Camera.Cutscene then
                    StatesController.CharacterEvents.OnShoot:Fire("Shoot");
                    u40.BallService.Shoot:Fire(u3, nil, nil, workspace_CurrentCamera.CFrame.LookVector);
                end;
            end;
        end;

        u3 = 50;
        u6 = 0;
        task.spawn(function() -- Line: 317
            -- upvalues: Descendants (ref), ReplicatedStorage (ref), u2 (ref)
            if Descendants then
                for _, v in Descendants do
                    if v.Parent ~= nil and not (v.Name:match("ball") or (v:GetAttribute("Invis") or not (v:IsA("BasePart") and (v.Name ~= "DiveHitbox" and (v.Name ~= "TrajectoryLine" and (v.Name ~= "GDHitbox" and (v.Name ~= "Activate" and (ReplicatedStorage.Assets.Vfx:FindFirstChild(v.Name) == nil and (v.Name ~= "Hitbox" and (v.Name ~= "HumanoidRootPart" and (v.Parent == u2 or (v.Parent.Name == "Handle" or v.Name == "Handle")))))))))))) and v.Name ~= "VFXPart" then
                        v.Transparency = 0;
                    end;
                end;
            end;
        end);
    end;

    local u49 = 0;
    local _, u50 = getActiveFlowStats(LocalPlayer);
    u40.ShootTrove = Trove.new();
    u40.BallService.SetIsHoldingShoot:Fire(true);
    u40.ShootTrove:Add(function() -- Line: 353
        -- upvalues: u40 (copy), u48 (copy), u39 (ref)
        if u40.HoldingShoot then
            u48(true, true);
        end;

        u40.BallService.SetIsHoldingShoot:Fire(false);
        u39 = nil;
    end);
    u40.ShootTrove:Add(RunService.Heartbeat:Connect(function(p51) -- Line: 361
        -- upvalues: u40 (copy), getCurrentStyle (ref), u50 (copy), LocalPlayer (ref), u3 (ref), u6 (ref), u49 (ref), Value (copy), u2 (ref), u48 (copy)
        local v52 = u40.AbilityController.legacy.Mode == "Offensive Mode" and getCurrentStyle() == "Reo" and 138 or 125;

        if u50 and u50.Stats.ShotChargeSpeed then
            v52 = v52 * u50.Stats.ShotChargeSpeed;
        elseif LocalPlayer.PlayerStats.InFlow.Value and (LocalPlayer.PlayerStats.Flow.Value == "Stealth" or LocalPlayer.PlayerStats.Flow.Value == "Godspeed") then
            v52 = v52 * 1.1;
        end;

        u3 = u3 + p51 * v52;
        u6 = u6 + p51 * 45;
        u49 = u49 + p51 * 10;

        if u49 >= 2.1 then
            u40.Animations.Movement.ThrowBall:AdjustSpeed(0);
            u40.Animations.Shots.Shoot:AdjustSpeed(0);
            u40.Animations.Ball.ThrowBall:AdjustSpeed(0);
        end;

        LocalPlayer.PlayerGui.ForceBar.ForceBarBackground.BG.Bar.UIGradient.Offset = Vector2.new(0, 1 - (u3 - 50) / 50);

        if Value == false and u2.Values.HasBall.Value then
            if u2:FindFirstChild("Ring") then
                u2.Ring:Destroy();
            end;

            u3 = 110;
            u48();

            return;
        end;

        if u40.StatesController.States.Ability == true then
            u48(true);

            return;
        end;

        if u3 >= 110 then
            u3 = 110;
        end;

        if u6 >= 50 then
            u48();

            return;
        end;

        if u40.HoldingShoot ~= false then
            return;
        end;

        u48();
    end));
end;

function u12.Pass(u53) -- Line: 404
    -- upvalues: HumanoidRootPart (ref), u38 (ref), u2 (ref), environment (copy), Trove (copy), RunService (copy), StatesController (copy)
    if HumanoidRootPart.AssemblyRootPart ~= HumanoidRootPart then
        return;
    end;

    if u38 > tick() then
        return;
    end;

    if u53.ShootTrove then
        u53.ShootTrove:Destroy();
    end;

    if u53.Closest == nil then
        return;
    end;

    if u2.Values.HasBall.Value == false then
        return;
    end;

    if environment.config.PassingDisabled then
        return;
    end;

    u38 = tick() + 1;
    local _ = u53.Closest;
    print("pass");
    u53.Animations:StopAnims();
    local v54 = u53.Animations.Shots.Pass or u53.Animations.Shots.Shoot;
    v54.Priority = Enum.AnimationPriority.Action4;
    v54:Play();
    local u55 = time();
    u53.ShootTrove = Trove.new();
    u53.ShootTrove:Add(RunService.Heartbeat:Connect(function() -- Line: 422
        -- upvalues: u55 (copy), u53 (copy), StatesController (ref)
        if time() - u55 > 0.2 then
            u53.ShootTrove:Destroy();
            StatesController.CharacterEvents.OnShoot:Fire("Pass");
            u53.BallService.Pass:Fire();
        end;
    end));
end;

function u12.Slide(u56) -- Line: 431
    -- upvalues: HumanoidRootPart (ref), u2 (ref), getCurrentStyle (copy), u10 (ref), LocalPlayer (copy), StatesController (copy), getActiveFlowStats (copy), Trove (copy), ReplicatedStorage (copy), workspace_CurrentCamera (copy), u5 (ref), KnitClient (copy), RunService (copy), ClampDirection (copy)
    if HumanoidRootPart.AssemblyRootPart ~= HumanoidRootPart then
        return;
    end;

    if u2.Values.Sliding.Value or u56.Animations.Movement.Slide.IsPlaying then
        return;
    end;

    if u2.Values.HasBall.Value then
        return;
    end;

    if u2.Values.Dribbling.Value or u56.Animations.Dribbles[getCurrentStyle()] and u56.Animations.Dribbles[getCurrentStyle()].IsPlaying then
        return;
    end;

    if u56.HoldingShoot then
        return;
    end;

    if u10 > tick() then
        return;
    end;

    if LocalPlayer.PlayerStats.Stamina.Value <= 10 then
        return;
    end;

    if u56.SlideTrove then
        u56.SlideTrove:Destroy();
    end;

    u56.StaminaService.DecreaseStamina:Fire(10);
    u56.Animations:StopAnims();
    u56.Animations.Movement.Slide.Priority = Enum.AnimationPriority.Action2;
    u56.Animations.Movement.Slide:Play();
    u56.Animations.Movement.Slide:AdjustSpeed(1.35);
    StatesController.CharacterEvents.OnSlide:Fire();
    local v57, v58 = getActiveFlowStats(LocalPlayer);

    if v58 and v58.Stats.SlideCooldown then
        u10 = tick() + v58.Stats.SlideCooldown;
    else
        u10 = tick() + 3;
    end;

    u56.SlideTrove = Trove.new();
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    BodyVelocity.Parent = HumanoidRootPart;
    u56.SlideTrove:Add(BodyVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.P = 5000;
    BodyGyro.D = 100;
    BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
    BodyGyro.Parent = HumanoidRootPart;
    u56.SlideTrove:Add(BodyGyro);
    local v59 = HumanoidRootPart.CFrame.LookVector:Dot((ReplicatedStorage.Football.Value.Position - HumanoidRootPart.Position).Unit);
    local math_acos_ret = math.acos(v59);
    local Unit = (workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    local v60 = getCurrentStyle() == "Loki" and u56.StatesController.States.Running and 72.5 or 65;

    if v58 and v58.Stats.SlideDistanceBoost then
        v60 = v60 + v58.Stats.SlideDistanceBoost;
    end;

    local v61;

    if v57 == "Godspeed" then
        v61 = v60 + 7;
    else
        v61 = u56.AbilityController.legacy.Mode == "Defensive Mode" and getCurrentStyle() == "Reo" and 72 or v60;
    end;

    local u62 = LocalPlayer.PlayerStats.Flow.Value == "Crow" and LocalPlayer.PlayerStats.InFlow.Value and 75 or v61;
    local v63;

    if ReplicatedStorage.Football.Value.Parent == workspace then
        v63 = ReplicatedStorage.Football.Value.Position.Y > 13 and ReplicatedStorage.Football.Value.AssemblyLinearVelocity.Magnitude > 10 and Vector3.new(0, 0, 0) or (ReplicatedStorage.Football.Value.Position + ReplicatedStorage.Football.Value.AssemblyLinearVelocity - HumanoidRootPart.Position).Unit * 1;
    else
        if not ReplicatedStorage.Football.Value:FindFirstChild("Char") then
            u56.SlideTrove:Destroy();

            return;
        end;

        local v64 = ReplicatedStorage.Football.Value.Position.Y > 11 and ReplicatedStorage.Football.Value.Char.Value.HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 10 and Vector3.new(0, 0, 0) or (ReplicatedStorage.Football.Value.Position + ReplicatedStorage.Football.Value.Char.Value.HumanoidRootPart.AssemblyLinearVelocity - HumanoidRootPart.Position).Unit * 1;
        local v65 = ReplicatedStorage.Football.Value.Char.Value.HumanoidRootPart.CFrame.LookVector:Dot((HumanoidRootPart.Position - ReplicatedStorage.Football.Value.Char.Value.HumanoidRootPart.Position).Unit);
        v63 = math.acos(v65) < 1.5707963267948966 and Vector3.new(0, 0, 0) or v64;
    end;

    local v66 = ReplicatedStorage.Football.Value.AssemblyLinearVelocity.Magnitude <= 20 and Vector3.new(0, 0, 0) or v63;
    local Vector3_new_ret = Vector3.new(v66.X, 0, v66.Z);

    if math_acos_ret < 1.9039955476301778 and math_acos_ret < 1.5707963267948966 then
        Unit = Unit + Vector3_new_ret;
    end;

    local Unit2 = Unit.Unit;
    u5 = u5 - 1;

    if u5 <= 0 then
        u5 = 1;
    end;

    u56.BallService.Slide:Fire(nil, (tostring(string.gsub(game.JobId, "-", ""))));
    KnitClient.GetController("CameraController");
    local u67 = Unit2;
    u56.SlideTrove:Connect(RunService.Heartbeat, function(p68) -- Line: 541
        -- upvalues: u56 (copy), ClampDirection (ref), Unit2 (ref), workspace_CurrentCamera (ref), u67 (ref), BodyVelocity (copy), u62 (ref), BodyGyro (copy), u2 (ref)
        if u56.StatesController.States.Ability then
            u56.SlideTrove:Destroy();

            return;
        end;

        local v69 = ClampDirection(Unit2, (workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit, 80);
        u67 = v69;
        BodyVelocity.Velocity = v69 * u62;
        BodyGyro.CFrame = CFrame.lookAlong(Vector3.new(0, 0, 0), BodyVelocity.Velocity);
        u62 = u62 - p68 * 60;

        if u62 <= 9 or u2.IsRagdoll.Value then
            u56.SlideTrove:Destroy();
            u56.StatesController.States.Running = true;
        end;
    end);
    task.delay(2, function() -- Line: 562
        -- upvalues: BodyVelocity (copy), u56 (copy)
        if BodyVelocity.Parent ~= nil then
            u56.SlideTrove:Destroy();
        end;
    end);
end;

function u12.Dribble(p70) -- Line: 567
    -- upvalues: u2 (ref), getCurrentStyle (copy), u11 (ref), LocalPlayer (copy), getActiveFlowStats (copy), u4 (ref), StatesController (copy)
    if u2.Values.Sliding.Value or p70.Animations.Movement.Slide.IsPlaying then
        return;
    end;

    if u2.Values.Dribbling.Value or p70.Animations.Dribbles[getCurrentStyle()] and p70.Animations.Dribbles[getCurrentStyle()].IsPlaying then
        return;
    end;

    if u2.Values.HasBall.Value == false then
        return;
    end;

    if u11 > tick() then
        return;
    end;

    if LocalPlayer.PlayerStats.Stamina.Value <= 10 then
        return;
    end;

    if p70.SlideTrove then
        p70.SlideTrove:Destroy();
    end;

    print("Dribbled at", tick());
    p70.StaminaService.DecreaseStamina:Fire(10);
    p70.Animations:StopAnims();

    if p70.Animations.Dribbles[getCurrentStyle()] then
        p70.Animations.Dribbles[getCurrentStyle()].Priority = Enum.AnimationPriority.Action3;
        p70.Animations.Dribbles[getCurrentStyle()]:Play();
    else
        p70.Animations.Dribbles.Loki.Priority = Enum.AnimationPriority.Action3;
        p70.Animations.Dribbles.Loki:Play();
    end;

    if p70.Animations.Ball[getCurrentStyle() .. "Dribble"] then
        p70.Animations.Ball[getCurrentStyle() .. "Dribble"].Priority = Enum.AnimationPriority.Action3;
        p70.Animations.Ball[getCurrentStyle() .. "Dribble"]:Play();
    else
        p70.Animations.Ball.IsagiDribble.Priority = Enum.AnimationPriority.Action3;
        p70.Animations.Ball.IsagiDribble:Play();
    end;

    local _, v71 = getActiveFlowStats(LocalPlayer);
    local v72 = getCurrentStyle() == "Bachira" and LocalPlayer.PlayerStats.InAwakening.Value and 2 or 3;

    if LocalPlayer.PlayerStats.InFlow.Value and (LocalPlayer.PlayerStats.Flow.Value == "Monster" or (LocalPlayer.PlayerStats.Flow.Value == "Bee Freestyle" or LocalPlayer.PlayerStats.Flow.Value == "Master Of All Trades")) then
        v72 = v72 / 1.25;
    end;

    if getCurrentStyle() == "Reo" and p70.AbilityController.legacy.Mode == "Offensive Mode" then
        v72 = v72 / 1.15;
    end;

    u4 = u4 - 1;
    local v73;

    if u4 <= 0 then
        u4 = 1;

        if getCurrentStyle() == "Reo" and LocalPlayer.Character:GetAttribute("StrikeMode") then
            u4 = u4 + 1;
        end;

        if v71 and v71.Stats.ExtraDribbles then
            u4 = u4 + v71.Stats.ExtraDribbles;
            v73 = 3;
        elseif (LocalPlayer.PlayerStats.Flow.Value == "Awakened Genius" or LocalPlayer.PlayerStats.Flow.Value == "Master Of All Trades") and LocalPlayer.PlayerStats.InFlow.Value then
            u4 = u4 + 1;
            v73 = 3;
        elseif LocalPlayer.PlayerStats.Flow.Value == "Bee Freestyle" and LocalPlayer.PlayerStats.InFlow.Value then
            u4 = u4 + 3;
            v73 = 3;
        else
            v73 = 3;
        end;
    else
        local v74 = v71 and v71.Stats.ExtraDribbles and 1 or v72;
        local v75 = getCurrentStyle() == "Reo" and LocalPlayer.Character:GetAttribute("StrikeMode") and 1 or v74;
        v73 = (LocalPlayer.PlayerStats.Flow.Value == "Awakened Genius" or LocalPlayer.PlayerStats.Flow.Value == "Master Of All Trades") and LocalPlayer.PlayerStats.InFlow.Value and 1 or (LocalPlayer.PlayerStats.Flow.Value == "Bee Freestyle" and LocalPlayer.PlayerStats.InFlow.Value and 1 or v75);
    end;

    u11 = tick() + v73;
    StatesController.CharacterEvents.OnDribble:Fire();
    p70.BallService.Dribble:Fire(tostring(string.gsub(game.JobId, "-", "")), v73);
end;

function u12.Flick(u76) -- Line: 660
    -- upvalues: LocalPlayer (copy), u7 (ref), u9 (ref), StatesController (copy)
    if LocalPlayer.Character.Values.HasBall.Value == false then
        return;
    end;

    if LocalPlayer.PlayerStats.Stamina.Value <= 25 then
        return;
    end;

    u7 = true;
    u9 = tick();
    u76.Animations:StopAnims();
    u76.Animations.Flicks.Flick.Priority = Enum.AnimationPriority.Action3;
    u76.Animations.Flicks.Flick:Play();
    u76.Animations.Ball.Flick.Priority = Enum.AnimationPriority.Action3;
    u76.Animations.Ball.Flick:Play();

    if LocalPlayer.Character.Values.HasBall.Value then
        u76.BallService.Shoot:Fire(50, 25, "Flick");
    end;

    task.delay(0.35, function() -- Line: 678
        -- upvalues: LocalPlayer (ref), StatesController (ref), u76 (copy), u7 (ref)
        if not (LocalPlayer.Character.Values.HasBall.Value and (LocalPlayer.PlayerStats.Stamina.Value > 25 and not StatesController.States.Ability)) then
            u7 = false;

            return;
        end;

        StatesController.CharacterEvents.OnShoot:Fire("Flick");
        u76.BallService.Shoot:Fire(50, 25, "FlickKick");
    end);
end;

function u12.ResetChecks(u77) -- Line: 690
    -- upvalues: Trove (copy), LocalPlayer (copy), UserInputService (copy), Humanoid (ref), u39 (ref), StatesController (copy)
    if u77.NewTrove then
        u77.NewTrove:Destroy();
    end;

    u77.NewTrove = Trove.new();
    u77.NewTrove:Connect(LocalPlayer.Character.Values:WaitForChild("IsInPenalty"):GetPropertyChangedSignal("Value"), function() -- Line: 694
        -- upvalues: LocalPlayer (ref)
        local v78 = LocalPlayer.Character.Values.Goalie.Value and LocalPlayer.Character.Values.IsInPenalty.Value;
        LocalPlayer.PlayerGui.Mobile.NoBall.Dive.Visible = v78;
        LocalPlayer.PlayerGui.InGameUI.KeybindsPC.Dive.Visible = v78;
        LocalPlayer.PlayerGui.InGameUI.KeybindsConsole.Dive.Visible = v78;
    end);
    u77.NewTrove:Connect(LocalPlayer.Character.Values:WaitForChild("Goalie"):GetPropertyChangedSignal("Value"), function() -- Line: 701
        -- upvalues: LocalPlayer (ref)
        local v79 = LocalPlayer.Character.Values.Goalie.Value and LocalPlayer.Character.Values.IsInPenalty.Value;
        LocalPlayer.PlayerGui.Mobile.NoBall.Dive.Visible = v79;
        LocalPlayer.PlayerGui.InGameUI.KeybindsPC.Dive.Visible = v79;
        LocalPlayer.PlayerGui.InGameUI.KeybindsConsole.Dive.Visible = v79;
    end);
    local v80 = LocalPlayer.Character.Values.Goalie.Value and LocalPlayer.Character.Values.IsInPenalty.Value;
    LocalPlayer.PlayerGui.Mobile.NoBall.Dive.Visible = v80;
    LocalPlayer.PlayerGui.InGameUI.KeybindsPC.Dive.Visible = v80;
    LocalPlayer.PlayerGui.InGameUI.KeybindsConsole.Dive.Visible = v80;
    u77.NewTrove:Connect(LocalPlayer.Character.Values.HasBall:GetPropertyChangedSignal("Value"), function() -- Line: 713
        -- upvalues: LocalPlayer (ref), UserInputService (ref)
        if LocalPlayer.Character.Values.HasBall.Value then
            if UserInputService.TouchEnabled then
                LocalPlayer.PlayerGui.Mobile.Enabled = true;
                LocalPlayer.PlayerGui.Mobile.NoBall.Visible = false;
                LocalPlayer.PlayerGui.Mobile.Ball.Visible = true;
            end;
        elseif UserInputService.TouchEnabled then
            LocalPlayer.PlayerGui.Mobile.Enabled = true;
            LocalPlayer.PlayerGui.Mobile.NoBall.Visible = true;
            LocalPlayer.PlayerGui.Mobile.Ball.Visible = false;
        end;
    end);
    u77.NewTrove:Connect(Humanoid.StateChanged, function(p81, p82) -- Line: 729
        -- upvalues: u39 (ref), StatesController (ref), u77 (copy)
        if p82 == Enum.HumanoidStateType.Jumping then
            if u39 then
                u39();

                return;
            end;

            StatesController.CharacterEvents.OnJump:Fire();
            u77:Flick();
        end;
    end);
end;

function u12.DragBall(u83, p84) -- Line: 741
    -- upvalues: RunService (copy), ReplicatedStorage (copy)
    if u83.Drag then
        u83.Drag:Disconnect();
    end;

    local u85 = 0.999;
    local u86 = 0;
    u83.Drag = RunService.Heartbeat:Connect(function(p87) -- Line: 749
        -- upvalues: ReplicatedStorage (ref), u86 (ref), u83 (copy), u85 (ref)
        local Value = ReplicatedStorage.Football.Value;

        if Value and (Value:GetAttribute("AdvanceUbersPause") or Value:GetAttribute("AikuAwakeningPause")) then
            return;
        end;

        u86 = u86 + p87;

        if not Value or (Value.Parent ~= workspace and true or (Value.OnPlayer.Value or Value.AssemblyLinearVelocity.Magnitude <= 10)) then
            u83.Drag:Disconnect();

            return;
        end;

        for i = 1, u86 // 0.016666666666666666 do
            local Position = Value.CFrame.Position;
            local AssemblyLinearVelocity = Value.AssemblyLinearVelocity;

            if Position.Y <= 18 then
                u85 = u85 - 0.0003333333333333333;
                AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X * u85, AssemblyLinearVelocity.Y, AssemblyLinearVelocity.Z * u85);
            end;

            if Position.Y < 27 and Position.Y > 8 then
                AssemblyLinearVelocity = AssemblyLinearVelocity + Vector3.new(0, 1.3666667, 0);
            end;

            Value.AssemblyLinearVelocity = AssemblyLinearVelocity;
            u86 = u86 - 0.016666666666666666;
            local _ = i;
        end;
    end);
end;

function u12.CheckInput(u88) -- Line: 778
    -- upvalues: KnitClient (copy), UserInputService (copy), LocalPlayer (copy), u2 (ref), ReplicatedStorage (copy), canRequestCR (copy), PlayerData (copy)
    local u89 = tick();
    u88.Awakening = KnitClient.GetController("AwakeningController");
    u88.Effects = KnitClient.GetService("EffectsService");
    u88.Settings = KnitClient.GetController("Settings");
    u88.Camera = KnitClient.GetController("CameraController");

    if UserInputService.TouchEnabled then
        local Descendants = LocalPlayer.PlayerGui:WaitForChild("Mobile"):GetDescendants();

        for _, v in pairs(Descendants) do
            if v:IsA("ImageButton") ~= false then
                u88.BaseTrove:Connect(v.MouseButton1Down, function() -- Line: 790
                    -- upvalues: u88 (copy), LocalPlayer (ref), u2 (ref), v (copy)
                    if u88.Camera.Cutscene then
                        return;
                    end;

                    if LocalPlayer.Team == game.Teams.Visitor then
                        return;
                    end;

                    if u2.IsRagdoll.Value then
                        return;
                    end;

                    if u88.StatesController.States.Ability then
                        return;
                    end;

                    if u88.StatesController.NoShoot then
                        return;
                    end;

                    if v.Name == "Shoot" then
                        u88:Shoot();
                    end;
                end);
                u88.BaseTrove:Connect(v.MouseButton1Click, function() -- Line: 803
                    -- upvalues: u88 (copy), LocalPlayer (ref), u2 (ref), v (copy), u89 (ref), ReplicatedStorage (ref), canRequestCR (ref)
                    if u88.Camera.Cutscene then
                        return;
                    end;

                    if LocalPlayer.Team == game.Teams.Visitor then
                        return;
                    end;

                    if u2.IsRagdoll.Value then
                        return;
                    end;

                    if u88.StatesController.States.Ability then
                        return;
                    end;

                    local v90 = u2.Values.Goalie.Value and u2.Values.IsInPenalty.Value;

                    if v.Name == "Run" then
                        u88.StatesController.States.Running = not u88.StatesController.States.Running;

                        return;
                    end;

                    if v.Name == "Pass" then
                        u88:Pass();

                        return;
                    end;

                    if v.Name == "Dribble" and not v90 then
                        u88:Dribble();

                        return;
                    end;

                    if v.Name == "Slide" then
                        u88:Slide();

                        return;
                    end;

                    if v.Name == "Awaken" then
                        u88.Awakening:Awakening();

                        return;
                    end;

                    if v.Name == "Shoot" then
                        u88.HoldingShoot = false;

                        return;
                    end;

                    if v.Name ~= "Request" then
                        if v.Name == "RequestCR" then
                            if not canRequestCR(LocalPlayer) then
                                return;
                            end;

                            if u89 > tick() then
                                return;
                            end;

                            u89 = tick() + 3;
                            u88.Effects.Vfx:Fire(ReplicatedStorage.Effects.PassCR, {
                                Char = u2
                            });
                            u88.Animations:StopAnims();
                            u88.Animations.Movement.Request.Priority = Enum.AnimationPriority.Action2;
                            u88.Animations.Movement.Request:Play();
                        end;

                        return;
                    end;

                    print("pass req");

                    if u89 > tick() then
                        return;
                    end;

                    u89 = tick() + 3;
                    u88.Effects.Vfx:Fire(ReplicatedStorage.Effects.Pass, {
                        Char = u2
                    });
                    u88.Animations:StopAnims();
                    u88.Animations.Movement.Request.Priority = Enum.AnimationPriority.Action2;
                    u88.Animations.Movement.Request:Play();
                end);

                if v.Name == "Shoot" then
                    u88.BaseTrove:Connect(v.MouseButton1Up, function() -- Line: 851
                        -- upvalues: u88 (copy)
                        u88.HoldingShoot = false;
                    end);
                end;
            end;
        end;
    end;

    u88.BaseTrove:Connect(UserInputService.InputBegan, function(p91, p92) -- Line: 860
        -- upvalues: u88 (copy), LocalPlayer (ref), u2 (ref), PlayerData (ref), u89 (ref), ReplicatedStorage (ref), canRequestCR (ref)
        if p92 then
            return;
        end;

        if u88.Camera.Cutscene then
            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if u2.IsRagdoll.Value then
            return;
        end;

        if u88.StatesController.States.Ability then
            return;
        end;

        if u88.StatesController.NoShoot then
            return;
        end;

        if p91.KeyCode == Enum.KeyCode.LeftShift or p91.KeyCode == Enum.KeyCode.ButtonL2 then
            if PlayerData.Data.Settings.RunLock == true then
                u88.StatesController.States.Running = not u88.StatesController.States.Running;
            else
                u88.StatesController.States.Running = true;
            end;
        end;

        local v93 = u2.Values.Goalie.Value and u2.Values.IsInPenalty.Value;

        if p91.UserInputType == Enum.UserInputType.MouseButton1 or p91.KeyCode == Enum.KeyCode.ButtonR2 then
            u88:Shoot();
        elseif p91.UserInputType == Enum.UserInputType.MouseButton2 or p91.KeyCode == Enum.KeyCode.ButtonL1 then
            u88:Pass();
        elseif p91.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.PC.Slide] or p91.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Slide] then
            u88:Slide();
        end;

        if not (p91.KeyCode ~= Enum.KeyCode[PlayerData.Data.PlayerKeybinds.PC.Dribble] and p91.KeyCode ~= Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Dribble] or v93) then
            u88:Dribble();
        end;

        if p91.KeyCode ~= Enum.KeyCode[PlayerData.Data.PlayerKeybinds.PC.Request] and p91.KeyCode ~= Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Request] then
            if p91.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.PC.RequestCR] or p91.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.RequestCR] then
                if not canRequestCR(LocalPlayer) then
                    return;
                end;

                if u89 > tick() then
                    return;
                end;

                u89 = tick() + 3;
                u88.Effects.Vfx:Fire(ReplicatedStorage.Effects.PassCR, {
                    Char = u2
                });
                u88.Animations:StopAnims();
                u88.Animations.Movement.Request.Priority = Enum.AnimationPriority.Action2;
                u88.Animations.Movement.Request:Play();
            end;

            return;
        end;

        if u89 > tick() then
            return;
        end;

        u89 = tick() + 3;
        u88.Effects.Vfx:Fire(ReplicatedStorage.Effects.Pass, {
            Char = u2
        });
        u88.Animations:StopAnims();
        u88.Animations.Movement.Request.Priority = Enum.AnimationPriority.Action2;
        u88.Animations.Movement.Request:Play();
    end);
    u88.BaseTrove:Connect(UserInputService.InputEnded, function(p94, p95) -- Line: 915
        -- upvalues: u88 (copy), PlayerData (ref)
        if p95 then
            return;
        end;

        if p94.UserInputType == Enum.UserInputType.MouseButton1 or p94.KeyCode == Enum.KeyCode.ButtonR2 then
            u88.HoldingShoot = false;
        end;

        if (p94.KeyCode == Enum.KeyCode.LeftShift or p94.KeyCode == Enum.KeyCode.ButtonL2) and PlayerData.Data.Settings.RunLock == false then
            u88.StatesController.States.Running = false;
        end;
    end);
end;

function u12.Predict(u96, p97, p98) -- Line: 930
    -- upvalues: u2 (ref), ReplicatedStorage (copy), findLandingPosition (copy), RunService (copy)
    if u96.PredictOBJ then
        u96.PredictOBJ:Destroy();
    end;

    if u96.PredictionTrove then
        u96.PredictionTrove:Disconnect();
    end;

    if not (u2.Values.Goalie.Value and u2.Values.IsInPenalty.Value) then
        u96.PredictOBJ = ReplicatedStorage.Assets.Misc.PredictionVFX:Clone();
        u96.PredictOBJ.Parent = workspace;
        u96.PredictOBJ.PrimaryPart.Position = Vector3.new(0, 8, 0);
        local u99 = tick() + 1;
        local Value = ReplicatedStorage.Football.Value;

        if Value:FindFirstChild("Beam") then
            Value.Beam.Attachment1 = u96.PredictOBJ.PrimaryPart.Attachment1;
            Value.Beam.Enabled = true;
        end;

        u96.PredictionTrove = RunService.Heartbeat:Connect(function(p100) -- Line: 972
            -- upvalues: u96 (copy), ReplicatedStorage (ref), u99 (copy)
            local Football = workspace:FindFirstChild("Football");

            if not Football then
                u96.PredictOBJ:Destroy();

                if ReplicatedStorage.Football.Value:FindFirstChild("Beam") then
                    ReplicatedStorage.Football.Value.Beam.Enabled = false;
                end;

                u96.PredictionTrove:Disconnect();

                return;
            end;

            if not (u96.PredictOBJ and u96.PredictOBJ.Parent) then
                u96.PredictionTrove:Disconnect();

                return;
            end;

            local math_clamp_ret = math.clamp((Football.Position.Y - 8.5) / 20, 0.1, 3);
            u96.PredictOBJ:ScaleTo(math_clamp_ret);
            u96.PredictOBJ.PrimaryPart.Position = Vector3.new(Football.Position.X, 8.5, Football.Position.Z);

            if Football.Position.Y > 10 or u99 >= tick() then
                return;
            end;

            u96.PredictOBJ:Destroy();

            if ReplicatedStorage.Football.Value and ReplicatedStorage.Football.Value:FindFirstChild("Beam") then
                ReplicatedStorage.Football.Value.Beam.Enabled = false;
            end;

            u96.PredictionTrove:Disconnect();
        end);

        return;
    end;

    u96.PredictOBJ = ReplicatedStorage.Assets.Misc.GkPredict:Clone();
    u96.PredictOBJ.Parent = workspace;
    local PredictOBJ = u96.PredictOBJ;
    local X = findLandingPosition(p97, p98).X;
    local Z = findLandingPosition(p97, p98).Z;
    PredictOBJ.Position = Vector3.new(X, 10, Z);

    if u96.PredictOBJ.Position.X < -226 then
        u96.PredictOBJ.Position = Vector3.new(-226, 10, u96.PredictOBJ.Position.Z);
    end;

    if u96.PredictOBJ.Position.X > 306 then
        u96.PredictOBJ.Position = Vector3.new(306, 10, u96.PredictOBJ.Position.Z);
    end;

    local u101 = tick() + 1;
    u96.PredictionTrove = RunService.Heartbeat:Connect(function(p102) -- Line: 953
        -- upvalues: u96 (copy), u101 (copy)
        local Football = workspace:FindFirstChild("Football");

        if Football == nil then
            u96.PredictOBJ:Destroy();
            u96.PredictionTrove:Disconnect();

            return;
        end;

        if Football.Position.Y > 10 or u101 >= tick() then
            return;
        end;

        u96.PredictOBJ:Destroy();
        u96.PredictionTrove:Disconnect();
    end);
end;

function u12.KnitStart(u103) -- Line: 1006
    -- upvalues: KnitClient (copy), getActiveFlowStats (copy), LocalPlayer (copy), Players (copy), u12 (copy), HumanoidRootPart (ref), u2 (ref), Trove (copy), RunService (copy), getCurrentStyle (copy), u7 (ref), u8 (ref), workspace_CurrentCamera (copy), Humanoid (ref), ReplicatedStorage (copy), FindCurveDirection (copy), u3 (ref), PlrStyles (copy), script_BalancingVisualiser (copy), Raycast (copy), SoundManager (copy), VfxManager (copy), Debris (copy), u5 (ref), u4 (ref), GuiService (copy), Essentials (copy)
    u103.BallService = KnitClient.GetService("BallService");
    u103.Animations = require(script.Parent.AnimationController);
    u103.StatesController = require(script.Parent.StatesController);
    u103.AbilityController = KnitClient.GetController("AbilityController");
    u103.StaminaService = KnitClient.GetService("StaminaService");
    u103.Running = false;
    u103.Closest = nil;
    u103.Attach0 = Instance.new("Attachment");
    u103.Attach0.Parent = workspace.Terrain;
    u103.Attach1 = Instance.new("Attachment");
    u103.Attach1.Parent = workspace.Terrain;
    u103.Beam = Instance.new("Beam");
    u103.Beam.Parent = workspace.Terrain;
    u103.Beam.Attachment0 = u103.Attach0;
    u103.Beam.Attachment1 = u103.Attach1;
    u103.BaseTrove:Connect(u103.BallService.Pass, function(u104) -- Line: 1026
        -- upvalues: u103 (copy), getActiveFlowStats (ref), LocalPlayer (ref), Players (ref), u12 (ref), HumanoidRootPart (ref), u2 (ref), Trove (ref), RunService (ref), getCurrentStyle (ref)
        local Closest = u103.Closest;

        if not Closest then
            return;
        end;

        local _, u105 = getActiveFlowStats(LocalPlayer);
        local v106;

        if Closest then
            v106 = Players:GetPlayerFromCharacter(Closest);
        else
            v106 = Closest;
        end;

        if not Closest:GetAttribute("Style") and v106 then
            local _ = v106.PlayerStats.Style.Value;
        end;

        local _ = LocalPlayer.PlayerStats.Style.Value;
        local v107 = u105 and (u105.Stats.AccuratePassesTime or 0) or 0;

        if v107 > 0 then
            u12:BallFollowPlayer(u104, Closest, v107);

            return;
        end;

        local v108 = u105 and (u105.Stats.PassArc or 0.1) or 0.1;
        local Vector3_new_ret = Vector3.new(Closest.HumanoidRootPart.AssemblyLinearVelocity.X, 0, Closest.HumanoidRootPart.AssemblyLinearVelocity.Z);
        local Position = Closest.HumanoidRootPart.Position;
        local u109 = (Position + Vector3_new_ret - HumanoidRootPart.Position).Unit + Vector3.new(0, v108, 0);
        local v110 = (Position - HumanoidRootPart.Position).Magnitude * 1.85;
        local Attribute = u2:GetAttribute("DartboardLens");
        local u111 = Attribute and 1 or (u105 and u105.Stats.HomingPass and 0.45 or 0.15);
        local math_clamp_ret = math.clamp(v110, 30, 200);

        if u105 and u105.Stats.PassPowerMultiplier then
            math_clamp_ret = math_clamp_ret * u105.Stats.PassPowerMultiplier;
        end;

        if Attribute then
            u109 = u109 + HumanoidRootPart.CFrame.RightVector;
        end;

        u104.AssemblyLinearVelocity = u109 * math_clamp_ret;
        local u112 = math_clamp_ret;
        u103:DragBall(u104);
        local u113 = tick();

        if u103.PassTrove then
            u103.PassTrove:Destroy();
        end;

        if (Closest.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude >= 40 and not Attribute or Attribute then
            u103.PassTrove = Trove.new();
            u103.PassTrove:Connect(RunService.Heartbeat, function(p114) -- Line: 1071
                -- upvalues: u104 (copy), u103 (ref), u113 (copy), u111 (copy), Closest (copy), Vector3_new_ret (ref), Attribute (copy), u109 (ref), Position (ref), u105 (copy), u112 (copy), math_clamp_ret (ref), HumanoidRootPart (ref), getCurrentStyle (ref), LocalPlayer (ref)
                if u104.OnPlayer.Value then
                    if u103.PassTrove then
                        u103.PassTrove:Destroy();
                    end;

                    return;
                end;

                if tick() > u113 + u111 then
                    if u103.PassTrove then
                        u103.PassTrove:Destroy();
                    end;

                    return;
                end;

                if (Closest.HumanoidRootPart.Position - u104.Position).Magnitude < 5 then
                    u103.PassTrove:Destroy();

                    return;
                end;

                local HumanoidRootPart2 = Closest.HumanoidRootPart;
                Vector3_new_ret = Vector3.new(HumanoidRootPart2.AssemblyLinearVelocity.X, 0, HumanoidRootPart2.AssemblyLinearVelocity.Z);
                local Unit = ((HumanoidRootPart2.Position + Vector3_new_ret - u104.Position).Unit + Vector3.new(0, 0.22, 0)).Unit;

                if Attribute and tick() > u113 + 0.075 then
                    local v115 = tick() - u113 > 0.075;
                    u109 = u109:Lerp((Position - u104.Position).Unit + Vector3.new(0, v115 and 0.15 or 0.45, 0), 6.5 * p114);
                elseif Attribute then
                    Position = HumanoidRootPart2.Position;
                else
                    if u105 and u105.Stats.HomingPass then
                        local v116 = u105 and u105.Stats.HomingPass or 3.5;
                        local HumanoidRootPart3 = Closest.HumanoidRootPart;
                        local Vector3_new_ret2 = Vector3.new(HumanoidRootPart3.AssemblyLinearVelocity.X, 0, HumanoidRootPart3.AssemblyLinearVelocity.Z);
                        local Position2 = u104.Position;
                        local math_min_ret = math.min(u104.AssemblyLinearVelocity.Magnitude, u112);
                        local math_clamp_ret2 = math.clamp((HumanoidRootPart3.Position - Position2).Magnitude / math_min_ret, 0, 0.35);
                        u109 = u109:Lerp(((HumanoidRootPart3.Position + Vector3_new_ret2 * math_clamp_ret2 - Position2).Unit + Vector3.new(0, 0.12, 0)).Unit, 1 - math.exp(-v116 * p114));
                        u104.AssemblyLinearVelocity = u109 * math_min_ret;

                        return;
                    end;

                    u109 = u109:Lerp(Unit, (math.clamp(1.5 * p114, 0, 1)));
                end;

                math_clamp_ret = (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5;
                math_clamp_ret = math.clamp(math_clamp_ret, 0, 120);

                if getCurrentStyle() == "Reo" and not LocalPlayer.Character:GetAttribute("StrikeMode") then
                    math_clamp_ret = math_clamp_ret * 1.2;
                end;

                if LocalPlayer.PlayerStats.InFlow.Value and LocalPlayer.PlayerStats.Flow.Value == "Master Of All Trades" then
                    math_clamp_ret = math_clamp_ret * 1.25;
                end;

                u104.AssemblyLinearVelocity = u104.AssemblyLinearVelocity:Lerp(u109 * math_clamp_ret, 1);
            end);
        end;
    end);
    u103.BaseTrove:Connect(u103.BallService.Shoot, function(u117, p118, p119) -- Line: 1136
        -- upvalues: u103 (copy), Players (ref), u7 (ref), HumanoidRootPart (ref), u8 (ref), workspace_CurrentCamera (ref), Humanoid (ref), getCurrentStyle (ref), LocalPlayer (ref), ReplicatedStorage (ref), getActiveFlowStats (ref), FindCurveDirection (ref), u3 (ref), RunService (ref)
        if u103.CS then
            u103.CS:Disconnect();
        end;

        local v120 = p119 == nil and 0.3 or p119;

        if not u117 then
            return;
        end;

        if u117:FindFirstChild("Before") then
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(u117.Before.Value);

            if PlayerFromCharacter then
                if PlayerFromCharacter.PlayerStats.InAwakening.Value and PlayerFromCharacter.PlayerStats.Style.Value == "Hiori" then
                    p118 = p118 * 1.2;
                end;

                if PlayerFromCharacter.PlayerStats.InFlow.Value and PlayerFromCharacter.PlayerStats.Flow.Value == "Magician Flow" then
                    p118 = p118 * 1.15;
                end;
            end;
        end;

        local v121 = p118 * u103.StatesController.ShotPowerMultiplier;

        if u7 then
            u117.AssemblyLinearVelocity = (HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.5, 0)) * v121;
        elseif u8 then
            u117.AssemblyLinearVelocity = Vector3.new(-HumanoidRootPart.CFrame.LookVector.X, HumanoidRootPart.CFrame.LookVector.Y + 0.25, -HumanoidRootPart.CFrame.LookVector.Z) * 120;
        else
            local LookVector = workspace_CurrentCamera.CFrame.LookVector;

            if workspace_CurrentCamera.CFrame.LookVector.Y < -0.05 then
                if workspace_CurrentCamera.CFrame.LookVector.Y <= -0.5 then
                    u103.BallService.HasShot:Fire(true);
                else
                    u103.BallService.HasShot:Fire(false);
                end;

                LookVector = Vector3.new(LookVector.X, -0.05, LookVector.Z);
            else
                u103.BallService.HasShot:Fire(false);
            end;

            if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                if HumanoidRootPart.Anchored and getCurrentStyle() == "Shidou" then
                    return;
                end;

                if u103.StatesController.States.Ability == false then
                    u103.Animations.Movement.Header.Priority = Enum.AnimationPriority.Action3;
                    u103.Animations.Movement.Header:Play();

                    if LocalPlayer.PlayerStats.InFlow.Value and LocalPlayer.PlayerStats.Flow.Value == "Demon Wings" then
                        u117.AssemblyLinearVelocity = (LookVector + Vector3.new(0, v120, 0)) * v121 * 1.2;
                    else
                        u117.AssemblyLinearVelocity = (LookVector + Vector3.new(0, v120, 0)) * v121;
                    end;
                else
                    if getCurrentStyle() == "Gagamaru" then
                        ReplicatedStorage.VfxSpawn:FireServer("Gagamaru header");
                    elseif getCurrentStyle() == "Shidou" then
                        ReplicatedStorage.VfxSpawn:FireServer("ShidouHeader");
                    end;

                    local v122 = LocalPlayer.PlayerStats.InFlow.Value and LocalPlayer.PlayerStats.Flow.Value == "Demon Wings" and 1.4 or 1.2;
                    u117.AssemblyLinearVelocity = (LookVector + Vector3.new(0, v120, 0)) * v121 * v122;
                end;
            else
                local v123 = nil;
                local v124 = 2;
                local v125 = 1;
                local _, v126 = getActiveFlowStats(LocalPlayer);

                if v126 then
                    v126 = v126.Stats;
                end;

                if v126 and v126.ShotCurveDivisor then
                    v123 = v126.ShotCurveDivisor;
                    v124 = v126.ShotCurveLaunchDivisor or 2;
                    v125 = v126.ShotSpeedMultiplier or 1;
                elseif getCurrentStyle() == "NEL Rin" and LocalPlayer.PlayerStats.InAwakening.Value then
                    v123 = 3.5;
                end;

                if v123 then
                    local u127 = FindCurveDirection(LocalPlayer);
                    local u128 = -(u3 / v123);
                    u117.AssemblyLinearVelocity = (LookVector + Vector3.new(0, v120, 0) + u127 / v124) * v121 * v125;
                    u103.CS = RunService.Heartbeat:Connect(function(p129) -- Line: 1224
                        -- upvalues: ReplicatedStorage (ref), u103 (ref), u128 (ref), u3 (ref), u117 (copy), u127 (copy)
                        if ReplicatedStorage.Football.Value.OnPlayer.Value then
                            u103.CS:Disconnect();
                        end;

                        u128 = u128 + u3 / 6 * p129;

                        if u128 >= -(u3 / 8) then
                            u103.CS:Disconnect();
                        end;

                        u117.AssemblyLinearVelocity = u117.AssemblyLinearVelocity:Lerp(u117.AssemblyLinearVelocity + u127 * u128, 6.5 * p129);
                    end);
                else
                    u117.AssemblyLinearVelocity = (LookVector + Vector3.new(0, v120, 0)) * v121;
                end;
            end;
        end;

        u7 = false;
        u8 = false;
        u103:DragBall(u117);
    end);
    u103.BaseTrove:Connect(u103.BallService.Prediction, function(p130, p131) -- Line: 1245
        -- upvalues: u103 (copy)
        u103:Predict(p130, p131);
    end);

    local function setupClientBall(u132) -- Line: 1248
        -- upvalues: Players (ref), PlrStyles (ref), script_BalancingVisualiser (ref), ReplicatedStorage (ref), Raycast (ref), SoundManager (ref), VfxManager (ref), Debris (ref)
        if not u132 then
            return;
        end;

        local u133 = 0;
        local u134 = false;
        local u135 = false;
        local Char = u132:WaitForChild("Char", 20);

        if Char then
            Char.Changed:Connect(function(p136) -- Line: 1259
                -- upvalues: Players (ref), u132 (copy), PlrStyles (ref)
                local PlayerFromCharacter = Players:GetPlayerFromCharacter(p136);

                if PlayerFromCharacter then
                    u132.Trail.Color = ColorSequence.new(PlrStyles[PlayerFromCharacter.PlayerStats.Style.Value].BallColor);
                end;
            end);
        end;

        script_BalancingVisualiser.trackBall(u132);
        ReplicatedStorage.Football.Value.BallAnims.BALL.Touched:Connect(function(p137: userdata) -- Line: 1271
            -- upvalues: u132 (copy), u135 (ref), Raycast (ref), ReplicatedStorage (ref), SoundManager (ref), u133 (ref), VfxManager (ref), Debris (ref), u134 (ref)
            if u132.OnPlayer.Value or (u132.AssemblyLinearVelocity.Magnitude <= 10 or (p137.Name == "Hitbox" or (p137:IsDescendantOf(u132) or p137.Parent:FindFirstChild("Humanoid")))) then
                return;
            end;

            if p137.Name ~= "Field" and p137.Parent.Name ~= "Field" then
                if p137:HasTag("WallBounce") then
                    if u134 then
                        return;
                    end;

                    local v138 = Raycast.Cast(u132.Position, -u132.AssemblyLinearVelocity.Unit * 15, { u132, workspace.Debris }, false, true);

                    if not v138 then
                        return;
                    end;

                    u134 = true;
                    task.delay(1, function() -- Line: 1307
                        -- upvalues: u134 (ref)
                        u134 = false;
                    end);
                    local v139 = ReplicatedStorage.Assets.Vfx.BarrierHit:Clone();
                    v139.CFrame = CFrame.new(v138.Position, v138.Position + v138.Normal);
                    v139.Parent = workspace.Debris;
                    VfxManager.Emit(v139);
                    Debris:AddItem(v139, 4);
                    local v140 = SoundManager.SpawnSound("BallsHitTheWall", 0.65, v139, 70);
                    v140.RollOffMaxDistance = 80;
                    v140.RollOffMode = Enum.RollOffMode.InverseTapered;
                    u133 = u133 + 1;
                    task.delay(1, function() -- Line: 1322
                        -- upvalues: u133 (ref)
                        u133 = u133 - 1;
                    end);
                end;

                return;
            end;

            if math.abs(u132.AssemblyLinearVelocity.Y) <= 8 or u135 then
                return;
            end;

            local v141 = Raycast.Cast(u132.Position, Vector3.new(0, -15, 0), { u132, workspace.Debris }, false, true);

            if not v141 then
                return;
            end;

            u135 = true;
            task.delay(0.5, function() -- Line: 1285
                -- upvalues: u135 (ref)
                u135 = false;
            end);
            local v142 = ReplicatedStorage.Assets.Vfx.FloorHit:Clone();
            v142.Position = v141.Position + Vector3.new(0, 1, 0);
            v142.Parent = workspace.Debris;
            SoundManager.SpawnSound("GrassLand", 1, u132, 70).PlaybackSpeed = u133 * 0.2 + 1;
            u133 = u133 + 1;
            VfxManager.Emit(v142);
            Debris:AddItem(v142, 1);
            task.delay(1, function() -- Line: 1298
                -- upvalues: u133 (ref)
                u133 = u133 - 1;
            end);
        end);
    end;

    setupClientBall(ReplicatedStorage.Football.Value);
    ReplicatedStorage.Football.Changed:Connect(setupClientBall);
    u103.BaseTrove:Connect(LocalPlayer.PlayerStats.InFlow:GetPropertyChangedSignal("Value"), function() -- Line: 1331
        -- upvalues: getCurrentStyle (ref), LocalPlayer (ref), u5 (ref), u4 (ref), getActiveFlowStats (ref)
        if getCurrentStyle() == "Reo" and not LocalPlayer.Character:GetAttribute("StrikeMode") then
            u5 = 2;
        end;

        if getCurrentStyle() == "Reo" and LocalPlayer.Character:GetAttribute("StrikeMode") then
            u4 = 2;
        end;

        if not LocalPlayer.PlayerStats.InFlow.Value then
            return;
        end;

        local _, v143 = getActiveFlowStats(LocalPlayer);

        if v143 and v143.Stats.ExtraDribbles then
            u4 = u4 + v143.Stats.ExtraDribbles;
        end;

        if (LocalPlayer.PlayerStats.Flow.Value == "Singularity" or (LocalPlayer.PlayerStats.Flow.Value == "Awakened Genius" or LocalPlayer.PlayerStats.Flow.Value == "Master Of All Trades")) and LocalPlayer.PlayerStats.InFlow.Value then
            u4 = 2;

            return;
        end;

        if LocalPlayer.PlayerStats.Flow.Value == "Bee Freestyle" and LocalPlayer.PlayerStats.InFlow.Value then
            u4 = 3;
        end;
    end);
    local u144 = tick();
    local u145 = false;
    local u146 = tick();
    u103.NewTrove:Connect(RunService.Heartbeat, function() -- Line: 1363
        -- upvalues: u146 (ref), u2 (ref), HumanoidRootPart (ref), ReplicatedStorage (ref), u144 (ref), LocalPlayer (ref), u145 (ref), u103 (copy)
        if u146 > tick() then
            return;
        end;

        u146 = tick() + 0.2;

        if u2 == nil then
            return;
        end;

        if HumanoidRootPart == nil then
            return;
        end;

        if not ReplicatedStorage.Football.Value:FindFirstChild("Char") then
            return;
        end;

        if u2.Values.Goalie.Value then
            return;
        end;

        if ReplicatedStorage.Football.Value.Char.Value ~= u2 or u2.Values.IsInSmallBox.Value == false then
            u144 = tick();
        end;

        if not u2:FindFirstChild("Values") then
            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if u2.Values.InCutscene.Value then
            u144 = tick();

            return;
        end;

        if u144 + 10 < tick() then
            if u2.Values.HasBall.Value and not u145 then
                u144 = tick();
                u145 = true;
                u103.BallService.ResetToMid:Fire();
            end;
        else
            u145 = false;
        end;
    end);

    local function destroyBallSkin(p147) -- Line: 1390
        if not p147 then
            return;
        end;

        local v148 = p147:FindFirstChild("BallAnims", true) and p147.BallAnims:FindFirstChild("BALL", true);

        if not v148 then
            return;
        end;

        local BallSkinBall = v148:FindFirstChild("BallSkinBall");

        if BallSkinBall then
            BallSkinBall:Destroy();
        end;

        local Highlight = p147:FindFirstChild("Highlight");

        if Highlight then
            if v148.Transparency == 1 then
                Highlight.Adornee = p147;

                return;
            end;

            Highlight.Adornee = v148;
        end;
    end;

    local function createBallSkin(p149, p150) -- Line: 1415
        -- upvalues: destroyBallSkin (copy), ReplicatedStorage (ref)
        if not (p149 and p150) then
            return;
        end;

        local v151 = p150:FindFirstChild("BallAnims", true) and p150.BallAnims:FindFirstChild("BALL", true);

        if not v151 then
            return;
        end;

        destroyBallSkin(p150);
        local Attribute = p149:GetAttribute("EquippedBallSkin");
        local v152;

        if Attribute and Attribute ~= "" then
            local v153 = ReplicatedStorage.Assets.Customization.BallSkins:FindFirstChild(Attribute);

            if v153 and v153:IsA("BasePart") then
                v152 = v153:Clone();
                v152.Name = "BallSkinBall";
            else
                v152 = ReplicatedStorage.Assets.Customization.Misc.BallSkinBall:Clone();

                if v153 then
                    v153:Clone().Parent = v152;
                end;
            end;

            v152.Parent = v151;
            v152.CFrame = v151.CFrame;
            local Weld = Instance.new("Weld");
            Weld.C0 = CFrame.new();
            Weld.Part0 = v151;
            Weld.Part1 = v152;
            Weld.Parent = v152;
            local v154 = ReplicatedStorage.Assets.Customization.BallSkinsVFX:FindFirstChild(Attribute);

            if v154 then
                for _, child in ipairs(v154:GetChildren()) do
                    child:Clone().Parent = v152;
                end;
            end;
        else
            v152 = v151;
        end;

        local Highlight = p150:FindFirstChild("Highlight");

        if Highlight then
            if v152.Transparency == 1 then
                Highlight.Adornee = p150;

                return;
            end;

            Highlight.Adornee = v152;
        end;
    end;

    local function updatePlayerPersonalBallSkin(p155) -- Line: 1476
        -- upvalues: createBallSkin (copy), destroyBallSkin (copy)
        if not (p155 and p155.Character) then
            return;
        end;

        local PlrFootball = p155.Character:FindFirstChild("PlrFootball");

        if not PlrFootball then
            return;
        end;

        local v156 = p155.Character:FindFirstChild("Values") and p155.Character.Values.HasBall;

        if v156 and v156.Value then
            createBallSkin(p155, PlrFootball);

            return;
        end;

        destroyBallSkin(PlrFootball);
    end;

    local u157 = {};

    local function setupPlayerListeners(u158) -- Line: 1495
        -- upvalues: u157 (copy), Trove (ref), updatePlayerPersonalBallSkin (copy)
        if u157[u158] then
            u157[u158]:Destroy();
        end;

        local u159 = Trove.new();
        u157[u158] = u159;

        local function onCharacterAdded(p160) -- Line: 1503
            -- upvalues: u159 (copy), updatePlayerPersonalBallSkin (ref), u158 (copy)
            u159:Connect(p160:WaitForChild("Values"):WaitForChild("HasBall"):GetPropertyChangedSignal("Value"), function() -- Line: 1507
                -- upvalues: updatePlayerPersonalBallSkin (ref), u158 (ref)
                updatePlayerPersonalBallSkin(u158);
            end);
            u159:Connect(p160.ChildAdded, function(p161) -- Line: 1511
                -- upvalues: updatePlayerPersonalBallSkin (ref), u158 (ref)
                if p161.Name == "PlrFootball" then
                    updatePlayerPersonalBallSkin(u158);
                end;
            end);

            if p160:FindFirstChild("PlrFootball") then
                updatePlayerPersonalBallSkin(u158);
            end;
        end;

        u159:Connect(u158:GetAttributeChangedSignal("EquippedBallSkin"), function() -- Line: 1522
            -- upvalues: updatePlayerPersonalBallSkin (ref), u158 (copy)
            updatePlayerPersonalBallSkin(u158);
        end);

        if u158.Character then
            onCharacterAdded(u158.Character);
        end;

        u159:Connect(u158.CharacterAdded, onCharacterAdded);
    end;

    local u162 = Trove.new();

    local function setupMainBallListeners() -- Line: 1533
        -- upvalues: u162 (ref), Trove (ref), ReplicatedStorage (ref), destroyBallSkin (copy), Players (ref), createBallSkin (copy)
        u162:Destroy();
        u162 = Trove.new();
        local Value = ReplicatedStorage.Football.Value;

        if not Value then
            return;
        end;

        local Char = Value:FindFirstChild("Char");

        if not Char then
            return;
        end;

        local u163 = nil;
        local u164 = nil;

        local function updateMainBallSkin() -- Line: 1546
            -- upvalues: u163 (ref), u164 (ref), destroyBallSkin (ref), Value (copy), Char (copy), Players (ref), updateMainBallSkin (copy), u162 (ref), createBallSkin (ref)
            if u163 then
                u163:Disconnect();
                u163 = nil;
            end;

            if u164 then
                u164:Disconnect();
                u164 = nil;
            end;

            destroyBallSkin(Value);
            local Value2 = Char.Value;

            if not (Value2 and Value2.Parent) then
                return;
            end;

            local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value2);

            if not PlayerFromCharacter then
                return;
            end;

            local Values = Value2:FindFirstChild("Values");

            if not Values then
                return;
            end;

            local HasBall = Values:FindFirstChild("HasBall");

            if HasBall then
                u164 = HasBall:GetPropertyChangedSignal("Value"):Connect(updateMainBallSkin);
                u162:Add(u164);
            end;

            if HasBall.Value then
                return;
            end;

            createBallSkin(PlayerFromCharacter, Value);
            u163 = PlayerFromCharacter:GetAttributeChangedSignal("EquippedBallSkin"):Connect(updateMainBallSkin);
            u162:Add(u163);
        end;

        u162:Connect(Char:GetPropertyChangedSignal("Value"), updateMainBallSkin);
        updateMainBallSkin();
    end;

    setupMainBallListeners();
    ReplicatedStorage.Football:GetPropertyChangedSignal("Value"):Connect(setupMainBallListeners);

    for _, v in ipairs(Players:GetPlayers()) do
        setupPlayerListeners(v);
    end;

    u103.BaseTrove:Connect(Players.PlayerAdded, setupPlayerListeners);
    u103.BaseTrove:Connect(Players.PlayerRemoving, function(p165) -- Line: 1602
        -- upvalues: u157 (copy)
        if u157[p165] then
            u157[p165]:Destroy();
            u157[p165] = nil;
        end;
    end);
    u103.BaseTrove:Connect(RunService.Heartbeat, function(p166) -- Line: 1609
        -- upvalues: u2 (ref), LocalPlayer (ref), u103 (copy), Players (ref), GuiService (ref), Essentials (ref)
        if not (u2 and (u2.Parent and u2:FindFirstChild("Values"))) then
            return;
        end;

        if not LocalPlayer.PlayerGui.Mobile:GetAttribute("HUDEditing") then
            if u2:FindFirstChild("Football") then
                LocalPlayer.PlayerGui.Mobile.NoBall.Visible = false;
                LocalPlayer.PlayerGui.Mobile.Ball.Visible = true;
            else
                LocalPlayer.PlayerGui.Mobile.NoBall.Visible = true;
                LocalPlayer.PlayerGui.Mobile.Ball.Visible = false;
            end;
        end;

        if u2.Values.HasBall.Value == false then
            if u103.Closest ~= nil then
                if u103.Closest:FindFirstChild("Highlight") then
                    u103.Closest:FindFirstChild("Highlight"):Destroy();
                end;

                u103.Closest = nil;
            end;

            return;
        end;

        if u2.IsRagdoll.Value then
            return;
        end;

        local Players2 = Players:GetPlayers();
        local v167 = {};

        for _, v in pairs(Players2) do
            if v.Character ~= nil and (v.Team == LocalPlayer.Team and v ~= LocalPlayer) then
                table.insert(v167, v.Character);
            end;
        end;

        if workspace:FindFirstChild("PassRig") then
            table.insert(v167, workspace:FindFirstChild("PassRig"));
        end;

        local v168 = nil;
        local v169 = 9999;

        for _, v in pairs(v167) do
            if v.HumanoidRootPart ~= nil then
                local v170, v171 = workspace.CurrentCamera:WorldToScreenPoint(v.HumanoidRootPart.Position);

                if v171 then
                    local Magnitude = (Vector2.new(v170.X, v170.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2 - GuiService:GetGuiInset().Y / 2)).Magnitude;

                    if v168 == nil then
                        v169 = Magnitude;
                        v168 = v;
                    elseif Magnitude < v169 then
                        v169 = Magnitude;
                        v168 = v;
                    end;
                end;
            end;
        end;

        if u103.Closest ~= nil then
            if u103.Closest:FindFirstChild("Highlight") == nil then
                local v172 = Essentials:Highlight(u103.Closest);
                v172.Parent = u103.Closest;
                v172.OutlineTransparency = 0.5;
                v172.FillTransparency = 0.5;
            end;

            if u103.Closest ~= v168 and u103.Closest:FindFirstChild("Highlight") then
                u103.Closest:FindFirstChild("Highlight"):Destroy();
            end;
        end;

        u103.Closest = v168;
    end);
    u103:CheckInput();
end;

function u12.ObserveBall(p173: table, p174: function) -- Line: 1698
    -- upvalues: Observers (copy), ReplicatedStorage (copy)
    return Observers.observeProperty(ReplicatedStorage.Football, "Value", p174);
end;

function u12.KnitInit(u175) -- Line: 1702
    -- upvalues: u1 (ref), KnitClient (copy), Trove (copy), u3 (ref), LocalPlayer (copy), HumanoidRootPart (ref), u2 (ref), Humanoid (ref), workspace_CurrentCamera (copy), u7 (ref)
    u1 = KnitClient.GetController("AbilityController");
    u175.BaseTrove = Trove.new();
    u175.NewTrove = Trove.new();
    u3 = 50;
    u175.HoldingShoot = false;
    LocalPlayer.PlayerGui.ForceBar.Adornee = HumanoidRootPart;
    HumanoidRootPart:WaitForChild("Running").Volume = 0;
    u175.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p176) -- Line: 1715
        -- upvalues: u2 (ref), Humanoid (ref), HumanoidRootPart (ref), LocalPlayer (ref), workspace_CurrentCamera (ref), u7 (ref), u175 (copy)
        u2 = p176;
        Humanoid = u2:WaitForChild("Humanoid");
        HumanoidRootPart = u2:WaitForChild("HumanoidRootPart");
        LocalPlayer.PlayerGui.ForceBar.Adornee = HumanoidRootPart;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera.CameraSubject = Humanoid;
        u7 = false;
        u175:ResetChecks();
        HumanoidRootPart:WaitForChild("Running").Volume = 0;
    end);
    u175.BaseTrove:Connect(game.Players.PlayerRemoving, function(p177) -- Line: 1732
        -- upvalues: LocalPlayer (ref), u2 (ref), HumanoidRootPart (ref), Humanoid (ref), u175 (copy)
        if p177 == LocalPlayer then
            u2 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u175.BaseTrove:Destroy();
        end;
    end);
    u175:ResetChecks();
end;

return KnitClient.CreateController(u12);