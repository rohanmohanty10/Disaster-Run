  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local u13 = {
    Id = "AikuSelfishCaptain",
    TokenAttribute = "AikuSelfishCaptainToken",
    ExpiryAttribute = "AikuSelfishCaptainExpiresAt",
    TeamAttribute = "AikuSelfishCaptainSourceTeam",
    ReadyAttribute = "AikuSelfishCaptainReadyAt",

    hasNEL = function(p1) -- Line: 13, Name: hasNEL
        -- upvalues: countStyleMastery (copy)
        local v2 = p1 and p1.DisabledMasteryLevels and p1.DisabledMasteryLevels.Aiku;
        local v3;

        if p1 == nil or countStyleMastery(p1, "Aiku") < 4 then
            v3 = false;
        else
            if v2 then
                v2 = v2[4];
            end;

            v3 = not v2;
        end;

        return v3;
    end,

    live = function(p4, p5) -- Line: 18, Name: live
        -- upvalues: Players (copy)
        local v6;

        if p4 then
            v6 = p4.Character;
        else
            v6 = p4;
        end;

        local v7;

        if v6 then
            v7 = v6:FindFirstChildOfClass("Humanoid");
        else
            v7 = v6;
        end;

        local v8;

        if v6 then
            v8 = v6:FindFirstChild("HumanoidRootPart");
        else
            v8 = v6;
        end;

        local v9;

        if v6 then
            v9 = v6:FindFirstChild("Values");
        else
            v9 = v6;
        end;

        local v10;

        if v9 then
            v10 = v9:FindFirstChild("HasBall");
        else
            v10 = v9;
        end;

        if v9 then
            v9 = v9:FindFirstChild("InCutscene");
        end;

        local v11;

        if p4 then
            v11 = p4:FindFirstChild("PlayerStats");
        else
            v11 = p4;
        end;

        local v12;

        if v11 then
            v12 = v11:FindFirstChild("Style");
        else
            v12 = v11;
        end;

        return p4 and (p4.Parent == Players and (v6 and (v6.Parent and (v7 and (v7.Health > 0 and (v8 and (v10 and (v9 and not (v9.Value or (not v12 or v12.Value ~= p5)))))))))) and {
            player = p4,
            character = v6,
            humanoid = v7,
            root = v8,
            hasBall = v10,
            inCutscene = v9,
            stats = v11
        } or nil;
    end
};

function u13.canReceive(p14, p15) -- Line: 36
    -- upvalues: u13 (copy)
    local v16 = u13.live(p14, "Aiku");
    local v17;

    if v16 then
        v17 = v16.stats:FindFirstChild("InAwakening");
    else
        v17 = v16;
    end;

    local v18;

    if p14 then
        v18 = p14:GetAttribute(u13.ReadyAttribute);
    else
        v18 = p14;
    end;

    if v16 and (u13.hasNEL(p15) and (v17 and (v17.Value and (p14.Team and (p14.Team.Name == "Home" or p14.Team.Name == "Away"))))) and not (typeof(v18) == "number" and workspace:GetServerTimeNow() < v18 or (p14:GetAttribute("GrantedFastShot") or (p14:GetAttribute("GrantedTwoStepsBehindShot") or p14:GetAttribute("GrantedNikoLionShot")))) then
        return v16;
    end;

    return nil;
end;

function u13.context(p19, p20) -- Line: 50
    -- upvalues: u13 (copy), Players (copy), ReplicatedStorage (copy), AbilityBalancing (copy)
    local v21 = u13.canReceive(p19, p20);

    if not v21 or p19:GetAttribute("CRRequest") ~= u13.Id then
        return nil;
    end;

    local Attribute = p19:GetAttribute("CRRequestToken");
    local Attribute2 = p19:GetAttribute("CRSender");

    if typeof(Attribute) ~= "string" or (#Attribute == 0 or (#Attribute > 80 or typeof(Attribute2) ~= "number")) then
        return nil;
    end;

    local v22 = u13.live(Players:GetPlayerByUserId(Attribute2), "Sae");
    local Value = ReplicatedStorage.Football.Value;
    local v23;

    if Value then
        v23 = Value:FindFirstChild("Char");
    else
        v23 = Value;
    end;

    local v24;

    if Value then
        v24 = Value:FindFirstChild("OnPlayer");
    else
        v24 = Value;
    end;

    local v25;

    if Value then
        v25 = Value:GetAttribute(u13.ExpiryAttribute);
    else
        v25 = Value;
    end;

    if not (v22 and (v22.player ~= p19 and (v22.player.Team == p19.Team and (Value and (v23 and (v24 and (Value:GetAttribute(u13.TokenAttribute) == Attribute and (typeof(v25) == "number" and (v25 >= workspace:GetServerTimeNow() and Value:GetAttribute(u13.TeamAttribute) == p19.Team.Name))))))))) then
        return nil;
    end;

    local v26;

    if Value.Parent == v21.character and v23.Value == v21.character then
        v26 = v24.Value and v21.hasBall.Value;
    else
        v26 = false;
    end;

    local v27;

    if Value.Parent == workspace and v23.Value == v22.character then
        v27 = not (v24.Value or v21.hasBall.Value) and (Value.Position - v21.root.Position).Magnitude <= AbilityBalancing.AikuSelfishCaptain.ArrivalRange;
    else
        v27 = false;
    end;

    return (v26 or v27) and {
        receiver = v21,
        sender = v22,
        ball = Value,
        token = Attribute,
        expires = v25,
        held = v26
    } or nil;
end;

return u13;