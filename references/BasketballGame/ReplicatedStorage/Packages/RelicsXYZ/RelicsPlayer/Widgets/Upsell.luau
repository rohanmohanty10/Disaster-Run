 
 

local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local Parent = script.Parent.Parent;
local Components = Parent.Components;
local Button = require(Components.Button);
local View3D = require(Components.View3D);
local MiniPlayer = require(Components.MiniPlayer);
local Shared = Parent.Parent.Shared;
local Hooks = Parent.Hooks;
local Enums = require(Parent.Enums);
local State = require(Parent.State);
local React = require(Shared.React);
local useClock = require(Hooks.useClock);
local useBoomboxData = require(Hooks.useBoomboxData);

local function BuyButton(u1: table) -- Line: 28
    -- upvalues: React (copy), State (copy), Button (copy), Players (copy), MarketplaceService (copy)
    local Theme = React.useContext(State.Context).Theme;

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        LayoutOrder = 4,
        Size = UDim2.fromOffset(96, 22)
    }, {
        Buy = React.createElement(Button, {
            BackgroundTransparency = 0,
            AutoButtonColor = false,
            HoverScale = 1.05,
            PressScale = 0.95,
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Theme.Colors.WHITE,
            AnchorPoint = Vector2.one / 2,

            OnActivated = function() -- Line: 47, Name: OnActivated
                -- upvalues: Players (ref), MarketplaceService (ref), u1 (copy)
                local LocalPlayer = Players.LocalPlayer;

                if LocalPlayer then
                    MarketplaceService:PromptPurchase(LocalPlayer, u1.AssetId);
                end;
            end
        }, {
            Corner = React.createElement("UICorner", {
                CornerRadius = UDim.new(1, 0)
            }),
            Text = React.createElement("TextLabel", {
                TextSize = 12,
                Text = "BUY BOOMBOX",
                BackgroundTransparency = 1,
                TextColor3 = Theme.Colors.BLACK,
                FontFace = Theme.Fonts.Bold,
                Size = UDim2.fromScale(1, 1)
            })
        })
    });
end;

return function(p2) -- Line: 71, Name: Upsell
    -- upvalues: React (copy), State (copy), useBoomboxData (copy), Enums (copy), useClock (copy), View3D (copy), BuyButton (copy), MiniPlayer (copy)
    local v3 = React.useContext(State.Context);
    local Status = v3.Status;
    local Theme = v3.Theme;
    local WindowState = v3.WindowState;
    local u4 = useBoomboxData();
    local v5 = WindowState == Enums.WindowState.Full;
    local v6 = u4 and (u4.AssetId or 0) or 0;
    useClock(30, function() -- Line: 82
        -- upvalues: u4 (copy)
        local v7 = u4 and u4.Model;

        if v7 then
            local CFrame_Angles = CFrame.Angles;
            local v8 = os.clock() / 2;
            v7:PivotTo((CFrame_Angles(0, 3.141592653589793 + math.sin(v8) / 1.5, 0)));
        end;
    end);

    if Status == Enums.UserStatus.BoomboxPurchased then
        v3.SetWindowTab(Enums.WindowTab.Browse);

        return nil;
    end;

    local createElement = React.createElement;
    local Fragment = React.Fragment;
    local v9 = {};
    local v10 = {};
    local createElement2 = React.createElement;
    local v11 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 1, -70),
        AnchorPoint = Vector2.xAxis / 2,
        Position = UDim2.fromScale(0.5, 0)
    };
    local v12 = {
        Corner = React.createElement("UICorner", {
            CornerRadius = Theme.Tweaks.PanelCornerRadius
        }),
        Background = React.createElement("Folder", {}, {
            Image = React.createElement("ImageLabel", {
                BackgroundTransparency = 1,
                ZIndex = 0,
                Size = UDim2.fromScale(1, 1),
                Image = Theme.Images.Background,
                ScaleType = Enum.ScaleType.Crop
            })
        }),
        List = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 4)
        })
    };
    local createElement3 = React.createElement;
    local v13 = {
        BackgroundTransparency = 1,
        ZIndex = 1,
        Size = UDim2.fromScale(1, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeYY
    };
    local v14 = {};
    local createElement4 = React.createElement;
    local v15 = {
        Transparency = 0.1,
        FieldOfView = 15,
        ZoomScale = 1
    };

    if u4 then
        u4 = u4.Model;
    end;

    v15.Model = u4;
    v14.Render = createElement4(View3D, v15);
    v12.Boombox = createElement3("Frame", v13, v14);
    local createElement5 = React.createElement;
    local v16 = {
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        ZIndex = 2,
        Position = UDim2.fromScale(0.6, 0),
        Size = UDim2.fromScale(v5 and 0.5 or 0.4, 1)
    };
    local v17 = {
        List = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, v5 and 10 or 5)
        }),
        Title = React.createElement("TextLabel", {
            Text = "Purchase your Boombox",
            BackgroundTransparency = 1,
            LayoutOrder = 0,
            TextColor3 = Theme.Colors.WHITE,
            AutomaticSize = Enum.AutomaticSize.Y,
            FontFace = Theme.Fonts.Bold,
            TextSize = v5 and 17 or 12,
            Size = UDim2.fromScale(1, 0)
        }),
        Description = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            LineHeight = 1.4,
            LayoutOrder = 1,
            Text = table.concat({ v5 and "Unlock exclusive playlists" or "Exclusive playlists", v5 and "Unlock song search" or "Song search", v5 and "Unlock customization" or "Customizations" }, "\n"),
            TextColor3 = Theme.Colors.GRAY,
            AutomaticSize = Enum.AutomaticSize.Y,
            FontFace = Theme.Fonts.Regular,
            TextSize = v5 and 13 or 10,
            Size = UDim2.fromScale(1, 0)
        })
    };
    local v18;

    if v5 then
        v18 = React.createElement(BuyButton, {
            AssetId = v6
        });
    else
        v18 = v5;
    end;

    v17.Button = v18;
    v12.Info = createElement5("Frame", v16, v17);
    local v19 = not v5 and React.createElement(BuyButton, {
        AssetId = v6
    });
    v12.BuyButton = v19;
    v10.Upsell = createElement2("CanvasGroup", v11, v12);
    v10.MiniPlayer = React.createElement(MiniPlayer, {
        Position = UDim2.new(0.5, 0, 1, -10),
        AnchorPoint = Vector2.new(0.5, 1)
    });

    return createElement(Fragment, v9, v10);
end;