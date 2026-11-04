  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Shared.AbilityUtils);
local countStyleMastery = require(ReplicatedStorage2.Shared.utils.countStyleMastery);
local PlayerData = require(ReplicatedStorage2.ClientModules.ClientGlobals).PlayerData;
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = workspace.CurrentCamera;

return function(p1) -- Line: 31
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), countStyleMastery (copy), PlayerData (copy), interface (copy), StatesController (copy), AnimationController (copy), BallController (copy), TweenService (copy)
    local NoBreakDribble = AbilityBalancing.NoBreakDribble;
    local u2 = AbilityUtils.rules.onball();

    if not (u2 and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local v3 = countStyleMastery(PlayerData.Data, "Chigiri");
    local Chigiri = PlayerData.Data.DisabledMasteryLevels.Chigiri;

    if interface.AbilityOne - tick() < 2 and (v3 >= 1 and not Chigiri[1]) then
        interface:AbilityCooldown(1, 2);
    end;

    local Character, u4, _, _ = AbilityUtils.getCharacter();
    interface:AbilityCooldown(3, NoBreakDribble.Cooldown);
    AbilityUtils.clearMovers(Character);
    StatesController.SpeedBoost = 10;
    local Track = AnimationController:GetTrack("Abilities", "NoBreakDribble");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("LokiExplosiveAcceleration");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action3;
    BallTrack:Play();
    StatesController.States.Ability = true;
    print("ability true");
    local ABC = interface.ABC;
    interface.AbilityService.Ability:Fire("NoBreakDribble", {
        ballSpawnTime = workspace:GetServerTimeNow() + 0.4 - 0.3
    });
    ABC:Add(interface.AbilityService.Ability:Connect(function(p5, p6) -- Line: 79
        -- upvalues: BallController (ref)
        if typeof(p5) == "Instance" then
            BallController:DragBall();
            p5.AssemblyLinearVelocity = p6;
        end;
    end));
    local u7 = false;
    local v13 = AbilityUtils.execute.dash(12, 0.8, {
        directionRecalculates = true,

        stepped = function(p8, p9) -- Line: 89, Name: stepped
            -- upvalues: u7 (ref), StatesController (ref), u4 (copy)
            if p8 > 0.4 and not u7 then
                u7 = true;
                StatesController.CharacterEvents.CustomEvent:Fire("ExplosiveAcceleration");
            end;

            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
            RaycastParams_new_ret.FilterDescendantsInstances = {
                workspace.Field,
                workspace.Colliders,
                workspace.Goals,
                workspace.SmallSquare
            };
            local v10 = workspace:Raycast(u4.Position, u4.CFrame.LookVector * 2, RaycastParams_new_ret);

            if v10 then
                print(v10);

                return Vector3.new(0, 0, 0);
            end;
        end,

        speed = function(p11) -- Line: 110, Name: speed
            -- upvalues: TweenService (ref), NoBreakDribble (copy), u2 (copy)
            if p11 <= 0.4 then
                return p11 > 0.4 and u2 and -6 or 6;
            end;

            local Value = TweenService:GetValue(math.clamp((p11 - 0.4) / 0.5, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out);

            return math.lerp(NoBreakDribble.MoveSpeedValue, NoBreakDribble.MoveSpeedValue * 0.7, Value);
        end,

        fov = function(p12) -- Line: 123, Name: fov
            return p12 > 0.4 and 25 or 8;
        end
    });
    v13:Add(function() -- Line: 131
        -- upvalues: StatesController (ref), Track (copy), BallTrack (copy), ABC (copy)
        StatesController.States.Ability = false;
        StatesController.SpeedBoost = 0;
        Track:Stop();
        BallTrack:Stop();
        ABC:Clean();
    end);
    ABC:Add(v13);
end;