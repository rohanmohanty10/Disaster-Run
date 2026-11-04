  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local Popup = require(ReplicatedStorage.Shared.Popup);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

local function distanceToBoxEdgeXZ(p1, p2) -- Line: 12
    local v3 = p2.CFrame:PointToObjectSpace(p1);
    local math_abs_ret = math.abs(v3.X);
    local math_abs_ret2 = math.abs(v3.Z);
    local v4 = p2.Size.X / 2;
    local v5 = p2.Size.Z / 2;

    if math_abs_ret <= v4 and math_abs_ret2 <= v5 then
        return math.min(v4 - math_abs_ret, v5 - math_abs_ret2);
    end;

    return Vector2.new(math.max(math_abs_ret - v4, 0), (math.max(math_abs_ret2 - v5, 0))).Magnitude;
end;

local function isNearGoalkeeperBoxEdge(p6, p7) -- Line: 29
    -- upvalues: distanceToBoxEdgeXZ (copy)
    local SmallSquare = workspace:FindFirstChild("SmallSquare");

    if not SmallSquare then
        return false;
    end;

    for _, v in { "BoxHome", "BoxAway" } do
        local v8 = SmallSquare:FindFirstChild(v);

        if v8 and (v8:IsA("BasePart") and distanceToBoxEdgeXZ(p6, v8) <= p7) then
            return true;
        end;
    end;

    return false;
end;

return function() -- Line: 45
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), isNearGoalkeeperBoxEdge (copy), Popup (copy), ReplicatedStorage (copy), interface (copy)
    local NikoExtermination = AbilityBalancing.NikoExtermination;
    local Character, v9 = AbilityUtils.getCharacter(LocalPlayer);

    if not (Character and v9) then
        return;
    end;

    if not (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.slotReady(1) and AbilityUtils.rules.isAwakened(LocalPlayer)))) then
        return;
    end;

    if not isNearGoalkeeperBoxEdge(v9.Position, NikoExtermination.GoalBoxEdgeRange) then
        Popup.Popup(LocalPlayer, "Must be near the edge of a goalkeeper box!");

        return;
    end;

    local Value = ReplicatedStorage.Football.Value;
    local v10;

    if Value then
        v10 = Value:FindFirstChild("OnPlayer");
    else
        v10 = Value;
    end;

    if Value and (Value:IsA("BasePart") and (Value.Parent == workspace and (v10 and (not v10.Value and Value.Position.Y >= NikoExtermination.AirborneY)))) then
        interface.AbilityService.Ability:Fire(script.Name);
        interface:AbilityCooldown(1, NikoExtermination.Cooldown);
        AbilityUtils.clientCutsceneSkill(interface, NikoExtermination, 22, nil, true, v9.CFrame.LookVector);

        return true;
    end;

    Popup.Popup(LocalPlayer, "The ball must be in the air!");
end;