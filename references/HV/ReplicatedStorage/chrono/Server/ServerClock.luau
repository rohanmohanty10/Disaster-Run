 

 

local u1 = {};

local function Remove(p2: userdata) -- Line: 40
    -- upvalues: u1 (copy)
    u1[p2] = nil;
end;

game:GetService("Players").PlayerRemoving:Connect(Remove);

return {
    Store = function(p3: userdata, p4: number, p5: number?) -- Line: 7, Name: Store
        -- upvalues: u1 (copy)
        local v6 = u1[p3];

        if not v6 then
            v6 = {
                clockOffset = 0,
                oneWayDelay = 0.05
            };
            u1[p3] = v6;
        end;

        if p5 then
            local v7 = workspace:GetServerTimeNow() - p5;

            if v7 > 0 and v7 <= p3:GetNetworkPing() + 0.05 then
                v6.oneWayDelay = v7;
            end;
        end;

        local NetworkPing = p3:GetNetworkPing();
        local v8 = math.max(NetworkPing, 0) + 0.05;
        local v9 = os.clock() - p4 - math.clamp(v6.oneWayDelay, 0, v8);
        v6.clockOffset = v6.clockOffset + 0.2 * (v9 - v6.clockOffset);
    end,

    ConvertTo = function(p10: userdata, p11: number, p12: string) -- Line: 27, Name: ConvertTo
        -- upvalues: u1 (copy)
        local v13 = u1[p10];

        if not v13 then
            return p11;
        end;

        if p12 == "Server" then
            return p11 + v13.clockOffset;
        end;

        return p11 - v13.clockOffset;
    end,

    Remove = Remove
};