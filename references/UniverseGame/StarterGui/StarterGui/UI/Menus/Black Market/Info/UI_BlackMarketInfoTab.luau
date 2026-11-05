  

 

return function(u1) -- Line: 1
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    require(PathShortcuts.StandsModule);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    local InfoTabHandler = require(script.InfoTabHandler);
    local Parent = script.Parent;
    local u2 = InfoTabHandler.new(Parent, Trove, u1);
    local u3 = nil;
    local u4 = nil;
    local u5 = nil;
    local u6 = nil;

    function u1.SetBlackMarketInfoTab(p7) -- Line: 11
        -- upvalues: u2 (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Parent (copy)
        u2:Clean();
        u3 = p7.ItemInfo;
        u4 = p7.ItemId;
        u5 = p7.ItemCount;
        u6 = p7.Purity;
        u2:CreateBlackMarketInfoTab(u3, u4, u5, p7.ActualGui, u6, p7);
        Parent.Visible = true;
    end;

    function u1.HideBlackMarketInfoTab(p8) -- Line: 19
        -- upvalues: u2 (copy), Parent (copy)
        u2:Clean();
        Parent.Visible = false;
    end;

    u1.InventorySignals.ItemSelected:Connect(function(p9) -- Line: 24
        -- upvalues: u1 (copy)
        if p9.BlackMarket then
            if p9.ItemInfo then
                u1.SetBlackMarketInfoTab(p9);

                return;
            end;

            u1.HideBlackMarketInfoTab(p9);
        end;
    end);
end;