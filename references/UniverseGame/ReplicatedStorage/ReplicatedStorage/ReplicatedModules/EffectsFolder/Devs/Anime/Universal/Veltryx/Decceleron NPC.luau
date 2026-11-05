  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };

return function(p2) -- Line: 24
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), PathShortcuts (copy), TweenService (copy), EffectsHandler (copy), ParticleHandler (copy)
    local v3 = p2 or {};
    local Model = v3.Model;
    local Acceleron = v3.Acceleron;
    local IsChase = v3.IsChase;
    local HumanoidRootPart = Model.HumanoidRootPart;
    local u4 = {
        Idle = 13390661748,
        Walk = 17820902887,
        Run = 11765603339,
        Attack = 14324703321
    };

    if not IsChase then
        u4.Stunned = 10046328617;
    end;

    for i, v in u4 do
        local v5 = i == "Stunned" and Acceleron and Acceleron or Model;
        local Animation = Instance.new("Animation");
        Animation.Name = i;
        Animation.AnimationId = "rbxassetid://" .. v;
        Animation.Parent = v5;
        local v6 = v5.Humanoid.Animator:LoadAnimation(Animation);

        if i == "Stunned" then
            v6.Priority = Enum.AnimationPriority.Action4;
        end;

        u4[i] = v6;
    end;

    if not IsChase then
        local DecceleronWaypoints = Acceleron.DecceleronWaypoints;
        Model:PivotTo(DecceleronWaypoints.Start.CFrame);
        u4.Idle:Play();
        u4.Walk:Play();
        EffectsHandler.CallEffect("A-Train Afterimages", Model, true);
        local u7 = TweenService:Create(HumanoidRootPart, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
            CFrame = DecceleronWaypoints.Appear.CFrame
        });
        u7:Play();
        task.delay(1.5, function() -- Line: 141
            -- upvalues: u4 (copy), EffectsHandler (ref), Model (copy)
            u4.Walk:Stop(0.2);
            EffectsHandler.CallEffect("A-Train Afterimages", Model, false, 0);
        end);
        Model:GetAttributeChangedSignal("Stage"):Connect(function() -- Line: 146
            -- upvalues: Model (copy), u4 (copy), u7 (ref), HumanoidRootPart (copy), DecceleronWaypoints (copy), TweenService (ref), Acceleron (copy), EffectsHandler (ref), ParticleHandler (ref), LocalPlayer (ref)
            local v8 = Model:GetAttribute("Stage");

            if v8 == "FirstTurn" then
                u4.Walk:Stop();

                if u7.PlaybackState == Enum.PlaybackState.Playing then
                    u7:Pause();
                end;

                HumanoidRootPart.CFrame = DecceleronWaypoints.Appear.CFrame;
                u7 = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                    CFrame = DecceleronWaypoints.FirstLookAt.CFrame
                });
                u7:Play();
                TweenService:Create(Acceleron.HumanoidRootPart, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                    CFrame = CFrame.new(Acceleron.HumanoidRootPart.Position, HumanoidRootPart.Position)
                }):Play();

                return;
            end;

            if v8 ~= "Attack" then
                if v8 == "Runaway" then
                    u4.Attack:Stop();
                    u4.Run:Play();

                    if u7.PlaybackState == Enum.PlaybackState.Playing then
                        u7:Pause();
                    end;

                    HumanoidRootPart.CFrame = CFrame.new(DecceleronWaypoints.Attack.Position, DecceleronWaypoints.Runaway.Position);
                    Model.RunTrail.Enabled = true;
                    u7 = TweenService:Create(HumanoidRootPart, TweenInfo.new(1.2, Enum.EasingStyle.Linear), {
                        CFrame = DecceleronWaypoints.Runaway.CFrame
                    });
                    u7:Play();
                    task.delay(0.85, function() -- Line: 223
                        -- upvalues: ParticleHandler (ref), Model (ref), EffectsHandler (ref)
                        ParticleHandler.EnableAllParticles(Model);
                        EffectsHandler.CallEffect("SK_VANISH", {
                            Transparency = 1,
                            Character = Model,
                            TweenInfo = { 0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut }
                        });
                    end);
                    TweenService:Create(Acceleron.HumanoidRootPart, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                        CFrame = CFrame.new(Acceleron.HumanoidRootPart.Position, LocalPlayer.Character.HumanoidRootPart.Position)
                    }):Play();
                end;

                return;
            end;

            u4.Attack:Play();
            u4.Stunned:Play();
            task.delay(2, function() -- Line: 170
                -- upvalues: u4 (ref)
                u4.Stunned:AdjustSpeed(0.001);
            end);

            if u7.PlaybackState == Enum.PlaybackState.Playing then
                u7:Pause();
            end;

            HumanoidRootPart.CFrame = DecceleronWaypoints.FirstLookAt.CFrame;
            EffectsHandler.CallEffect("Veltryx Electric Lunge", {
                Character = Model,
                Origin = HumanoidRootPart.CFrame,
                End = CFrame.new(DecceleronWaypoints.Attack.Position, DecceleronWaypoints.Attack.Position + HumanoidRootPart.CFrame.LookVector),
                HSVData = {
                    HueShift = 355
                }
            });
            local v9 = DecceleronWaypoints.Attack.Position - HumanoidRootPart.Position;
            EffectsHandler.CallEffect("Rock Trail", {
                Offset = 6,
                Size = 2,
                Duration = 1,
                DurationOffset = 0.1,
                Down = true,
                Origin = HumanoidRootPart.CFrame,
                LookVector = v9.Unit,
                Distance = v9.Magnitude,
                Amount = math.ceil(v9.Magnitude / 2.35)
            });
            u7 = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                CFrame = DecceleronWaypoints.Attack.CFrame
            });
            u7:Play();
        end);

        return;
    end;

    u4.Run:Play();
    local v10 = v3.Speed or 150;
    Model.RunTrail.Lifetime = 2.5;
    local v11 = ReplicatedStorage["Client Assets"].ItemNotifier.BillboardGui:Clone();
    local Label = v11.Frame.Label;
    Label.TextColor3 = Color3.new(0.701961, 0.0313725, 0.0313725);
    Label.TextStrokeColor3 = Color3.new(0.309804, 0.0117647, 0.0117647);
    Label.TextStrokeTransparency = 0.5;
    v11.Adornee = Model.Head;
    v11.Parent = Model.Head;
    task.spawn(function() -- Line: 76
        -- upvalues: Model (copy), LocalPlayer (ref), Label (copy)
        while Model:IsDescendantOf(game) do
            Label.Text = `Decceleron: {math.floor((Model.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)}m`;
            task.wait();
        end;
    end);
    local WayPoints = v3.WayPoints;
    Model:PivotTo(WayPoints[1].Origin);
    Model.RunTrail.Enabled = true;

    for i = 2, #WayPoints do
        local v12 = WayPoints[i];

        if v12.Shortcut then
            task.spawn(function() -- Line: 95
                -- upvalues: PathShortcuts (ref)
                PathShortcuts.RemotesPath:WaitForChild("ClientUIOutput"):Fire("ShowSelfNotification", "Quick! He went up a wall. Find a shortcut quickly!", 3, UDim2.fromScale(0.5, 0.32));
            end);
        end;

        local Position = WayPoints[i - 1].Origin.Position;
        local Position2 = v12.Origin.Position;
        local Magnitude = (Position2 - Position).Magnitude;
        local v13 = CFrame.new(Position2, Position2 + (Position2 - Position).Unit);
        local v14 = TweenService:Create(HumanoidRootPart, TweenInfo.new(Magnitude / v10, Enum.EasingStyle.Linear), {
            CFrame = v13
        });
        v14:Play();
        v14.Completed:Wait();
    end;

    u4.Run:Stop(0.2);
end;