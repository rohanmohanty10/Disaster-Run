  

 

return function(u1) -- Line: 1
    local _ = u1.Xtal;
    game:GetService("SoundService");
    game:GetService("TextService");
    local PolicyService = game:GetService("PolicyService");
    local success, result = pcall(function() -- Line: 8
        -- upvalues: PolicyService (copy), u1 (copy)
        return PolicyService:GetPolicyInfoForPlayerAsync(u1.Player);
    end);
    u1.CanBuyPaidRandomItems = false;
    u1.CanTradePaidItems = false;
    u1.PolicyError = false;

    if success then
        u1.CanBuyPaidRandomItems = not result.ArePaidRandomItemsRestricted;
        u1.CanTradePaidItems = result.IsPaidItemTradingAllowed;
        u1.PolicyError = false;

        return;
    end;

    u1.CanBuyPaidRandomItems = false;
    u1.CanTradePaidItems = false;
    u1.PolicyError = true;
end;