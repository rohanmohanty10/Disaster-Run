 
 

local Parent = script.Parent.Parent;
local Enums = require(Parent.Enums);
local State = require(Parent.State);
local Parent2 = Parent.Parent;
local Shared = Parent2.Shared;
local Components = Parent.Components;
local Button = require(Components.Button);
local ScrollFrame = require(Components.ScrollFrame);
local React = require(Shared.React);
local u1 = require(Parent2);
local Settings = require(Shared.Settings);
local ReactSpring = require(Shared.ReactSpring);
local Hooks = Parent.Hooks;
local useFeatures = require(Hooks.useFeatures);
local useSettings = require(Hooks.useSettings);

local function SettingsItem(p2: table) -- Line: 33
    -- upvalues: React (copy), State (copy), Enums (copy), ReactSpring (copy), Button (copy)
    local v3 = React.useContext(State.Context);
    local Theme = v3.Theme;
    local Status = v3.Status;
    local v4 = Status == Enums.UserStatus.Freemium and true or (not p2.Setting.RequiresBoombox and true or Status == Enums.UserStatus.BoomboxPurchased);
    local Value = p2.Value;
    local Setting = p2.Setting;
    local Order = Setting.Order;
    local v5 = ReactSpring.useSpring({
        from = {
            Active = Value and 1 or 0
        },
        to = {
            Active = Value and 1 or 0
        },
        config = {
            tension = 800,
            friction = 30
        }
    });
    local createElement = React.createElement;
    local v6 = {
        BackgroundTransparency = 0,
        BorderSizePixel = 0
    };
    local v7;

    if Order % 2 == 0 then
        v7 = Theme.Colors.BACKGROUND_MID_PANEL;
    else
        v7 = Theme.Colors.BACKGROUND_FORE_PANEL;
    end;

    v6.BackgroundColor3 = v7;
    local v8;

    if v4 then
        v8 = p2.OnActivated;
    else
        v8 = nil;
    end;

    v6.OnActivated = v8;
    v6.AutoButtonColor = v4;
    v6.Size = UDim2.new(1, 0, 0, 50);
    v6.LayoutOrder = Setting.Order;
    v6.Active = v4;
    v6.HoverScale = v4 and 1.05 or 1;
    v6.PressScale = v4 and 0.95 or 1;

    return createElement(Button, v6, {
        Info = React.createElement("CanvasGroup", {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.yAxis / 2,
            AutomaticSize = Enum.AutomaticSize.XY,
            Position = UDim2.fromScale(0.1, 0.5)
        }, {
            List = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            Title = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                LayoutOrder = 0,
                TextSize = 14,
                TextTransparency = v4 and 0 or 0.75,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextColor3 = Theme.Colors.TEXT,
                FontFace = Theme.Fonts.Regular,
                Text = Setting.Title
            }),
            Description = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                LayoutOrder = 1,
                TextSize = 12,
                TextTransparency = v4 and 0 or 0.5,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextColor3 = Theme.Colors.GRAY,
                FontFace = Theme.Fonts.Regular,
                Text = Setting.Description
            })
        }),
        Icon = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(30, 30),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.875, 0.5),
            ImageColor3 = v5.Active:map(function(p9: number) -- Line: 123
                -- upvalues: Theme (copy)
                return Theme.Colors.GRAY:lerp(Theme.Colors.ACTIVE, p9);
            end),
            ImageTransparency = v4 and 0 or 0.75,
            ScaleType = Enum.ScaleType.Fit,
            Image = Setting.Icon
        })
    });
end;

return function(p10) -- Line: 134, Name: SettingsWidget
    -- upvalues: useSettings (copy), useFeatures (copy), Settings (copy), React (copy), SettingsItem (copy), u1 (copy), ScrollFrame (copy)
    local v11 = useSettings();
    local v12 = useFeatures();
    local v13 = {};

    for i, v in Settings do
        local u14 = v11[i];
        local u15 = false;
        local v16 = true;
        local RequiredFeatures = v.RequiredFeatures;
        local v17, u18;

        if RequiredFeatures then
            v17 = v;
            u18 = i;

            for i2 in RequiredFeatures do
                if not v12[i2] then
                    v16 = false;
                    break;
                end;
            end;
        else
            v17 = v;
            u18 = i;
        end;

        if v16 then
            v13[u18] = React.createElement(SettingsItem, {
                Key = u18,
                Value = u14,
                Setting = v17,

                OnActivated = function() -- Line: 164, Name: OnActivated
                    -- upvalues: u15 (ref), u1 (ref), u18 (copy), u14 (copy)
                    if not u15 then
                        u15 = true;
                        u1.ChangeSettingAsync(u18, not u14);
                    end;
                end
            });
        end;
    end;

    return React.createElement(ScrollFrame, {
        BackgroundTransparency = 1,
        ScrollBarThickness = 4,
        BorderSizePixel = 0,
        Size = p10.Size or UDim2.new(1, -16, 1, -16),
        Position = p10.Position or UDim2.fromScale(0.5, 0.5),
        AnchorPoint = p10.AnchorPoint or Vector2.one / 2,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.fromScale(1, 0),
        List = {
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }
    }, v13);
end;