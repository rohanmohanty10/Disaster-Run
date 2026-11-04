  

local Players = game:GetService("Players");
local ChemicalReactions = require(game.ReplicatedStorage.Shared.Configs.ChemicalReactions);
local u1 = {};

for i in ChemicalReactions do
    table.insert(u1, i);
end;

table.sort(u1);

local function getStyle(p2) -- Line: 10
    if p2 then
        p2 = p2:FindFirstChild("PlayerStats");
    end;

    if p2 then
        p2 = p2:FindFirstChild("Style");
    end;

    return p2 and p2.Value or nil;
end;

local function findPairStyle(p3, p4, p5) -- Line: 16
    -- upvalues: Players (copy)
    if typeof(p5) ~= "number" then
        for _, v in Players:GetPlayers() do
            if v ~= p3 and v.Team == p3.Team then
                local v6;

                if v then
                    v6 = v:FindFirstChild("PlayerStats");
                else
                    v6 = v;
                end;

                if v6 then
                    v6 = v6:FindFirstChild("Style");
                end;

                if (v6 and v6.Value or nil) == p4 then
                    return v;
                end;
            end;
        end;

        return nil;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p5);

    if PlayerByUserId and (PlayerByUserId ~= p3 and PlayerByUserId.Team == p3.Team) then
        local v7;

        if PlayerByUserId then
            v7 = PlayerByUserId:FindFirstChild("PlayerStats");
        else
            v7 = PlayerByUserId;
        end;

        if v7 then
            v7 = v7:FindFirstChild("Style");
        end;

        if (v7 and v7.Value or nil) == p4 then
            return PlayerByUserId;
        end;
    end;

    return nil;
end;

local function resolveReaction(p8, p9, p10, p11) -- Line: 40
    -- upvalues: findPairStyle (copy)
    if not p10 then
        return nil;
    end;

    local v12;

    if p8 then
        v12 = p8:FindFirstChild("PlayerStats");
    else
        v12 = p8;
    end;

    if v12 then
        v12 = v12:FindFirstChild("Style");
    end;

    local v13 = v12 and v12.Value or nil;

    if not (v13 and (p10.sender == v13 or p10.receiver == v13)) then
        return nil;
    end;

    local v14 = findPairStyle(p8, p10.sender == v13 and p10.receiver or p10.sender, p11);

    if v14 then
        return p9, v14, p10;
    end;

    return nil;
end;

return function(p15, p16) -- Line: 63
    -- upvalues: resolveReaction (copy), ChemicalReactions (copy), u1 (copy)
    local v17 = typeof(p16) == "table" and p16 and p16 or {};

    if p15 and p15.Team then
        local v18;

        if p15 then
            v18 = p15:FindFirstChild("PlayerStats");
        else
            v18 = p15;
        end;

        if v18 then
            v18 = v18:FindFirstChild("Style");
        end;

        if v18 and v18.Value or nil then
            if typeof(v17.id) == "string" then
                return resolveReaction(p15, v17.id, ChemicalReactions[v17.id], v17.otherUserId);
            end;

            for _, v in u1 do
                local v19 = ChemicalReactions[v];

                if not (v17.requestableOnly and v19.ServerArmed) then
                    local v20, v21, v22 = resolveReaction(p15, v, v19);

                    if v20 then
                        return v20, v21, v22;
                    end;
                end;
            end;

            return nil;
        end;
    end;

    return nil;
end;