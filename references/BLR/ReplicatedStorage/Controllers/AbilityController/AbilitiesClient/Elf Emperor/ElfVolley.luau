  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local Promise = require(game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Promise"));
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 29
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), Popup (copy), getPlayerTarget (copy), Players (copy), interface (copy), StatesController (copy), AnimationController (copy), Promise (copy), RunService (copy), BallController (copy), ReplicatedStorage2 (copy)
    local ElfVolley = AbilityBalancing.ElfVolley;

    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2)) then
        return;
    end;

    if not AbilityUtils.rules.onball(LocalPlayer, false) then
        local Character, u1, v2, _ = AbilityUtils.getCharacter();
        local v5 = getPlayerTarget(false, function(p3, p4) -- Line: 45
            -- upvalues: Players (ref), u1 (copy), ElfVolley (copy), LocalPlayer (ref)
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p3);

            if p3:GetAttribute("IsTrainingDummy") then
                return (p3.HumanoidRootPart.Position - u1.Position).Magnitude < ElfVolley.ActivationRangePlayer;
            end;

            if not PlayerFromCharacter then
                return false;
            end;

            if PlayerFromCharacter.Team ~= LocalPlayer.Team then
                return false;
            end;

            local Values = p3.Values;

            if not Values.HasBall.Value or (Values.InCutscene.Value or Values.IsInPenalty.Value and Values.Goalie.Value) then
                return false;
            end;

            if (p3.HumanoidRootPart.Position - u1.Position).Magnitude < ElfVolley.ActivationRangePlayer then
                return true;
            end;
        end);

        if not v5 or workspace:FindFirstChild("Football") then
            return Popup.Popup(LocalPlayer, "Must be near a teammate with the ball");
        end;

        interface:AbilityCooldown(2, ElfVolley.Cooldown);
        local ABC = interface.ABC;
        local _ = v2.MoveDirection.Unit;
        StatesController.States.Ability = true;
        local Track = AnimationController:GetTrack("Abilities", "ElfVolley");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("ElfVolleyBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        interface.AbilityService.Ability:Fire("ElfVolley", v5);
        ABC:Add(function() -- Line: 98
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        ABC:Connect(interface.AbilityService.Ability, function(u6, u7, p8) -- Line: 102
            -- upvalues: Promise (ref), ABC (copy), RunService (ref), Character (copy), ElfVolley (copy), BallController (ref), ReplicatedStorage2 (ref)
            local u9 = tick();
            local u10 = nil;
            Promise.new(function(u11, p12, p13) -- Line: 106
                -- upvalues: u10 (ref), ABC (ref), RunService (ref), u9 (copy), u6 (copy)
                u10 = ABC:Connect(RunService.Heartbeat, function(p14) -- Line: 107
                    -- upvalues: u9 (ref), u6 (ref), u10 (ref), u11 (copy)
                    if tick() > u9 + 5 or (not u6 or u6.OnPlayer.Value) then
                        u10:Disconnect();
                        u11();
                    end;
                end);
            end):catch(warn);

            repeat
                task.wait();
            until not Character.Values.HasBall.Value;

            local v15 = game.Workspace.CurrentCamera.CFrame.LookVector + ElfVolley.ShotTiltVector + u7 / 2;

            if v15.Y < 0.15 then
                v15 = Vector3.new(v15.X, 0.15, v15.Z);
            end;

            u6.AssemblyLinearVelocity = v15 * ElfVolley.ShotPower;
            task.delay(0.1, function() -- Line: 123
                -- upvalues: ABC (ref), RunService (ref), u6 (copy), u7 (copy)
                local u16 = -40;
                ABC:Connect(RunService.Heartbeat, function(p17) -- Line: 126
                    -- upvalues: u16 (ref), ABC (ref), u6 (ref), u7 (ref)
                    u16 = u16 + 25 * p17;

                    if u16 >= -25 then
                        ABC:Clean();
                        print("CLEANED!");
                    end;

                    u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u6.AssemblyLinearVelocity + u7 * u16, 6.5 * p17);
                end);
            end);
            BallController:DragBall(ReplicatedStorage2.Football.Value);
            ABC:Clean();
        end);
        ABC:Add(task.delay(1.5, function() -- Line: 138
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;

    Popup.Popup(LocalPlayer, "in range teammate must have ball");
end;