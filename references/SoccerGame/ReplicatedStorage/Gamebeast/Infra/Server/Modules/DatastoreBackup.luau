  

local u1 = {};
local DataStoreService = game:GetService("DataStoreService");
game:GetService("RunService");

function u1.Set(u2, u3, u4) -- Line: 35
    local success, result = pcall(function() -- Line: 36
        -- upvalues: u2 (copy), u3 (copy), u4 (copy)
        u2._dataStore:SetAsync(u3, u4);
    end);

    if not success then
        warn("Failed to save backup data for key \'" .. u3 .. "\': " .. tostring(result));
    end;

    return success;
end;

function u1.Update(u5: table, u6: any, u7: function) -- Line: 47
    local success, result = pcall(function() -- Line: 48
        -- upvalues: u5 (copy), u6 (copy), u7 (copy)
        u5._dataStore:UpdateAsync(u6, u7);
    end);

    if not success then
        warn("Failed to update backup data for key \'" .. u6 .. "\': " .. tostring(result));
    end;

    return success;
end;

function u1.Get(u8, u9) -- Line: 59
    local success, result = pcall(function() -- Line: 60
        -- upvalues: u8 (copy), u9 (copy)
        return u8._dataStore:GetAsync(u9);
    end);

    if success then
        return success, result;
    end;

    warn("Failed to retrieve backup data for key \'" .. u9 .. "\': " .. tostring(result));

    return nil;
end;

u1.__index = u1;

function u1.new(p10: boolean) -- Line: 76
    -- upvalues: u1 (copy), DataStoreService (copy)
    local v11 = setmetatable({}, u1);
    v11._dataStore = DataStoreService:GetDataStore((p10 and "Studio" or "") .. "_Gamebeast_Backup");

    return v11;
end;

return u1;