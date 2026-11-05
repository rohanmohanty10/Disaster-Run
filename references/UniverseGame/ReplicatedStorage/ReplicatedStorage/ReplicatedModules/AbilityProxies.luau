  

 

local Stands = require(game:GetService("ReplicatedStorage").ReplicatedModules.Stands);
local u1 = {
    [4211] = {
        Id = 421,
        Name = "Yone"
    },
    [466] = {
        Id = 46,
        Name = "Umbra"
    },
    [730] = {
        Id = 73,
        Name = "Weather Report"
    },
    [733] = {
        Id = 73,
        Name = "Weather Report"
    },
    [732732] = {
        Id = 732,
        Name = "Broly"
    }
};
local u2 = {};

for i, v in pairs(Stands) do
    if u1[i] then
        u2[v] = u1[i].Name;
    end;
end;

return {
    GetProxy = function(p3) -- Line: 35, Name: GetProxy
        -- upvalues: u1 (copy)
        return u1[tonumber(p3)];
    end,

    GetProxyId = function(p4) -- Line: 40, Name: GetProxyId
        -- upvalues: u1 (copy)
        local v5 = tonumber(p4);

        if u1[v5] then
            return u1[v5].Id;
        end;

        return v5;
    end,

    GetProxyName = function(p6) -- Line: 45, Name: GetProxyName
        -- upvalues: u2 (copy), u1 (copy), Stands (copy)
        if type(p6) == "string" and u2[p6] then
            return u2[p6];
        end;

        local v7 = tonumber(p6);

        if u1[v7] then
            return u1[v7].Name;
        end;

        return Stands[v7];
    end
};