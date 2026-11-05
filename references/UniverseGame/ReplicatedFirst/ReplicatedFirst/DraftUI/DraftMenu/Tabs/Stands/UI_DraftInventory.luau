  

 

return function(u1) -- Line: 2
    local Parent = script.Parent;
    local BanList = Parent.Parent.Parent.BanList;
    local Container = script.Parent.Parent.Parent.Assets.Container;
    local ReplicatedStorage = game:GetService("ReplicatedStorage");
    local PathShortcuts = require(ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("PathShortcuts"));
    local ItemData = require(ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("ItemData"));
    local Trove = require(PathShortcuts.KnitPath.Trove);
    warn("DRAFT INV LOADED");
    local u2 = {};
    local u3 = {};

    local function RemoveSlot(p4, p5) -- Line: 17
        local v6 = tostring(p5);
        local v7 = p4[v6];

        if not v7 then
            return;
        end;

        v7.Trove:Destroy();
        p4[v6] = nil;
    end;

    local function AddSlot(p8, p9, p10) -- Line: 25
        -- upvalues: ItemData (copy), Trove (copy), Container (copy), u3 (copy), u1 (copy)
        local u11 = tostring(p9);

        if p8[u11] then
            return;
        end;

        local v12 = ItemData.GetAbility(u11);
        local u13 = ItemData.GetItemInfo(v12.ItemId);

        if u13 and u13.Type == "Ability" then
            local v14 = Trove.new();
            local v15 = v14:Clone(Container);
            v15.Name = u13.Name;
            v15.Button.Label.Text = u13.Name or "";
            v15.Button.Label.Visible = true;
            v15.Button.UIStroke.UIGradient.Enabled = true;
            v15.Button.UIStroke.RarityGradient.Enabled = false;
            v15.Button.UIStroke.Color = Color3.new(1, 1, 1);

            if p8 ~= u3 then
                v14:Add(v15.Button.MouseButton1Down:Connect(function() -- Line: 55
                    -- upvalues: u1 (ref), u13 (copy), u11 (ref)
                    u1.SetDraftInfoTab({
                        ItemInfo = u13,
                        AbilityId = u11
                    });
                end));
            end;

            v15.Visible = true;
            v15.Parent = p10;
            v14:Add(v15);
            p8[u11] = {
                Container = v15,
                Trove = v14,
                ItemId = v12.ItemId
            };
        end;
    end;

    local v16 = u1.Knit.GetService("AbilityDraftService");
    u1.DraftSignal:Connect(function(p17, p18) -- Line: 79
        -- upvalues: u2 (copy), AddSlot (copy), u3 (copy), BanList (copy), u1 (copy)
        if p17 == "Banned" and type(p18) == "table" then
            for _, v in ipairs(p18) do
                local v19 = u2;
                local v20 = tostring(v);
                local v21 = v19[v20];

                if v21 then
                    v21.Trove:Destroy();
                    v19[v20] = nil;
                end;

                AddSlot(u3, v, BanList);
            end;

            return;
        end;

        if p17 ~= "AbilityLocked" or not p18.AbilityId then
            if p17 == "DraftFinished" then
                u1.UI:Destroy();
            end;

            return;
        end;

        local v22 = u2;
        local v23 = tostring(p18.AbilityId);
        local v24 = v22[v23];

        if not v24 then
            return;
        end;

        v24.Trove:Destroy();
        v22[v23] = nil;
    end);
    warn("REQUESTING ABILITY DRAFT");
    v16:GetAbilities():andThen(function(p25) -- Line: 93
        -- upvalues: AddSlot (copy), u2 (copy), Parent (copy)
        warn("DRAFT LIST FOUND");

        for i, _ in pairs(p25) do
            AddSlot(u2, i, Parent);
        end;
    end);
end;