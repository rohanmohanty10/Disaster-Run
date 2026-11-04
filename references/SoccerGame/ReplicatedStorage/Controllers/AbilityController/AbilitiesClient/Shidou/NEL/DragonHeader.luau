  

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
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
local CameraController = require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local Spring = require(ReplicatedStorage2.Shared.Spring);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

local function ClampMagnitude(p1, p2) -- Line: 30
    return p1.Magnitude == 0 and Vector3.new(0, 0, 0) or p1.Unit * math.min(p1.Magnitude, p2);
end;

return function() -- Line: 35
    -- upvalues: interface (copy), LocalPlayer (copy), Players (copy), ReplicatedStorage (copy), AbilityBalancing (copy), Popup (copy), AbilityUtils (copy), AnimationController (copy), StatesController (copy), Spring (copy), getPlayerTarget (copy), RunService (copy), CameraController (copy), workspace_CurrentCamera (copy), BallController (copy)
    if interface.DragonHeader and LocalPlayer:GetAttribute("CRRequest") == "ShidouXCharlesCR" then
        local Attribute = LocalPlayer:GetAttribute("CRRequestToken");
        local Attribute2 = LocalPlayer:GetAttribute("CRSender");
        local v3;

        if typeof(Attribute2) == "number" then
            v3 = Players:GetPlayerByUserId(Attribute2) or nil;
        else
            v3 = nil;
        end;

        local v4;

        if v3 then
            v4 = v3:FindFirstChild("PlayerStats");
        else
            v4 = v3;
        end;

        if v4 then
            v4 = v4:FindFirstChild("Style");
        end;

        local v5;

        if v3 then
            v5 = v3.Character;
        else
            v5 = v3;
        end;

        local v6;

        if v5 then
            v6 = v5:FindFirstChildOfClass("Humanoid");
        else
            v6 = v5;
        end;

        local Value = ReplicatedStorage.Football.Value;
        local Character = LocalPlayer.Character;
        local v7;

        if Character then
            v7 = Character:FindFirstChildOfClass("Humanoid");
        else
            v7 = Character;
        end;

        local v8;

        if Character then
            v8 = Character:FindFirstChild("HumanoidRootPart");
        else
            v8 = Character;
        end;

        if typeof(Attribute) ~= "string" or not (v3 and (v3 ~= LocalPlayer and (v3.Team == LocalPlayer.Team and (v4 and (v4.Value == "Charles" and (v5 and (v6 and (v6.Health > 0 and (Character and (v7 and (v7.Health > 0 and (v8 and (Value and Value:IsDescendantOf(workspace)))))))))))))) then
            return;
        end;

        if (Value.Position - v8.Position).Magnitude > AbilityBalancing.ShidouXCharlesCR.BallCloseRange then
            Popup.Popup(LocalPlayer, "Ball is too far!");

            return;
        end;

        local v9 = interface.UngroupedAbilities and interface.UngroupedAbilities.ShidouXCharlesCR;

        if v9 then
            v9(interface, LocalPlayer, Character);
        end;

        return;
    end;

    local DragonHeader = AbilityBalancing.DragonHeader;

    if not AbilityUtils.rules.slotReady(2) then
        return;
    end;

    interface.DragonHeader = false;
    local Character, u10, u11, _ = AbilityUtils.getCharacter();
    local Track = AnimationController:GetTrack("Abilities", "DragonHeader");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    local ABC = interface.ABC;
    interface:AbilityCooldown(2, DragonHeader.Cooldown);

    if Character.Values.HasBall.Value then
        interface.AbilityService.Ability:Fire("DragonHeaderNew", {
            Shot = true
        });
    else
        interface.AbilityService.Ability:Fire("DragonHeaderNew", {
            HitboxStart = workspace:GetServerTimeNow() + 0.35
        });
    end;

    StatesController.States.Ability = true;
    Track:Play();
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(1000000000, 0, 1000000000);
    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
    BodyVelocity.Parent = u10;
    local BodyForce = Instance.new("BodyForce");
    BodyForce.Force = Vector3.new(0, -workspace.Gravity * u10.AssemblyMass * 0.75, 0);
    BodyForce.Parent = u10;
    local math_clamp_ret = math.clamp((u10.CFrame.LookVector * Vector3.new(1, 0, 1)).Magnitude, 6, 12);
    local u12 = Spring.new(math_clamp_ret);
    u12.Speed = 100;
    u12.Damper = 1;

    local function changeYVelocity(p13: number) -- Line: 136
        -- upvalues: u10 (copy)
        local AssemblyLinearVelocity = u10.AssemblyLinearVelocity;
        u10.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, p13, AssemblyLinearVelocity.Z);
    end;

    local v16 = getPlayerTarget(false, function(p14, p15) -- Line: 141
        -- upvalues: u10 (copy), DragonHeader (copy), Players (ref), RunService (ref), LocalPlayer (ref)
        if p14:GetAttribute("IsTrainingDummy") then
            return (p14.HumanoidRootPart.Position - u10.Position).Magnitude < DragonHeader.ActivationRangePlayer;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p14);

        if RunService:IsStudio() then
            return true;
        end;

        if not PlayerFromCharacter then
            return false;
        end;

        if PlayerFromCharacter.Team ~= LocalPlayer.Team then
            return false;
        end;

        if p14.Values.InCutscene.Value then
            return false;
        end;

        if (p14.HumanoidRootPart.Position - u10.Position).Magnitude < DragonHeader.ActivationRangePlayer then
            return true;
        end;
    end);
    local _ = v16 and (v16.HumanoidRootPart.Position - u10.Position).Magnitude > DragonHeader.ActivationRangePlayer;
    local u17 = false;
    local task_spawn_ret = task.spawn(function() -- Line: 170
        -- upvalues: u12 (copy), CameraController (ref), DragonHeader (copy), u10 (copy), u17 (ref)
        u12.Target = 80;
        CameraController.FOVBonus = 3;
        task.wait(0.15);
        CameraController.FOVBonus = 10;
        local AssemblyLinearVelocity = u10.AssemblyLinearVelocity;
        u10.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, DragonHeader.JumpHeight, AssemblyLinearVelocity.Z);
        u17 = true;
        task.wait(0.4);
        CameraController.FOVBonus = 3;
        task.wait(0.2);
    end);
    ABC:Add(task.delay(0.8, function() -- Line: 191
        -- upvalues: BodyForce (copy), BodyVelocity (copy)
        BodyForce:Destroy();
        BodyVelocity:Destroy();
    end));
    ABC:Add(task.delay(1.5, function() -- Line: 198
        -- upvalues: ABC (copy)
        ABC:Destroy();
    end));
    ABC:Add(task_spawn_ret);
    ABC:Add(task.delay(5, function() -- Line: 205
        -- upvalues: ABC (copy)
        ABC:Destroy();
    end));
    os.clock();
    local u18 = false;

    local function onLanded() -- Line: 214
        -- upvalues: u18 (ref), BodyVelocity (copy)
        u18 = true;
        BodyVelocity:Destroy();
    end;

    ABC:Add(interface.AbilityService.Ability:Connect(function(p19, p20) -- Line: 221
        -- upvalues: ABC (copy), u10 (copy), workspace_CurrentCamera (ref), AbilityBalancing (ref), BallController (ref)
        ABC:Destroy();
        local v21 = u10.Position + Vector3.new(0, 2.5, 0);

        if (p19.Position - v21).Magnitude <= 20 then
            p19.CFrame = CFrame.new(v21);
        end;

        p19.AssemblyLinearVelocity = workspace_CurrentCamera.CFrame.LookVector * AbilityBalancing.DragonicVolley.ShotPower;
        BallController:DragBall(p19);
    end));
    ABC:Add(u11.StateChanged:Connect(function(p22) -- Line: 233
    end));
    local Unit = (workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    ABC:Add(RunService.RenderStepped:Connect(function(p23) -- Line: 246
        -- upvalues: u17 (ref), u18 (ref), u11 (copy), BodyVelocity (copy), Unit (copy), u12 (copy), AbilityUtils (ref), u10 (copy)
        if u18 then
            return;
        end;

        local v24 = Unit * u12.Position;
        BodyVelocity.MaxForce = Vector3.new(1000000000, 0, 1000000000);
        BodyVelocity.Velocity = v24;

        if AbilityUtils.wallCheck(u10.CFrame.Position, v24 * 1 / 30) then
            BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        end;

        u10.CFrame = CFrame.lookAlong(u10.CFrame.Position, Unit);
    end));
    ABC:Add(function() -- Line: 273
        -- upvalues: CameraController (ref), StatesController (ref), BodyForce (copy), BodyVelocity (copy)
        CameraController.FOVBonus = 0;
        StatesController.States.Ability = false;
        BodyForce:Destroy();
        BodyVelocity:Destroy();
    end);
end;