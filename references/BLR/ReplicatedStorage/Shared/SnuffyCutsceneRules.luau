  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local getCooldownSpeed = require(ReplicatedStorage.Shared.utils.getCooldownSpeed);
local u6 = {
    livePlayer = function(p1) -- Line: 6, Name: livePlayer
        -- upvalues: Players (copy)
        if not (p1 and (p1.Parent == Players and (p1.Team and p1.Team.Name ~= "Visitor"))) then
            return nil;
        end;

        local Character = p1.Character;
        local v2;

        if Character then
            v2 = Character:FindFirstChild("HumanoidRootPart");
        else
            v2 = Character;
        end;

        local v3;

        if Character then
            v3 = Character:FindFirstChildOfClass("Humanoid");
        else
            v3 = Character;
        end;

        local v4;

        if Character then
            v4 = Character:FindFirstChild("Values");
        else
            v4 = Character;
        end;

        local PlayerStats = p1:FindFirstChild("PlayerStats");

        if not (Character and (Character.Parent and (v2 and (v3 and (v3.Health > 0 and (v4 and (v4:FindFirstChild("HasBall") and (v4:FindFirstChild("InCutscene") and (not v4.InCutscene.Value and (PlayerStats and PlayerStats:FindFirstChild("Style"))))))))))) then
            return nil;
        end;

        for _, v in { "Stunned", "Sliding" } do
            local v5 = v4:FindFirstChild(v);

            if v5 and v5.Value then
                return nil;
            end;
        end;

        local IsRagdoll = Character:FindFirstChild("IsRagdoll");

        return not (IsRagdoll and IsRagdoll.Value) and {
            character = Character,
            root = v2,
            humanoid = v3,
            values = v4,
            stats = PlayerStats
        } or nil;
    end
};

function u6.ballFor(p7, p8, p9) -- Line: 25
    -- upvalues: u6 (copy), ReplicatedStorage (copy), Players (copy)
    local v10 = u6.livePlayer(p7);

    if not v10 or v10.values.HasBall.Value then
        return nil;
    end;

    local Value = ReplicatedStorage.Football.Value;

    if not (Value and (Value:IsA("BasePart") and (Value:FindFirstChild("OnPlayer") and (Value:FindFirstChild("Char") and p8 >= (Value.Position - v10.root.Position).Magnitude)))) then
        return nil;
    end;

    if Value.Parent == workspace and not Value.OnPlayer.Value then
        return Value, Value.Char.Value;
    end;

    if not (p9 and Value.OnPlayer.Value) then
        return nil;
    end;

    local Value2 = Value.Char.Value;
    local v11;

    if Value2 then
        v11 = Players:GetPlayerFromCharacter(Value2);
    else
        v11 = Value2;
    end;

    local v12;

    if v11 then
        v12 = u6.livePlayer(v11);
    else
        v12 = v11;
    end;

    if not (v12 and (v11.Team ~= p7.Team and (Value.Parent == Value2 and v12.values.HasBall.Value))) then
        return nil;
    end;

    local Goalie = v12.values:FindFirstChild("Goalie");

    if Goalie and Goalie.Value then
        return nil;
    end;

    return Value, Value2;
end;

function u6.airBall(p13, p14) -- Line: 43
    -- upvalues: u6 (copy)
    local v15, v16 = u6.ballFor(p13, p14, false);

    if v15 and v15.Position.Y >= 14 then
        return v15, v16;
    end;

    return nil;
end;

function u6.cooldownDuration(p17, p18, p19) -- Line: 51
    -- upvalues: getCooldownSpeed (copy)
    local ServerSettings = workspace:FindFirstChild("ServerSettings");

    return (p17:GetAttribute("NoCooldowns") or ServerSettings and ServerSettings:GetAttribute("NoAbilityCooldown")) and 1 or p19 * getCooldownSpeed(p17, p17.PlayerStats.Style.Value, p18);
end;

function u6.nearestTeammate(p20, p21) -- Line: 59
    -- upvalues: u6 (copy), Players (copy)
    local v22 = u6.livePlayer(p20);

    if not v22 then
        return nil;
    end;

    local v23 = nil;

    for _, v in Players:GetPlayers() do
        if v ~= p20 and v.Team == p20.Team then
            local v24 = u6.livePlayer(v);

            if v24 then
                local Magnitude = (v24.root.Position - v22.root.Position).Magnitude;

                if Magnitude < p21 then
                    v23 = v24.character;
                    p21 = Magnitude;
                end;
            end;
        end;
    end;

    return v23;
end;

return u6;