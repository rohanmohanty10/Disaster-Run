  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedStorage.ReplicatedModules.Types);
require("../Lib/Types");
local Assets = script.Parent.Parent.Assets;
local u6 = {
    Unusual = { Color3.fromRGB(79, 188, 255), function(p1) -- Line: 14
            return p1.UnusualInfo ~= nil;
        end },
    Premium = { Color3.fromRGB(255, 232, 116), function(p2) -- Line: 17
            return p2.Premium or false;
        end },
    Serial = { Color3.fromRGB(255, 131, 89), function(p3) -- Line: 20
            return p3.Serial ~= nil;
        end },
    Favorite = { Color3.fromRGB(255, 255, 43), function(p4) -- Line: 23
            return p4.Locked == true;
        end },
    Trait = { Color3.fromRGB(171, 255, 213), function(p5) -- Line: 26
            return p5.Trait ~= nil;
        end }
};
local u7 = Color3.fromRGB(56, 68, 124);

return function(p8, u9, p10) -- Line: 33
    -- upvalues: Fusion (copy), Assets (copy), u7 (copy), u6 (copy)
    local u11 = Fusion.Value(false);
    local v12 = p8:FindFirstChild("Dropdown") or Assets.Dropdown:Clone();
    local ActiveFilters = u9.ActiveFilters;
    local u13 = 0;
    Fusion.Hydrate(p8)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 41
            -- upvalues: u11 (copy), u9 (copy)
            u11:set(not u11:get());
            u9.UIEngine:PlaySound("Inventory/inv_click");
        end,

        [Fusion.Children] = { v12 },
        BackgroundColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 49
            -- upvalues: ActiveFilters (copy), u13 (ref), u7 (ref)
            ActiveFilters:get();

            return u13 > 0 and u7 or Color3.fromRGB(21, 27, 42);
        end), 25, 0.95)
    });
    Fusion.Hydrate(v12)({
        Visible = u11,
        Size = Fusion.Spring(Fusion.Computed(function() -- Line: 57
            -- upvalues: u11 (copy)
            return u11:get() and UDim2.new(1, 16, 8, 0) or UDim2.new(1, 16, 0, 0);
        end), 37.5, 0.9)
    });
    Fusion.Hydrate(v12.Items)({
        [Fusion.Children] = Fusion.ForPairs(p10 or u6, function(u14, p15) -- Line: 63
            -- upvalues: Assets (ref), Fusion (ref), ActiveFilters (copy), u13 (ref), u9 (copy)
            local v16 = p15[1];
            local u17 = p15[2];
            local v18 = Assets.DropdownItem:Clone();
            local v19 = Fusion.Computed(function() -- Line: 67
                -- upvalues: ActiveFilters (ref), u14 (copy)
                return ActiveFilters:get()[u14] and 0.6 or 0.9;
            end);
            Fusion.Hydrate(v18)({
                BackgroundColor3 = v16,

                [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 77
                    -- upvalues: ActiveFilters (ref), u14 (copy), u17 (copy), u13 (ref), u9 (ref)
                    local v20 = ActiveFilters:get();

                    if v20[u14] then
                        v20[u14] = nil;
                        u13 = u13 - 1;
                        ActiveFilters:set(v20);
                    else
                        v20[u14] = u17;
                        u13 = u13 + 1;
                        ActiveFilters:set(v20);
                    end;

                    u9.UIEngine:PlaySound("Inventory/inv_click");
                end,

                Visible = true
            });
            Fusion.Hydrate(v18.Label)({
                Text = u14,
                TextColor3 = v16
            });
            Fusion.Hydrate(v18)({
                BackgroundColor3 = v16,
                BackgroundTransparency = Fusion.Spring(v19, 40, 0.975)
            });
            Fusion.Hydrate(v18.UIStroke)({
                Color = v16
            });

            return u14, v18;
        end, Fusion.cleanup)
    });

    return p8;
end;