 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);

return {
    Windup = 0.5,
    FollowThrough = 0.2,
    Fadeaway = 0.25,
    Chaos = 0.2,
    TimeSkip = 0.2,
    Formless = 0.35,
    Floater = 0.25,
    TeamBuff = 0.2,
    Moon = 0.3,
    ArmImplant = 0.1,
    SlightBuff = 0.069,
    GoldenSpin = 0.35,

    Get = function(p1, p2, p3) -- Line: 21, Name: Get
        -- upvalues: Zones (copy), ReplicatedStorage (copy), Essentials (copy)
        local Zone = p3.Zone;
        local v4 = Zones.JumpScareZones[Zone];
        local Team = p2.Team;
        local v5;

        if Team then
            v5 = ReplicatedStorage.GameValues:FindFirstChild((`{Team.Name}ShootIncrease`));
        else
            v5 = Team;
        end;

        if Team then
            Team = ReplicatedStorage.GameValues:FindFirstChild((`{Essentials:ActualTeam(Team.Name)}ShootDecrease`));
        end;

        local v6 = Zones.ZoneIncreasedShootingSpeed[Zone] or (not p3.Fadeaway and 0 or p1.Fadeaway);

        if p3.Chaos then
            v6 = p1.Chaos;
        end;

        if v4 and p3.ScaryJump then
            v6 = v6 + v4.ShootingSpeed;
        end;

        if p3.TimeSkip then
            v6 = p1.TimeSkip;
        end;

        if p3.Formless then
            v6 = p1.Formless;
        end;

        if p3.Floater then
            v6 = p1.Floater;
        end;

        if v5 and v5.Value then
            v6 = v6 + p1.TeamBuff;
        end;

        if Team and Team.Value then
            v6 = v6 - p1.TeamBuff;
        end;

        local v7;

        if p3.Moon then
            v7 = p1.Moon;
        else
            v7 = (p3.ArmImplant or 0) * p1.ArmImplant;
        end;

        local v8 = v6 + v7;

        if p2:GetAttribute("SlightBuff") then
            v8 = v8 + p1.SlightBuff;
        end;

        return v8, Zone ~= "GoldenSpin" and 0 or p1.GoldenSpin - p1.GoldenSpin / math.pow(1.618033988749895, p3.Stacks or 0);
    end
};