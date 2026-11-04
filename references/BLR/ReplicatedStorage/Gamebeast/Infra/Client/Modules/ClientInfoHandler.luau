  

local u1 = {
    Priority = 1000
};
local MarketplaceService = game:GetService("MarketplaceService");
local GetRemote = require(script.Parent.Parent.Parent.Shared.Modules.GetRemote);
local ClientSessionPreservation = require(script.Parent.ClientSessionPreservation);
local u2 = GetRemote("Event", "ClientInfoChanged");
local u3 = GetRemote("Function", "GetClientInfo");
local u4 = GetRemote("Function", "GetProductPrice");
local u5 = {
    device = true,
    deviceSubType = true,
    inputType = true
};
local u6 = {};
local u7 = {};
local u8 = false;

function u1.UpdateClientInfo(p9: table, p10: string, p11: any) -- Line: 54
    -- upvalues: u7 (copy), ClientSessionPreservation (copy), u5 (copy), u8 (ref), u2 (copy)
    if u7[p10] ~= p11 then
        u7[p10] = p11;
        ClientSessionPreservation:UpdateStoredData(p10, p11);

        for i in u5 do
            if not u7[i] then
                return;
            end;
        end;

        if u8 then
            return;
        end;

        u8 = true;
        task.defer(function() -- Line: 70
            -- upvalues: u8 (ref), u2 (ref), u7 (ref)
            u8 = false;
            u2:FireServer(u7);
        end);
    end;
end;

function u1.GetClientInfo(p12: table, p13: string) -- Line: 77
    -- upvalues: u7 (copy)
    return u7[p13];
end;

for i, v in ClientSessionPreservation:GetStoredData() do
    u1:UpdateClientInfo(i, v);
end;

function u1.Init(p14) -- Line: 88
    -- upvalues: u3 (copy), u7 (copy), u4 (copy), u6 (copy), MarketplaceService (copy), u2 (copy), u1 (copy)
    function u3.OnClientInvoke() -- Line: 89
        -- upvalues: u7 (ref)
        return u7;
    end;

    function u4.OnClientInvoke(u15, u16) -- Line: 94
        -- upvalues: u6 (ref), MarketplaceService (ref)
        if u6[u15] then
            return u6[u15];
        end;

        local success, result = pcall(function() -- Line: 99
            -- upvalues: u16 (copy), MarketplaceService (ref), u15 (copy)
            if u16 == Enum.InfoType.Subscription then
                return MarketplaceService:GetSubscriptionProductInfoAsync(u15);
            end;

            return MarketplaceService:GetProductInfoAsync(u15, u16);
        end);

        if not success then
            return nil;
        end;

        u6[u15] = result;

        return result;
    end;

    u2.OnClientEvent:Connect(function(p17: string, p18: any) -- Line: 116
        -- upvalues: u1 (ref)
        u1:UpdateClientInfo(p17, p18);
    end);
end;

return u1;