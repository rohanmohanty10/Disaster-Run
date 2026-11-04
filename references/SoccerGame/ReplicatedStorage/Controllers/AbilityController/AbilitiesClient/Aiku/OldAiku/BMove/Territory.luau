  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local OverlapParams_new_ret = OverlapParams.new();
OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
OverlapParams_new_ret.FilterDescendantsInstances = { workspace.Debris, workspace.Debris };

return function(u1, u2, p3) -- Line: 21, Name: Move
    -- upvalues: ReplicatedStorage (copy), AbilityBalancing (copy), Popup (copy), Players (copy), OverlapParams_new_ret (copy)
    if p3.Values.HasBall.Value then
        return;
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Value = ReplicatedStorage.Football.Value;
    local Value2 = Value.Char.Value;

    if (ReplicatedStorage.Football.Value.Position - u2.Character.HumanoidRootPart.Position).Magnitude >= AbilityBalancing.Territory.ActivationRangeBall then
        Popup.Popup(u2, "Ball not in box!");

        return;
    end;

    if Value.OnPlayer.Value and Value2 then
        if Value2.Name == "GK" then
            return;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value2);

        if PlayerFromCharacter and PlayerFromCharacter.Team == u2.Team or Value2.Values.Goalie.Value then
            Popup.Popup(PlayerFromCharacter, "Ball is held by your teammate!");

            return;
        end;

        local v4 = workspace.PenaltyArea:FindFirstChild(u2.Team.Name);
        local v5 = false;

        for _, v in workspace:GetPartsInPart(v4, OverlapParams_new_ret) do
            if v.Parent == Value2 then
                v5 = true;
                break;
            end;
        end;

        if not v5 then
            return;
        end;
    else
        local v6 = workspace.PenaltyArea:FindFirstChild(u2.Team.Name);
        local v7 = false;

        for _, v in workspace:GetPartsInPart(v6, OverlapParams_new_ret) do
            if v == Value then
                v7 = true;
                break;
            end;
        end;

        if not v7 then
            return;
        end;
    end;

    u1.Animations:StopAnims();
    u1.Animations.Abilities.Territory.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.Territory:Play();
    u1.AbilityService.Ability:Fire("Territory", nil);
    u1.StatesController.States.Ability = true;
    u1.ABC:Add(function() -- Line: 91
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Add(task.delay(1.5, function() -- Line: 95
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.ABC:Connect(u1.AbilityService.Ability, function(p8) -- Line: 99
        -- upvalues: Popup (ref), u2 (copy), u1 (copy), AbilityBalancing (ref), ReplicatedStorage (ref)
        if typeof(p8) == "string" and p8 == "Too Far" then
            Popup.Popup(u2, "Balll was too far");
            u1.ABC:Clean();

            return;
        end;

        p8.AssemblyLinearVelocity = (game.Workspace.CurrentCamera.CFrame.LookVector + AbilityBalancing.Territory.ShotTiltVector) * AbilityBalancing.Territory.ShotPower;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u1.ABC:Clean();
    end);
end;