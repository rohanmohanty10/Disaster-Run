  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local u2 = u1.Knit.GetService("ShopService");
    local MarketplaceService = game:GetService("MarketplaceService");
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local v3 = table.find(PathShortcuts.TestPlaces, game.PlaceId);
    Parent.Visible = false;

    if v3 then
        Parent.Visible = true;
    else
        local _, v4 = xpcall(function() -- Line: 16
            -- upvalues: MarketplaceService (copy), LocalPlayer (copy), u2 (copy)
            return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 939773206) or u2:OwnsGamepass(LocalPlayer.UserId, 939773206):expect();
        end, warn);

        if typeof(v4) == "boolean" and v4 then
            Parent.Visible = true;
        end;
    end;

    Parent.MouseButton1Click:Connect(function() -- Line: 26
        -- upvalues: u1 (copy), u2 (copy)
        u1:PlaySound("Click");
        u2:RequestSmartAssistant():expect();
    end);
end;