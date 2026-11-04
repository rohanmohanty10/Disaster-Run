  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Popup = require(ReplicatedStorage.Shared.Popup);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);

return function(p1, p2, p3) -- Line: 10
    -- upvalues: AbilityUtils (copy), ReplicatedStorage (copy), Players (copy), Popup (copy), interface (copy)
    if p3 then
        p3 = p3:FindFirstChild("HumanoidRootPart");
    end;

    if not p3 then
        return;
    end;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local _ = ReplicatedStorage.Football.Value;
    local v4 = nil;
    local Players2 = Players:GetPlayers();

    if workspace:FindFirstChild("PassRig") then
        table.insert(Players2, {
            Team = "",
            Character = workspace.PassRig
        });
    end;

    for _, v in Players2 do
        if v.Team ~= p2.Team and v.Team ~= game.Teams.Visitor then
            local Character = v.Character;
            local v5;

            if Character then
                v5 = Character:FindFirstChild("HumanoidRootPart");
            else
                v5 = Character;
            end;

            if v5 and (Character.Values.HasBall.Value and (not Character.Values.Dribbling.Value and (p3.Position - v5.Position).Magnitude < 20)) then
                v4 = Character;
            end;
        end;
    end;

    if not v4 then
        return Popup.Popup(p2, "No valid target nearby!");
    end;

    if v4.Values.Goalie.Value and v4.Values.IsInPenalty.Value then
        return;
    end;

    interface:AbilityCooldown(2, 45);
    local AlignPosition = Instance.new("AlignPosition");
    AlignPosition.ApplyAtCenterOfMass = true;
    AlignPosition.Mode = Enum.PositionAlignmentMode.TwoAttachment;
    AlignPosition.MaxForce = 50000;
    AlignPosition.MaxVelocity = 150;
    AlignPosition.Responsiveness = 100;
    AlignPosition.Attachment0 = p3:FindFirstChild("RootAttachment");
    AlignPosition.Attachment1 = v4:FindFirstChild("HumanoidRootPart"):FindFirstChild("RootAttachment");
    AlignPosition.Parent = p3;
    p1.AbilityService.Ability:Fire("SharkSteal");
    local v6 = tick();

    repeat
        task.wait();
    until tick() - v6 > 1 or (p3.Position - v4.HumanoidRootPart.Position).Magnitude < 3;

    p1.Animations:StopAnims();
    p1.Animations.Abilities.SharkSteal.Priority = Enum.AnimationPriority.Action4;
    p1.Animations.Abilities.SharkSteal:Play();
    p1.AbilityService.Ability:Fire("SharkSteal", v4);
    AlignPosition:Destroy();
end;