  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(u1) -- Line: 11
    -- upvalues: ReplicatedStorage (copy)
    local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local u2 = u1.Knit.GetService("InventoryService");
    u1.Knit.GetService("ShopService");
    local u3 = Core.GetClientService("LabService");
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local Items = Parent.Items;
    require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    require(PathShortcuts.KnitPath.Trove);
    require(ReplicatedStorage.ReplicatedModules.Types);
    local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
    local ExchangeData = require(ReplicatedStorage.ReplicatedModules.PVEPackage.LabData.ReputationInfo).ExchangeData;
    local u4 = Fusion.Value({});
    local u5 = Fusion.Value(0);
    local u6 = {};

    local function CreateItem(p7, p8) -- Line: 37
        -- upvalues: ExchangeData (copy), Assets (copy), u1 (copy)
        local v9 = ExchangeData[p7];

        if v9 then
            local v10 = Assets.Item:Clone();
            v10.ItemLabel.Text = u1:GetItemText(p7);
            v10.RepLabel.Text = `{v9}REP`;
            v10.Available.Text = `/ {p8}`;
            v10.LayoutOrder = -v9;

            if p8 < 1 then
                v10.Blank.Visible = true;
                v10.LayoutOrder = 1000 - v9;
                v10.Value.Interactable = false;
            end;

            v10.Visible = true;

            return v10;
        end;
    end;

    local function UpdateCounts(p11) -- Line: 59
        -- upvalues: u4 (copy)
        if typeof(p11) == "table" then
            u4:set(p11);
        end;
    end;

    local function UpdateTotal() -- Line: 65
        -- upvalues: u6 (copy), ExchangeData (copy), u5 (copy)
        local v12 = 0;

        for i, v in u6 do
            v12 = v12 + v * (ExchangeData[i] or 0);
        end;

        u5:set(v12);
    end;

    local function Normalize(p13) -- Line: 75
        return tonumber(p13) or 0;
    end;

    local function Show() -- Line: 97
        -- upvalues: Parent (copy), u2 (copy), u4 (copy), u1 (copy)
        if Parent.Visible then
            return;
        end;

        local v14 = u2:GetItemCounts("ItemInventory"):expect();

        if typeof(v14) == "table" then
            u4:set(v14);
        end;

        Parent.Visible = true;
        u1:ShowReputationProgress(1);
    end;

    Fusion.Hydrate(Items)({
        [Fusion.Children] = Fusion.ForPairs(ExchangeData, function(u15) -- Line: 120
            -- upvalues: u4 (copy), CreateItem (copy), Fusion (copy), u6 (copy), ExchangeData (copy), u5 (copy)
            local u16 = u4:get()[u15];
            local u17 = CreateItem(u15, u16 or 0);
            Fusion.Hydrate(u17.Value)({
                [Fusion.OnEvent("FocusLost")] = function() -- Line: 127
                    -- upvalues: u17 (copy), u16 (copy), u6 (ref), u15 (copy), ExchangeData (ref), u5 (ref)
                    local v18 = tonumber(u17.Value.Text) or 0;
                    local v19 = math.clamp(v18, 0, u16);
                    u17.Value.Text = v19;

                    if v19 > 0 then
                        u6[u15] = v19;
                    else
                        u6[u15] = nil;
                    end;

                    local v20 = 0;

                    for i, v in u6 do
                        v20 = v20 + v * (ExchangeData[i] or 0);
                    end;

                    u5:set(v20);
                end
            });

            return u15, u17;
        end, Fusion.cleanup)
    });
    Fusion.Hydrate(Parent.RepLabel)({
        Text = Fusion.Computed(function() -- Line: 148
            -- upvalues: u5 (copy)
            return `{u5:get()}REP`;
        end),
        TextColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 151
            -- upvalues: u5 (copy)
            return u5:get() > 0 and Color3.fromRGB(255, 195, 135) or Color3.fromRGB(255, 114, 114);
        end), 28, 0.8)
    });
    Fusion.Hydrate(Parent.Exchange)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 79, Name: Exchange
            -- upvalues: u6 (copy), u3 (copy), u2 (copy), ExchangeData (copy), u5 (copy), u4 (copy), EffectsHandler (copy)
            if not next(u6) then
                return;
            end;

            local v21 = u3:ExchangeSamples(u6):expect();
            local v22 = u2:GetItemCounts("ItemInventory"):expect();
            table.clear(u6);
            local v23 = 0;

            for i, v in u6 do
                v23 = v23 + v * (ExchangeData[i] or 0);
            end;

            u5:set(v23);

            if typeof(v22) == "table" then
                u4:set(v22);
            end;

            if typeof(v21) == "number" and (v21 > 0 and (workspace.NPCS:FindFirstChild("Lab NPCs") and workspace.NPCS:FindFirstChild("Lab NPCs"):FindFirstChild("Analytics Overseer"))) then
                EffectsHandler.CallEffect("NPC Talk", workspace.NPCS:FindFirstChild("Lab NPCs"):FindFirstChild("Analytics Overseer"), "Nice work.");
            end;
        end,

        BackgroundColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 159
            -- upvalues: u5 (copy)
            return u5:get() > 0 and Color3.fromRGB(50, 44, 29) or Color3.fromRGB(50, 24, 24);
        end), 28, 0.8),
        TextColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 162
            -- upvalues: u5 (copy)
            return u5:get() > 0 and Color3.fromRGB(255, 194, 119) or Color3.fromRGB(255, 96, 96);
        end), 28, 0.8)
    });
    Fusion.Hydrate(Parent.Exchange.UIStroke)({
        Color = Fusion.Spring(Fusion.Computed(function() -- Line: 168
            -- upvalues: u5 (copy)
            return u5:get() > 0 and Color3.fromRGB(255, 197, 146) or Color3.fromRGB(255, 96, 96);
        end), 28, 0.8)
    });
    Fusion.Hydrate(Parent.Close)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 108, Name: Hide
            -- upvalues: Parent (copy), u6 (copy), ExchangeData (copy), u5 (copy), u1 (copy)
            if not Parent.Visible then
                return;
            end;

            Parent.Visible = false;
            table.clear(u6);
            local v24 = 0;

            for i, v in u6 do
                v24 = v24 + v * (ExchangeData[i] or 0);
            end;

            u5:set(v24);
            u1:PlaySound("Click");
            u1:ShowReputationProgress(-1);
        end
    });

    function u1.ShowReputationExchange(p25) -- Line: 177
        -- upvalues: Parent (copy), u2 (copy), u4 (copy), u1 (copy)
        if Parent.Visible then
            return;
        end;

        local v26 = u2:GetItemCounts("ItemInventory"):expect();

        if typeof(v26) == "table" then
            u4:set(v26);
        end;

        Parent.Visible = true;
        u1:ShowReputationProgress(1);
    end;
end;