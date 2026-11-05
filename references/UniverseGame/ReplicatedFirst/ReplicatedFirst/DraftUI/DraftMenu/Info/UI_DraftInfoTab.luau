  

 

return function(u1) -- Line: 2
    local ItemData = require(game.ReplicatedStorage.ReplicatedModules.ItemData);
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local StandsModule = require(PathShortcuts.StandsModule);
    require(PathShortcuts.KnitPath.Trove);
    local StatsHandler = require(PathShortcuts.ReplicatedModules.StatsHandler);
    local Parent = script.Parent;
    local Buttons = Parent.Buttons;
    local Description = Parent.Description;
    local Label = Parent.Label;
    local Rarity = Parent.Rarity;
    local u2 = u1.Knit.GetService("AbilityDraftService");
    local u3 = nil;
    u2:GetPhase():andThen(function(p4) -- Line: 18
        -- upvalues: u3 (ref)
        u3 = p4;
    end);

    function u1.SetPhase(p5) -- Line: 22
        -- upvalues: u3 (ref)
        u3 = p5;
    end;

    local u6 = nil;
    local u7 = nil;
    local u8 = nil;
    Buttons.Button.MouseButton1Click:Connect(function() -- Line: 28
        -- upvalues: u3 (ref), u6 (ref), u8 (ref), u2 (copy), u1 (copy), u7 (ref)
        warn("CLICKED");

        if u3 == "BanPhase" and (not u6 and type(u8) == "number") then
            warn(u3, u8, "Banning");
            u2.Signal:Fire("BanAbility", u8);

            if u2:IsBanned(u8):expect() then
                u6 = true;
                u1.DraftSignal:Fire("DraftBanned");
                u1.SetDraftInfoTabDefault();
            end;
        elseif u3 == "PickPhase" and (not u7 and type(u8) == "number") then
            warn(u3, u8, "Picking");
            u2.Signal:Fire("LockAbility", u8);

            if u2:IsPicked(u8):expect() then
                u7 = true;
                u1.DraftSignal:Fire("DraftPicked");
                u1.SetDraftInfoTabDefault();
            end;
        end;
    end);

    function u1.SetDraftInfoTab(p9) -- Line: 49
        -- upvalues: u8 (ref), StatsHandler (copy), StandsModule (copy), Label (copy), ItemData (copy), Rarity (copy), Description (copy), u3 (ref), Buttons (copy), u6 (ref), u7 (ref), Parent (copy)
        local ItemInfo = p9.ItemInfo;
        u8 = tonumber(p9.AbilityId);

        if not u8 then
            return;
        end;

        local v10 = StatsHandler.GetStats(StandsModule[p9.AbilityId]);
        Label.Text = tostring(ItemInfo.DisplayName or ItemInfo.Name);
        local v11 = ItemData.Rarities[ItemInfo.Rarity];
        Rarity.Text = v11.Name;
        Rarity.TextColor3 = v11.Color;
        Description.Label.Text = ItemInfo.Description;

        if #Description.Label.Text > 0 then
            local Label2 = Description.Label;
            Label2.Text = Label2.Text .. "\n";
        end;

        if ItemInfo.Type == "Ability" and (v10 and (v10.Moveset and v10.Moveset.Moves)) then
            local Label2 = Description.Label;
            Label2.Text = Label2.Text .. "Moveset:\n";

            for i, v in pairs(v10.Moveset.Moves) do
                local Label3 = Description.Label;
                Label3.Text = Label3.Text .. string.format("[ %s ] = %s\n", i, v);
            end;
        end;

        if u3 == "BanPhase" then
            Buttons.Button.TextLabel.Text = u6 and "" or "Ban Ability";
        elseif u3 == "PickPhase" then
            Buttons.Button.TextLabel.Text = u7 and "" or "Lock Ability";
        end;

        Parent.Visible = true;
    end;

    function u1.SetDraftInfoTabDefault() -- Line: 78
        -- upvalues: u8 (ref), Label (copy), Rarity (copy), Description (copy), Buttons (copy), Parent (copy)
        u8 = nil;
        Label.Text = "";
        Rarity.Text = "";
        Description.Label.Text = "";
        Buttons.Button.TextLabel.Text = "";
        Parent.Visible = false;
    end;

    u1.SetDraftInfoTabDefault();
end;