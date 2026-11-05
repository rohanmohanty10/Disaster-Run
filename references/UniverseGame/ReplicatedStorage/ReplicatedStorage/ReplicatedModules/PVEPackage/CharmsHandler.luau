  

 

local CharmsInfo = require(script.CharmsInfo);
local ItemData = require(game:GetService("ReplicatedStorage").ReplicatedModules.ItemData);

return {
    GetCharmInfo = function(p1) -- Line: 6, Name: GetCharmInfo
        -- upvalues: CharmsInfo (copy)
        return CharmsInfo[tostring(p1)];
    end,

    GetCharmsInfo = function() -- Line: 10, Name: GetCharmsInfo
        -- upvalues: CharmsInfo (copy)
        return CharmsInfo;
    end,

    GetCharmsForCrate = function(p2, p3) -- Line: 14, Name: GetCharmsForCrate
        -- upvalues: ItemData (copy), CharmsInfo (copy)
        local v4 = {};
        local v5 = ItemData.GetCrateInfo(p2);

        if v5 then
            if type(v5.Charms) == "table" then
                for _, v in v5.Charms do
                    local v6 = tostring(v);
                    table.insert(v4, v6);
                end;
            end;

            if p3 and type(CharmsInfo.PremiumCharms) == "table" then
                for _, v in v5.PremiumCharms do
                    local v7 = tostring(v);
                    table.insert(v4, v7);
                end;
            end;
        end;

        return v4;
    end,

    GetTotal = function() -- Line: 36, Name: GetTotal
        -- upvalues: CharmsInfo (copy)
        local v8 = 0;

        for _ in CharmsInfo do
            v8 = v8 + 1;
        end;

        return v8;
    end
};