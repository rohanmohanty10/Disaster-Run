  

local Teams = game:GetService("Teams");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("PathfindingService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.Popup);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local AdvanceUbersRules = require(ReplicatedStorage2.Shared.AdvanceUbersRules);
local getActiveFlowStats = require(ReplicatedStorage2.Shared.utils.getActiveFlowStats);
local Signal = require(ReplicatedStorage2.Packages.Signal);
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local u2 = {
    Running = false,
    StandingUp = false,
    Bicycle = false,
    Ability = false,
    CalculatedSpeedBonus = 0
};
local u3 = {
    OnShoot = Signal.new(),
    OnAbilityUsed = Signal.new(),
    OnSlide = Signal.new(),
    OnJump = Signal.new(),
    OnRagdolled = Signal.new(),
    OnDribble = Signal.new(),
    PreUpdate = Signal.new(),
    PostUpdate = Signal.new(),
    CustomEvent = Signal.new(),
    RoundStarted = Signal.new(),
    StyleChanged = Signal.new()
};
local u6 = {
    Name = "StatesController",
    CharacterEvents = u3,
    States = nil,

    IsAwakened = function(p4) -- Line: 54, Name: IsAwakened
        -- upvalues: LocalPlayer (copy)
        return LocalPlayer.PlayerStats.InAwakening.Value;
    end,

    RespawnChecks = function(u5) -- Line: 58, Name: RespawnChecks
        -- upvalues: Trove (copy), u1 (ref), u3 (copy)
        if u5.NewTrove then
            u5.NewTrove:Destroy();
        end;

        u5.NewTrove = Trove.new();
        u5.NewTrove:Connect(u1:WaitForChild("IsRagdoll"):GetPropertyChangedSignal("Value"), function() -- Line: 62
            -- upvalues: u1 (ref), u5 (copy), u3 (ref)
            if u1.IsRagdoll.Value ~= false then
                u3.OnRagdolled:Fire();

                return;
            end;

            u5.States.StandingUp = true;
            u5.Animations:StopAnims();
            u5.Animations.Movement.StandUp.Priority = Enum.AnimationPriority.Action4;
            u5.Animations.Movement.StandUp:Play();
            task.delay(0.65, function() -- Line: 70
                -- upvalues: u5 (ref)
                u5.States.StandingUp = false;
            end);
        end);
    end
};

function u6.KnitStart(u7) -- Line: 79
    -- upvalues: KnitClient (copy), Trove (copy), LocalPlayer (copy), u3 (copy), RunService (copy), u1 (ref), HumanoidRootPart (ref), u6 (copy), Humanoid (ref), ReplicatedStorage (copy), SoundManager (copy), VfxManager (copy), ReplicatedStorage2 (copy), getActiveFlowStats (copy), AdvanceUbersRules (copy)
    u7.Camera = KnitClient.GetController("CameraController");
    u7.Spectator = KnitClient.GetController("SpectatorController");
    u7.AbilityService = KnitClient.GetService("AbilityService");
    u7.BaseTrove = Trove.new();
    local u8 = {
        ["true"] = 30,
        ["false"] = 33
    };
    local u9 = {
        ["true"] = 20,
        ["false"] = 23
    };
    u7.SpeedBoost = 0;
    u7.SpeedBoost2 = 0;
    u7.SpeedMultiplier = 1;
    u7.OwnWalkState = false;
    u7.BaseTrove:Connect(u7.AbilityService.StateChange, function(p10, p11) -- Line: 101
        -- upvalues: u7 (copy)
        u7.States[p10] = p11;
    end);
    u7.BaseTrove:Connect(u7.AbilityService.ChangeSpeed, function(u12, p13) -- Line: 105
        -- upvalues: u7 (copy)
        local v14 = u7;
        v14.SpeedBoost2 = v14.SpeedBoost2 + u12;

        if p13 then
            task.delay(p13, function() -- Line: 108
                -- upvalues: u7 (ref), u12 (copy)
                local v15 = u7;
                v15.SpeedBoost2 = v15.SpeedBoost2 - u12;
            end);
        end;
    end);
    local u16 = nil;
    local u17 = nil;
    local u18 = false;
    task.spawn(function() -- Line: 119
        -- upvalues: LocalPlayer (ref), u3 (ref)
        LocalPlayer:WaitForChild("PlayerStats"):WaitForChild("Style").Changed:Connect(function(p19) -- Line: 121
            -- upvalues: u3 (ref)
            u3.StyleChanged:Fire(p19);
        end);
    end);
    u7.BaseTrove:Connect(RunService.Heartbeat, function(p20) -- Line: 126
        -- upvalues: u1 (ref), HumanoidRootPart (ref), u7 (copy), LocalPlayer (ref), u6 (ref), Humanoid (ref), u18 (ref), ReplicatedStorage (ref), u16 (ref), SoundManager (ref), VfxManager (ref), ReplicatedStorage2 (ref), u17 (ref), getActiveFlowStats (ref), u8 (copy), u9 (copy), AdvanceUbersRules (ref)
        if u1 == nil then
            return;
        end;

        if HumanoidRootPart == nil then
            return;
        end;

        if u7.States.Running and LocalPlayer.PlayerStats.Stamina.Value <= 0 then
            u7.States.Running = false;
        end;

        u7.States.CalculatedSpeedBonus = 0;
        u6.CharacterEvents.PreUpdate:Fire(Humanoid, p20);
        local Values = u1:FindFirstChild("Values");

        if not Values then
            return;
        end;

        local Value = Values.HasBall.Value;

        if Value then
            if not u18 then
                u18 = true;
                local Value2 = ReplicatedStorage.Football.Value;

                if Value2 then
                    Value2 = Value2:FindFirstChild("Before");
                end;

                if Value2 then
                    Value2 = game.Players:GetPlayerFromCharacter(Value2.Value);
                end;

                if LocalPlayer.PlayerStats.Flow.Value == "Singularity" and LocalPlayer.PlayerStats.InFlow.Value then
                    if Value and (Value2 and (Value2 ~= LocalPlayer and Value2.Team == LocalPlayer.Team)) then
                        u16 = workspace:GetServerTimeNow() + 1.5;
                        SoundManager.SpawnSound("TrapPassActivate", 0.5);
                        local v21 = ReplicatedStorage.Assets.Vfx.TrapPassActivate.Emit2:Clone();
                        v21.Parent = u1:FindFirstChild("HumanoidRootPart");
                        VfxManager.Emit(v21);
                        task.delay(2, v21.Destroy, v21);
                        ReplicatedStorage2.TrapBoostsActivated:FireServer();
                    end;
                elseif LocalPlayer.PlayerStats.Flow.Value == "Trap" and (LocalPlayer.PlayerStats.InFlow.Value and (Value and (Value2 and (Value2 ~= LocalPlayer and Value2.Team == LocalPlayer.Team)))) then
                    u16 = workspace:GetServerTimeNow() + 3;
                    SoundManager.SpawnSound("TrapPassActivate", 0.5);
                    local v22 = ReplicatedStorage.Assets.Vfx.TrapPassActivate.Emit2:Clone();
                    v22.Parent = u1:FindFirstChild("HumanoidRootPart");
                    VfxManager.Emit(v22);
                    task.delay(2, v22.Destroy, v22);
                end;

                if Value2 and (Value2.PlayerStats.InFlow.Value and (Value2.PlayerStats.Flow.Value == "Ice" and (Value and (Value2 ~= LocalPlayer and Value2.Team == LocalPlayer.Team)))) then
                    SoundManager.SpawnSound("TrapPassActivate", 0.5);
                    local v23 = ReplicatedStorage.Assets.Vfx.IcePassActivate.Emit2:Clone();
                    v23.Parent = u1:FindFirstChild("HumanoidRootPart");
                    VfxManager.Emit(v23);
                    task.delay(2, v23.Destroy, v23);

                    if not u7.IceFlowMulti then
                        local v24 = u7;
                        v24.SpeedMultiplier = v24.SpeedMultiplier + 0.15;
                        u7.IceFlowMulti = true;
                    end;

                    u7.IceFlowMultiExpiry = workspace:GetServerTimeNow() + 2;
                end;

                if Value2 and (Value2.PlayerStats.InFlow.Value and (Value2.PlayerStats.Flow.Value == "Magician Flow" and (Value and (Value2 ~= LocalPlayer and (Value2.Team == LocalPlayer.Team and not u7.MagicianFlowMulti))))) then
                    local v25 = u7;
                    v25.SpeedMultiplier = v25.SpeedMultiplier + 0.15;
                    u7.MagicianFlowMulti = true;
                end;
            end;

            if u7.IceFlowMulti and (u7.IceFlowMultiExpiry and workspace:GetServerTimeNow() > u7.IceFlowMultiExpiry) then
                local v26 = u7;
                v26.SpeedMultiplier = v26.SpeedMultiplier - 0.15;
                u7.IceFlowMulti = false;
                u7.IceFlowMultiExpiry = nil;
            end;
        else
            u18 = false;

            if u7.MagicianFlowMulti then
                local v27 = u7;
                v27.SpeedMultiplier = v27.SpeedMultiplier - 0.15;
                u7.MagicianFlowMulti = false;
            end;

            if u7.IceFlowMulti then
                local v28 = u7;
                v28.SpeedMultiplier = v28.SpeedMultiplier - 0.15;
                u7.IceFlowMulti = false;
                u7.IceFlowMultiExpiry = nil;
            end;
        end;

        if u16 and u16 < workspace:GetServerTimeNow() then
            u16 = nil;
        end;

        local Value2 = ReplicatedStorage.Football.Value;
        u17 = nil;
        local v29 = Value2 and (Value2:IsDescendantOf(workspace) and Value2:FindFirstChild("Before"));

        if v29 then
            u17 = game.Players:GetPlayerFromCharacter(v29.Value);
        end;

        local v30 = u7.SpeedBoost + u7.SpeedBoost2;
        u7.ShotPowerMultiplier = 1;
        Humanoid.JumpHeight = 8.15;
        local _, v31 = getActiveFlowStats(LocalPlayer);
        local v32 = v31 and v31.Stats or {};
        local v33 = Humanoid;
        v33.JumpHeight = v33.JumpHeight + (v32.JumpAddition or 0);

        if LocalPlayer:GetAttribute("MusicOverride") then
            game.SoundService.SoundGroup.OST.Volume = 0;
        elseif ReplicatedStorage.GameValues.State.Value == "Ending" or ReplicatedStorage.GameValues.State.Value == "StartingCutscene" then
            if ReplicatedStorage.GameValues.State.Value == "StartingCutscene" and (LocalPlayer.Team ~= game.Teams.Visitor or u7.Spectator.IsSpectating) then
                game.SoundService.SoundGroup.OST.Volume = 0.45;
            end;
        else
            if LocalPlayer.Team == game.Teams.Visitor and not u7.Spectator.IsSpectating then
                if ReplicatedStorage2.Assets.Sfx.BrazilMapOst.IsPlaying then
                    game.SoundService.SoundGroup.Stadium.Volume = 0;
                    game.SoundService.SoundGroup.OST.Volume = 0;
                else
                    game.SoundService.SoundGroup.Stadium.Volume = 0;
                    game.SoundService.SoundGroup.OST.Volume = 0.15;
                end;
            else
                game.SoundService.SoundGroup.OST.Volume = 0.035;

                if workspace:FindFirstChild("SoccerMap1") then
                    game.SoundService.SoundGroup.Stadium.Volume = 0.25;
                else
                    game.SoundService.SoundGroup.Stadium.Volume = 0;
                end;
            end;

            if ReplicatedStorage.GameValues.Awakened.Value then
                game.SoundService.SoundGroup.OST.Volume = 0;
            end;
        end;

        if u7.States.StandingUp or (u7.States.Bicycle or (u7.States.Ability or (u7.Camera.Cutscene or LocalPlayer.PlayerGui.PostMatch.Enabled))) then
            if u7.OwnWalkState == false then
                Humanoid.WalkSpeed = 0;
            else
                Humanoid.WalkSpeed = 25 + v30;
            end;

            Humanoid.JumpHeight = 0;
        elseif u7.States.Running then
            if LocalPlayer.PlayerStats.InFlow.Value and LocalPlayer.PlayerStats.Flow.Value == "Demon Wings" then
                Humanoid.JumpHeight = 11.3;
            elseif LocalPlayer.PlayerStats.Style.Value == "Reo" and not LocalPlayer.Character:GetAttribute("StrikeMode") then
                Humanoid.JumpHeight = 10;
            else
                Humanoid.JumpHeight = 8.15;
            end;

            if v32.SpeedAddition then
                if v32.NoBallSpeedReduction then
                    Humanoid.WalkSpeed = 33 + v32.SpeedAddition;
                else
                    Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v32.SpeedAddition;
                end;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Monster" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = 33 + v30;
            elseif u16 then
                if LocalPlayer.PlayerStats.Flow.Value == "Singularity" then
                    Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v30 + 6;
                else
                    Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v30 + 2;
                end;

                u7.ShotPowerMultiplier = 1.2;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Bee Freestyle" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = 33 + v30 + 3.8;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Puzzle" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v30 + 3;
            elseif (LocalPlayer.PlayerStats.Flow.Value == "Wild Card" or v32.WildCardRNG) and (LocalPlayer.PlayerStats.InFlow.Value and (LocalPlayer.PlayerStats.FlowRNG.Value == 3 or LocalPlayer.PlayerStats.FlowRNG.Value == 4)) then
                Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v30 + 3;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Destructive Impulses" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v30 + 3;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Emperor" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v30 + 2.5;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Buddha\'s Blessing" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v30 + 1.5;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Lightning" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v30 + 2;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Stealth" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v30;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Godspeed" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = 33 + v30 + 5;
            else
                Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v30;
            end;
        else
            if LocalPlayer.PlayerStats.InFlow.Value and LocalPlayer.PlayerStats.Flow.Value == "Demon Wings" then
                Humanoid.JumpHeight = 11.3;
            elseif LocalPlayer.PlayerStats.Style.Value == "Reo" and not LocalPlayer.Character:GetAttribute("StrikeMode") then
                Humanoid.JumpHeight = 10;
            else
                Humanoid.JumpHeight = 8.15;
            end;

            if u16 then
                Humanoid.WalkSpeed = u8[tostring(u1.Values.HasBall.Value)] + v30 + 3;
                u7.ShotPowerMultiplier = 1.3;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Monster" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = 23 + v30;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Bee Freestyle" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = 23 + v30 + 3.8;
            elseif (LocalPlayer.PlayerStats.Flow.Value == "Wild Card" or v32.WildCardRNG) and (LocalPlayer.PlayerStats.InFlow.Value and (LocalPlayer.PlayerStats.FlowRNG.Value == 3 or LocalPlayer.PlayerStats.FlowRNG.Value == 4)) then
                Humanoid.WalkSpeed = u9[tostring(u1.Values.HasBall.Value)] + v30 + 3;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Puzzle" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u9[tostring(u1.Values.HasBall.Value)] + v30 + 3;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Destructive Impulses" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u9[tostring(u1.Values.HasBall.Value)] + v30 + 3;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Emperor" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u9[tostring(u1.Values.HasBall.Value)] + v30 + 2.5;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Buddha\'s Blessing" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u9[tostring(u1.Values.HasBall.Value)] + v30 + 1.5;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Lightning" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u9[tostring(u1.Values.HasBall.Value)] + v30 + 2;
            elseif LocalPlayer.PlayerStats.Flow.Value == "Stealth" and LocalPlayer.PlayerStats.InFlow.Value then
                Humanoid.WalkSpeed = u9[tostring(u1.Values.HasBall.Value)] + v30;
            else
                Humanoid.WalkSpeed = u9[tostring(u1.Values.HasBall.Value)] + v30;
            end;
        end;

        local Attribute = u1:GetAttribute("AGReceiveBoost");

        if Attribute and workspace:GetServerTimeNow() < Attribute then
            local v34 = Humanoid;
            v34.WalkSpeed = v34.WalkSpeed + 4;
        end;

        if (LocalPlayer.PlayerStats.Flow.Value == "Dribbler" or LocalPlayer.PlayerStats.Flow.Value == "Destructive Impulses") and (LocalPlayer.PlayerStats.InFlow.Value and u1.Values.HasBall.Value) then
            local v35 = Humanoid;
            v35.WalkSpeed = v35.WalkSpeed + 4;
        end;

        if v32.BallSpeedAddition and u1.Values.HasBall.Value then
            local v36 = Humanoid;
            v36.WalkSpeed = v36.WalkSpeed + v32.BallSpeedAddition;
        end;

        if LocalPlayer.PlayerGui.Style.Enabled or (LocalPlayer.PlayerGui.Flow.Enabled or LocalPlayer.PlayerGui.Customization.Enabled) then
            Humanoid.JumpHeight = 0;
            Humanoid.WalkSpeed = 0;
        end;

        if u7.NoJump then
            Humanoid.JumpHeight = 0;
        end;

        if Humanoid.WalkSpeed > 1 then
            local v37 = Humanoid;
            v37.WalkSpeed = v37.WalkSpeed + u6.States.CalculatedSpeedBonus;
        end;

        local v38 = (u1:GetScale() - 1) * 0.1;
        local v39 = Humanoid;
        v39.WalkSpeed = v39.WalkSpeed * (u7.SpeedMultiplier + v38);
        local v40 = Humanoid;
        v40.WalkSpeed = v40.WalkSpeed * AdvanceUbersRules.multiplier(u1, "Speed");
        local v41 = Humanoid;
        v41.JumpHeight = v41.JumpHeight * (1 + v38);
        local Attribute2 = Humanoid:GetAttribute("AdminForcedSpeed");

        if Attribute2 then
            Humanoid.WalkSpeed = Attribute2;
        end;

        u6.CharacterEvents.PostUpdate:Fire(Humanoid, p20);
        local Attribute3 = u1:GetAttribute("LorenzoHeaderRecoveryUntil");

        if typeof(Attribute3) == "number" and workspace:GetServerTimeNow() < Attribute3 then
            Humanoid.WalkSpeed = 0;
            Humanoid.JumpHeight = 0;
            Humanoid.Jump = false;
        end;
    end);
end;

function u6.KnitInit(u42) -- Line: 421
    -- upvalues: Trove (copy), u2 (copy), KnitClient (copy), LocalPlayer (copy), Teams (copy), u3 (copy), u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
    u42.Trove = Trove.new();
    u42.Animations = require(script.Parent.AnimationController);
    u42.States = table.clone(u2);
    u42.ShotPowerMultiplier = 1;
    KnitClient.GetService("MatchService").RoundStarted:Connect(function() -- Line: 430
        -- upvalues: LocalPlayer (ref), Teams (ref), u3 (ref)
        if LocalPlayer.Team ~= Teams.Visitor then
            u3.RoundStarted:Fire();
        end;
    end);
    u42.Trove:Connect(LocalPlayer.CharacterAdded, function(p43) -- Line: 436
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref), u2 (ref), u42 (copy)
        u1 = p43;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);

        for i, v in u2 do
            u42.States[i] = v;
        end;

        u42.SpeedBoost = 0;
        u42.SpeedBoost2 = 0;
        u42.OwnWalkState = false;
        u42:RespawnChecks();
    end);
    u42.Trove:Connect(game.Players.PlayerRemoving, function(p44) -- Line: 456
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), Humanoid (ref), u42 (copy)
        if p44 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u42.Trove:Destroy();
            u42.BaseTrove:Destroy();
        end;
    end);
    u42:RespawnChecks();
end;

return KnitClient.CreateController(u6);