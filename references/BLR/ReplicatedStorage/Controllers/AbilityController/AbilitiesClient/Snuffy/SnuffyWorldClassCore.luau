  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local BodyCore = require(ReplicatedStorage2.AbilityBalancing).BodyCore;
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

local function IsInCone(p1, p2, p3, p4) -- Line: 29
    local v5 = p2 - p1.Position;

    if p4 < v5.Magnitude then
        return false;
    end;

    local v6 = p1.LookVector:Dot(v5.Unit);
    local math_acos_ret = math.acos(v6);

    return math.deg(math_acos_ret) <= p3 / 2;
end;

return function() -- Line: 48, Name: WCC
    -- upvalues: AbilityUtils (copy), interface (copy), Players (copy), LocalPlayer (copy), BodyCore (copy), getPlayerTarget (copy), Popup (copy), StatesController (copy), AnimationController (copy), Trove (copy), BallController (copy), RunService (copy)
    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local ABC = interface.ABC;
    local Character, u7, _, _ = AbilityUtils.getCharacter();
    local v8 = nil;

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Team ~= LocalPlayer.Team) then
            local CFrame = Character.HumanoidRootPart.CFrame;
            local v9 = v.Character.HumanoidRootPart.Position - CFrame.Position;
            local v10;

            if BodyCore.ActivationRangePlayer < v9.Magnitude then
                v10 = false;
            else
                local v11 = CFrame.LookVector:Dot(v9.Unit);
                local math_acos_ret = math.acos(v11);
                v10 = math.deg(math_acos_ret) <= 45;
            end;

            if v10 and not v.Character:GetAttribute("IFrames") then
                if not (v.Character.Values.Dribbling.Value or v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value) then
                    v8 = v.Character;
                end;
            end;
        end;
    end;

    if workspace:FindFirstChild("PassRig") then
        local CFrame = Character.HumanoidRootPart.CFrame;
        local v12 = workspace.PassRig.HumanoidRootPart.Position - CFrame.Position;
        local v13;

        if BodyCore.ActivationRangePlayer < v12.Magnitude then
            v13 = false;
        else
            local v14 = CFrame.LookVector:Dot(v12.Unit);
            local math_acos_ret = math.acos(v14);
            v13 = math.deg(math_acos_ret) <= 45;
        end;

        if v13 then
            v8 = workspace.PassRig;
        end;
    end;

    local u18 = getPlayerTarget(false, function(p15, p16) -- Line: 82
        -- upvalues: Players (ref), LocalPlayer (ref), u7 (copy)
        if not (p15 and p15.Parent) then
            return false;
        end;

        local HumanoidRootPart = p15:FindFirstChild("HumanoidRootPart");
        local v17 = p15:FindFirstChildOfClass("Humanoid");
        local Values = p15:FindFirstChild("Values");

        if not (HumanoidRootPart and (v17 and (v17.Health > 0 and (Values and not (Values.HasBall.Value or Values.InCutscene.Value))))) then
            return false;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p15);

        if PlayerFromCharacter then
            if PlayerFromCharacter.Team ~= LocalPlayer.Team or PlayerFromCharacter.Team == game.Teams.Visitor then
                return false;
            end;
        elseif not p15:GetAttribute("IsTrainingDummy") then
            return false;
        end;

        if p15.Values.InCutscene.Value then
            return false;
        end;

        if (p15.HumanoidRootPart.Position - u7.Position).Magnitude < 100 then
            return true;
        end;
    end);

    if not v8 then
        Popup.Popup(LocalPlayer, "Must have an an enemy infront of you!");

        return;
    end;

    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    ABC:Add(function() -- Line: 110
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
    end);
    interface:AbilityCooldown(2, 40);

    if not v8.Values.HasBall.Value then
        interface.AbilityService.Ability:Fire("WorldClassCore", {
            Type = "Dash",
            Target = v8
        });
        ABC:Add(task.delay(0.5, function() -- Line: 194
            -- upvalues: AbilityUtils (ref), Character (copy), u7 (copy), ABC (copy)
            local v19, v20 = AbilityUtils.FastDashTo(Character, u7.Position + u7.CFrame.LookVector * 70, 2, 0.5);
            ABC:Add(v19);
            ABC:Add(v20);
        end));
        local Track = AnimationController:GetTrack("Abilities", "WorldClassCore");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        ABC:Add(task.delay(1.25, function() -- Line: 205
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return;
    end;

    interface.AbilityService.Ability:Fire("WorldClassCore", {
        Type = "Pass",
        Target = u18
    });
    local Track = AnimationController:GetTrack("Abilities", "WorldClassCorePass");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();

    if not u18 then
        task.wait(0.5);
        StatesController.States.Ability = false;

        return;
    end;

    local u21 = Trove.new();
    ABC:Add(u21);
    local u22 = false;
    u21:Connect(interface.AbilityService.Ability, function(u23) -- Line: 130
        -- upvalues: u22 (ref), StatesController (ref), LocalPlayer (ref), Character (copy), u18 (copy), u21 (copy), BallController (ref), RunService (ref)
        if u22 then
            return;
        end;

        u22 = true;
        StatesController.States.Ability = false;

        if not (u23 and (u23:IsA("BasePart") and (u23.Parent == workspace and not (u23.OnPlayer.Value or (LocalPlayer.Character ~= Character or not (Character.Parent and u18.Parent)))))) then
            u21:Destroy();

            return;
        end;

        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = u18.HumanoidRootPart;
        local u24 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.65, 0) + -HumanoidRootPart.CFrame.RightVector * 0.8;
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 200);
        u23.AssemblyLinearVelocity = u24 * math_clamp_ret;
        BallController:DragBall(u23);
        local u25 = tick();
        task.wait(0.2);
        u21:Connect(RunService.Heartbeat, function(p26) -- Line: 156
            -- upvalues: u25 (copy), u23 (copy), HumanoidRootPart2 (copy), LocalPlayer (ref), Character (ref), u21 (ref), u24 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u25 + 1.25 or (not u23.Parent or (u23.OnPlayer.Value or (not HumanoidRootPart2.Parent or LocalPlayer.Character ~= Character))) then
                return u21:Destroy();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v27 = tick() > u25 + 0.55;
            u24 = u24:Lerp((HumanoidRootPart2.Position - u23.Position).Unit + Vector3.new(0, v27 and 0.15 or 0.35, 0), 6.5 * p26);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 150, 150);

            if u23.Position.Y < 5 or (HumanoidRootPart2.Position - u23.Position).Magnitude <= 7 then
                return u21:Destroy();
            end;

            u23.AssemblyLinearVelocity = u23.AssemblyLinearVelocity:Lerp(u24 * math_clamp_ret, 6.5 * p26);
        end);
    end);
end;