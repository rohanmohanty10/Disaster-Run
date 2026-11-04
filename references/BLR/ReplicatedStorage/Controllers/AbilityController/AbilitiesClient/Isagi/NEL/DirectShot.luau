  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Popup);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, p3, p4) -- Line: 5
    -- upvalues: ReplicatedStorage (copy), AbilityBalancing (copy)
    if p2:GetAttribute("CRRequest") == "NELIsagiXHiori" then
        local Attribute = p2:GetAttribute("CRSender");
        local Attribute2 = p2:GetAttribute("CRRequestToken");
        local Value = ReplicatedStorage.Football.Value;

        if typeof(Attribute) == "number" and (typeof(Attribute2) == "string" and (Value and Value:IsDescendantOf(workspace))) then
            local _, v5 = require(ReplicatedStorage.Modules.GetChemicalReaction)(p2, {
                id = "NELIsagiXHiori",
                otherUserId = Attribute
            });

            if v5 then
                v5 = v5.Character;
            end;

            local v6;

            if v5 then
                v6 = v5:FindFirstChildOfClass("Humanoid");
            else
                v6 = v5;
            end;

            local NELIsagiXHioriReceiver = u1.UngroupedAbilities.NELIsagiXHioriReceiver;

            if NELIsagiXHioriReceiver and (v5 and (v6 and v6.Health > 0)) then
                NELIsagiXHioriReceiver(u1, p2, p3, v5, Attribute2);
            end;
        end;

        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if p3.Values.HasBall.Value == false then
        return;
    end;

    local u7 = false;
    u1:AbilityCooldown("1", 43);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.NewDirectShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.NewDirectShot.Looped = false;
    u1.Animations.Abilities.NewDirectShot:Play();
    local _ = p3.HumanoidRootPart;
    u1.AbilityService.Ability:Fire("NELDirectShot", { "Direct" });
    u1.ABC:Connect(u1.AbilityService.Ability, function(p8, p9) -- Line: 51
        -- upvalues: AbilityBalancing (ref), u1 (copy)
        local ShotPower = AbilityBalancing.NELDirectShot.ShotPower;
        local LookVector = game.Workspace.CurrentCamera.CFrame.LookVector;
        local Y = AbilityBalancing.NELDirectShot.ShotTiltVector.Y;

        if LookVector.Y < Y then
            LookVector = Vector3.new(LookVector.X, Y, LookVector.Z);
        end;

        p8.AssemblyLinearVelocity = LookVector * ShotPower;
        u1.BallController:DragBall(p8);
        u1.ABC:Clean();
    end);
    u1.ABC:Add(function() -- Line: 66
        -- upvalues: u7 (ref), u1 (copy)
        u7 = true;
        u1.StatesController.States.Ability = false;
    end);
    task.delay(2, function() -- Line: 71
        -- upvalues: u7 (ref), u1 (copy)
        if not u7 then
            u1.ABC:Clean();
        end;
    end);
end;