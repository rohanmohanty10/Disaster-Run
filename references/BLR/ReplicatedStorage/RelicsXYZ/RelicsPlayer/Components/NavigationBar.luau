  

local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local Shared = Parent.Parent.Shared;
local Enums = require(Parent.Enums);
local State = require(Parent.State);
local React = require(Shared.React);
local TabButton = require(script_Parent.TabButton);

return function(u1: table) -- Line: 21, Name: NavigationBar
    -- upvalues: React (copy), State (copy), Enums (copy), TabButton (copy)
    local u2 = React.useContext(State.Context);
    local Features = u2.Features;
    local Theme = u2.Theme;
    local WindowTab = u2.WindowTab;
    local v3 = {
        List = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Padding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, 12)
        })
    };
    local v4 = u1.Scale and React.createElement("UIScale", {
        Scale = u1.Scale
    });
    v3.Scale = v4;
    local v5 = u1.Scale and React.createElement("UICorner", {
        CornerRadius = UDim.new(0, 9)
    });
    v3.Corner = v5;
    local v6 = {};

    if not (Features.Emotes or Features.Skins) then
        v6.Upgrades = true;
    end;

    if not Features.Auras then
        v6.Auras = true;
    end;

    if not Features.Favorites then
        v6.Favorites = true;
    end;

    for i, v in pairs(Enums.WindowTab) do
        if Theme.Images.NavBar[i] and not v6[i] then
            v3[i] = React.createElement(TabButton, {
                Tab = i,
                Order = v,
                Active = WindowTab == v,
                Spin = i == "Auras",

                OnActivated = function() -- Line: 81, Name: OnActivated
                    -- upvalues: u1 (copy), i (copy), v (copy), u2 (copy)
                    if u1.OnActivated then
                        u1.OnActivated(i, v);

                        return;
                    end;

                    u2.SetWindowTab(v);
                end
            });
        end;
    end;

    return React.createElement("Frame", {
        BorderSizePixel = 0,
        ZIndex = 1,
        Size = u1.Size or UDim2.new(1, 0, 0, 56),
        BackgroundColor3 = Theme.Colors.BACKGROUND_HEADER_FOOTER,
        Position = u1.Position or UDim2.fromScale(0.5, 0.5),
        AnchorPoint = u1.AnchorPoint or Vector2.one / 2
    }, v3, {
        Corner = React.createElement("UICorner", {
            CornerRadius = UDim.new(0, 9)
        }),
        Ignore = React.createElement("Folder", {}, {
            Upper = React.createElement("Frame", {
                BorderSizePixel = 0,
                ZIndex = 2,
                BackgroundColor3 = Theme.Colors.BACKGROUND_HEADER_FOOTER,
                Size = UDim2.new(1, 0, 0, 9)
            })
        })
    });
end;