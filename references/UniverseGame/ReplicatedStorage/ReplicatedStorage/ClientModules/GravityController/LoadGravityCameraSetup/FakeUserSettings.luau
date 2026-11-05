  

 

local u1 = {
    UserRemoveTheCameraApi = false
};
local u8 = {
    IsUserFeatureEnabled = function(p2, p3) -- Line: 7, Name: IsUserFeatureEnabled
        -- upvalues: u1 (copy)
        if u1[p3] == nil then
            return UserSettings():IsUserFeatureEnabled(p3);
        end;

        return u1[p3];
    end,

    SafeIsUserFeatureEnabled = function(u4, u5) -- Line: 14, Name: SafeIsUserFeatureEnabled
        local success, result = pcall(function() -- Line: 15
            -- upvalues: u4 (copy), u5 (copy)
            return u4:IsUserFeatureEnabled(u5);
        end);

        return success and result;
    end,

    GetService = function(p6, p7) -- Line: 21, Name: GetService
        return UserSettings():GetService(p7);
    end
};

return function() -- Line: 25, Name: FakeUserSettingsFunc
    -- upvalues: u8 (copy)
    return u8;
end;