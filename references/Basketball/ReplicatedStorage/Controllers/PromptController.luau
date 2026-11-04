 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local LocalPlayer = Players.LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Packages.Trove);
local u1 = nil;
local u2 = Knit.CreateController({
    Name = "PromptController"
});

function u2.RepeatGetProductInfo(...) -- Line: 15
    -- upvalues: MarketplaceService (copy)
    local u3 = nil;

    while true do
        local success = pcall(function(...) -- Line: 19
            -- upvalues: u3 (ref), MarketplaceService (ref)
            u3 = MarketplaceService:GetProductInfo(...);
        end, ...);

        if u3 == nil then
            task.wait(1);
        end;

        if u3 ~= nil and success == true then
            return u3;
        end;
    end;
end;

function u2.SpawnPurchasePrompt(p4, p5, u6, u7, p8, p9, u10) -- Line: 30
    -- upvalues: u2 (copy), LocalPlayer (copy), u1 (ref), MarketplaceService (copy)
    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.MaxActivationDistance = 15;
    ProximityPrompt.ActionText = p5;
    ProximityPrompt.ObjectText = p9 or "";
    ProximityPrompt.HoldDuration = 0;
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.Parent = p4;

    if u6 then
        if u6 == "Asset" then
            local v11 = u2.RepeatGetProductInfo(u7, Enum.InfoType.Asset);
            ProximityPrompt.ObjectText = `{utf8.char(57346)}{v11.PriceInRobux}`;
        else
            local v12 = u2.RepeatGetProductInfo(u7, Enum.InfoType.GamePass);
            ProximityPrompt.ObjectText = `{utf8.char(57346)}{v12.PriceInRobux}`;
        end;
    elseif u7 then
        local v13 = u2.RepeatGetProductInfo(u7, Enum.InfoType.Product);
        ProximityPrompt.ObjectText = `{utf8.char(57346)}{v13.PriceInRobux}`;
    end;

    if p8 ~= true then
        ProximityPrompt.Triggered:Connect(function(p14) -- Line: 55
            -- upvalues: LocalPlayer (ref), u10 (copy), u6 (copy), u1 (ref), u7 (copy), MarketplaceService (ref)
            if p14 ~= LocalPlayer then
                return;
            end;

            if u10 then
                u10();

                return;
            end;

            if not u6 then
                MarketplaceService:PromptProductPurchase(p14, u7);

                return;
            end;

            if u6 == "Asset" then
                if u1.Player.OwnedAssets[u7] then
                    return;
                end;

                MarketplaceService:PromptPurchase(p14, u7);

                return;
            end;

            if u1.Player.OwnedGamepasses[u7] then
                return;
            end;

            MarketplaceService:PromptGamePassPurchase(p14, u7);
        end);
    end;

    return ProximityPrompt;
end;

function u2.SpawnSubscriptionPrompt(p15, p16, u17, p18, p19, u20) -- Line: 78
    -- upvalues: MarketplaceService (copy), LocalPlayer (copy), u1 (ref)
    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.MaxActivationDistance = 15;
    ProximityPrompt.ActionText = p16;
    ProximityPrompt.ObjectText = p19 or "";
    ProximityPrompt.HoldDuration = 0;
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.Parent = p15;
    local success, result = pcall(function() -- Line: 87
        -- upvalues: MarketplaceService (ref), u17 (copy)
        return MarketplaceService:GetSubscriptionProductInfoAsync(u17);
    end);

    if success then
        ProximityPrompt.ObjectText = `{utf8.char(57346)}{result.PriceInRobux}`;

        if p18 ~= true then
            ProximityPrompt.Triggered:Connect(function(p21) -- Line: 95
                -- upvalues: LocalPlayer (ref), u20 (copy), u1 (ref), MarketplaceService (ref), u17 (copy)
                if p21 ~= LocalPlayer then
                    return;
                end;

                if u20 then
                    u20();

                    return;
                end;

                if p21 ~= LocalPlayer then
                    return;
                end;

                if u1.Player.IsVIPSubscribed then
                    return;
                end;

                MarketplaceService:PromptSubscriptionPurchase(p21, u17);
            end);
        end;

        ProximityPrompt.ObjectText = `{utf8.char(57346)}{result.PriceInRobux}`;
    end;

    if success then
        success = result.PriceInRobux;
    end;

    return ProximityPrompt, success;
end;

function u2.KnitStart(p22) -- Line: 113
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetController("Network");
end;

return u2;