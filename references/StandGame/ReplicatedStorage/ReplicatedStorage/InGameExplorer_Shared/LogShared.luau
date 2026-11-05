 

 

local l__LogService__1 = game:GetService("LogService");
return {
    GetHistory = function(_) --[[ Name: GetHistory, Line 5 ]]
        -- upvalues: l__LogService__1 (copy)
        local v1 = l__LogService__1:GetLogHistory();
        for _, v2 in v1 do
            local v3 = DateTime.fromUnixTimestamp(v2.timestamp):ToLocalTime();
            v2.timestamp = string.format("%s:%s:%s", v3.Hour, v3.Minute, v3.Second);
        end;
        return v1;
    end,
    AddEvent = function(_, p4, u5) --[[ Name: AddEvent, Line 13 ]]
        -- upvalues: l__LogService__1 (copy)
        p4:Add(l__LogService__1.MessageOut:Connect(function(p6, p7) --[[ Line: 14 ]]
            -- upvalues: u5 (copy)
            local v8 = DateTime.now():ToLocalTime();
            u5({
                message = p6,
                messageType = p7,
                timestamp = string.format("%s:%s:%s", v8.Hour, v8.Minute, v8.Second)
            });
        end));
    end
};