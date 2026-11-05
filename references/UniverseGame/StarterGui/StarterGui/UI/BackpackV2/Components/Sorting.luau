  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedStorage.ReplicatedModules.Types);
require("../Lib/Types");
local Assets = script.Parent.Parent.Assets;

local function IsFavorite(p1) -- Line: 13
    return p1.Locked == true;
end;

local u20 = {
    ["Rarity (Desc.)"] = {
        Color = Color3.fromRGB(174, 198, 255),

        PriorityFn = function(p2) -- Line: 22, Name: PriorityFn
            return (p2.Locked == true and 1000000 or 0) + (p2.Rarity or 0) * 1000;
        end,

        Tiebreaker = function(p3, p4) -- Line: 27, Name: Tiebreaker
            return p3._lcName < p4._lcName;
        end
    },
    ["Rarity (Asc.)"] = {
        Color = Color3.fromRGB(174, 198, 255),

        PriorityFn = function(p5) -- Line: 34, Name: PriorityFn
            return (p5.Locked == true and 1000000 or 0) + -(p5.Rarity or 0) * 1000;
        end,

        Tiebreaker = function(p6, p7) -- Line: 39, Name: Tiebreaker
            return p6._lcName < p7._lcName;
        end
    },
    ["A - Z"] = {
        Color = Color3.fromRGB(174, 198, 255),

        PriorityFn = function(p8) -- Line: 46, Name: PriorityFn
            return p8.Locked == true and 1000000 or 0;
        end,

        Tiebreaker = function(p9, p10) -- Line: 49, Name: Tiebreaker
            return p9._lcName < p10._lcName;
        end
    },
    ["Z - A"] = {
        Color = Color3.fromRGB(174, 198, 255),

        PriorityFn = function(p11) -- Line: 56, Name: PriorityFn
            return p11.Locked == true and 1000000 or 0;
        end,

        Tiebreaker = function(p12, p13) -- Line: 59, Name: Tiebreaker
            return p12._lcName > p13._lcName;
        end
    },
    ["Date Created"] = {
        Color = Color3.fromRGB(174, 198, 255),

        PriorityFn = function(p14) -- Line: 66, Name: PriorityFn
            local v15 = p14.Locked == true and 1000000 or 0;
            local v16 = p14.Identifier:split("/")[2];
            local v17 = tonumber(v16) or 0;

            return v15 * 100 + v17;
        end,

        Tiebreaker = function(p18, p19) -- Line: 72, Name: Tiebreaker
            return p18._lcName < p19._lcName;
        end
    }
};

return function(p21, u22) -- Line: 78
    -- upvalues: Fusion (copy), Assets (copy), u20 (copy)
    local u23 = Fusion.Value(false);
    local v24 = p21:FindFirstChild("Dropdown") or Assets.Dropdown:Clone();

    if u22.ActiveSort:get() == nil then
        u22.ActiveSort:set(u20["Rarity (Desc.)"]);
        u22.ActiveSortName:set("Rarity (Desc.)");
    end;

    Fusion.Hydrate(p21)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 88
            -- upvalues: u23 (copy)
            u23:set(not u23:get());
        end,

        [Fusion.Children] = { v24 },
        Text = Fusion.Computed(function() -- Line: 95
            -- upvalues: u22 (copy)
            return `Sort by: {u22.ActiveSortName:get()}`;
        end)
    });
    Fusion.Hydrate(v24)({
        Visible = u23,
        Size = Fusion.Spring(Fusion.Computed(function() -- Line: 103
            -- upvalues: u23 (copy)
            return u23:get() and UDim2.new(1, 16, 8, 0) or UDim2.new(1, 16, 0, 0);
        end), 37.5, 0.9)
    });
    Fusion.Hydrate(v24.Items)({
        [Fusion.Children] = Fusion.ForPairs(u20, function(u25, u26) -- Line: 109
            -- upvalues: Assets (ref), Fusion (ref), u22 (copy), u23 (copy)
            local Color = u26.Color;
            local v27 = Assets.DropdownItem:Clone();
            local v28 = Fusion.Computed(function() -- Line: 113
                -- upvalues: u22 (ref), u25 (copy)
                return u22.ActiveSortName:get() == u25 and 0.6 or 0.9;
            end);
            Fusion.Hydrate(v27)({
                BackgroundColor3 = Color,

                [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 123
                    -- upvalues: u22 (ref), u25 (copy), u26 (copy), u23 (ref)
                    u22.ActiveSortName:set(u25);
                    u22.ActiveSort:set(u26);
                    u23:set(false);
                end,

                Visible = true
            });
            Fusion.Hydrate(v27.Label)({
                Text = u25,
                TextColor3 = Color
            });
            Fusion.Hydrate(v27)({
                BackgroundColor3 = Color,
                BackgroundTransparency = Fusion.Spring(v28, 40, 0.975)
            });
            Fusion.Hydrate(v27.UIStroke)({
                Color = Color
            });

            return u25, v27;
        end, Fusion.cleanup)
    });

    return p21;
end;