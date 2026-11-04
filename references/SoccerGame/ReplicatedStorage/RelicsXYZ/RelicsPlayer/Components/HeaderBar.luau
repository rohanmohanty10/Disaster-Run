  

local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local Button = require(script_Parent.Button);
local PlayButton = require(script_Parent.PlayButton);
local React = require(Parent.Parent.Shared.React);
local Hooks = Parent.Hooks;
local useMetadata = require(Hooks.useMetadata);
local useClock = require(Hooks.useClock);
local State = require(Parent.State);
local Enums = require(Parent.Enums);

local function SongInfo(p1: table) -- Line: 33
    -- upvalues: useMetadata (copy), React (copy), State (copy), useClock (copy)
    local Song = p1.Song;
    local v2 = useMetadata(Song);
    local u3 = React.useRef(nil);
    local Theme = React.useContext(State.Context).Theme;
    useClock(30, function(p4) -- Line: 41
        -- upvalues: u3 (copy)
        local v5 = os.clock() / 2;
        local v6 = math.sin(v5) / 2 + 0.5;
        local current = u3.current;

        if current then
            current.Position = UDim2.fromScale(v6, 0.5);
            current.AnchorPoint = Vector2.new(v6, 0.5);
        end;
    end);
    local createElement = React.createElement;
    local v7 = {
        ClipsDescendants = true,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Colors.BACKGROUND_HEADER_FOOTER,
        Position = UDim2.fromScale(0, 0.5),
        AnchorPoint = Vector2.yAxis / 2,
        Size = UDim2.fromScale(0.525, 1)
    };
    local v8 = {};
    local createElement2 = React.createElement;
    local v9 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(0, 1),
        AutomaticSize = Enum.AutomaticSize.X,
        ref = u3
    };
    local v10 = {};
    local v11;

    if Song then
        v11 = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            TextSize = 20,
            LayoutOrder = 1,
            Text = v2.Artist,
            TextColor3 = Theme.Colors.GRAY,
            TextXAlignment = Enum.TextXAlignment.Left,
            FontFace = Theme.Fonts.Regular,
            Size = UDim2.fromScale(0, 1),
            AutomaticSize = Enum.AutomaticSize.X,
            Position = UDim2.fromScale(1, 0.5),
            AnchorPoint = Vector2.new(1, 0.5)
        });
    else
        v11 = Song;
    end;

    v10.Artist = v11;

    if Song then
        Song = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            TextSize = 20,
            LayoutOrder = 2,
            Text = v2.Title,
            TextColor3 = Theme.Colors.TEXT,
            TextXAlignment = Enum.TextXAlignment.Right,
            FontFace = Theme.Fonts.Bold,
            Size = UDim2.fromScale(0, 1),
            AutomaticSize = Enum.AutomaticSize.X,
            Position = UDim2.fromScale(0, 0.5),
            AnchorPoint = Vector2.new(0, 0.5)
        });
    end;

    v10.Title = Song;
    v10.Padding = React.createElement("UIPadding", {
        PaddingLeft = UDim.new(0, 25),
        PaddingRight = UDim.new(0, 25)
    });
    v10.List = React.createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0.05, 0)
    });
    v8.Inside = createElement2("Frame", v9, v10);

    return createElement("Frame", v7, v8);
end;

return function(p12: table) -- Line: 113, Name: HeaderBar
    -- upvalues: React (copy), State (copy), Enums (copy), Button (copy), PlayButton (copy), SongInfo (copy)
    local u13 = React.useContext(State.Context);
    local v14 = u13.Status == Enums.UserStatus.TryBeforeBuy;
    local v15 = u13.Status == Enums.UserStatus.Freemium;
    local Widget = u13.Widget;
    local Theme = u13.Theme;

    if p12.MockBrand then
        p12.Branding = {
            Image = "rbxassetid://17420381909",
            Size = UDim2.fromOffset(125, 28)
        };
    end;

    local v16 = {
        List = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            HorizontalFlex = Enum.UIFlexAlignment.SpaceAround,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10)
        }),
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10)
        })
    };

    if u13.WindowState == Enums.WindowState.Minimized then
        local Song = u13.Song;
        v16.PlayButton = React.createElement(PlayButton, {
            LayoutOrder = 2,
            Size = UDim2.fromScale(1, 1)
        });
        v16.ForwardButton = React.createElement(Button, {
            LayoutOrder = 3,
            Image = Theme.Images.Forward,
            Size = UDim2.fromScale(1, 1),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            ImageColor3 = Theme.Colors.CONTROLS,
            OnActivated = u13.GoForward
        });
        v16.SongInfo = React.createElement(SongInfo, {
            Song = Song or ""
        });
    elseif Widget and (Widget.ReturnFunc and Widget.ReturnText) then
        v16.ReturnButton = React.createElement(Button, {
            Image = Theme.Images.Return,
            Size = UDim2.fromScale(1, 1),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            ImageColor3 = Theme.Colors.TEXT,

            OnActivated = function() -- Line: 156, Name: OnActivated
                -- upvalues: u13 (copy), Widget (copy)
                if #u13.ReturnEvent:GetConnections() > 0 then
                    u13.ReturnEvent:Fire();

                    return;
                end;

                if Widget.ReturnFunc then
                    Widget.ReturnFunc();
                end;
            end
        });
        local v17 = Widget.ReturnText and React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            TextSize = 16,
            Text = Widget.ReturnText,
            TextColor3 = Theme.Colors.GRAY,
            TextXAlignment = Enum.TextXAlignment.Left,
            FontFace = Theme.Fonts.Regular,
            Size = UDim2.fromScale(1, 1),
            SizeConstraint = Enum.SizeConstraint.RelativeYY
        }, {
            Flex = React.createElement("UIFlexItem", {
                FlexMode = Enum.UIFlexMode.Grow
            })
        });
        v16.ReturnText = v17;
    elseif p12.Branding then
        v16.Branding = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Size = p12.Branding.Size,
            Image = p12.Branding.Image,
            Position = UDim2.fromOffset(14, 9)
        });
    else
        v16.AppLogo = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            LayoutOrder = 0,
            Image = Theme.Images.Logo,
            Size = UDim2.fromScale(1.3, 1.3),
            SizeConstraint = Enum.SizeConstraint.RelativeYY
        });
        v16.Title = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            TextSize = 16,
            Text = "RELICSxyz Player" .. (v14 and " [Trial Mode]" or (v15 and " [Free Mode]" or "")),
            TextColor3 = Theme.Colors.GRAY,
            TextXAlignment = Enum.TextXAlignment.Left,
            FontFace = Theme.Fonts.Regular,
            Size = UDim2.fromScale(1, 1),
            SizeConstraint = Enum.SizeConstraint.RelativeYY
        }, {
            Flex = React.createElement("UIFlexItem", {
                FlexMode = Enum.UIFlexMode.Grow
            })
        });
    end;

    local v18 = Theme.Tweaks.ShowCollapseButton and React.createElement(Button, {
        LayoutOrder = 2,
        Size = UDim2.fromScale(1, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        ImageColor3 = Theme.Colors.GRAY,
        Image = Theme.Images.Compress,

        OnActivated = function() -- Line: 249, Name: OnActivated
            -- upvalues: u13 (copy), Enums (ref)
            if u13.WindowState == Enums.WindowState.Minimized then
                u13.SetWindowState(Enums.WindowState.Full);

                return;
            end;

            if u13.WindowState == Enums.WindowState.Full then
                u13.SetWindowState(Enums.WindowState.Compact);

                return;
            end;

            u13.SetWindowState(Enums.WindowState.Minimized);
        end
    });
    v16.Compress = v18;

    if u13.WindowState ~= Enums.WindowState.Minimized then
        local v19 = Theme.Tweaks.ShowCloseButton and React.createElement(Button, {
            LayoutOrder = 3,
            Size = UDim2.fromScale(1, 1),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            ImageColor3 = Theme.Colors.GRAY,
            Image = Theme.Images.Close,

            OnActivated = function() -- Line: 268, Name: OnActivated
                -- upvalues: u13 (copy), Enums (ref)
                u13.SetWindowState(Enums.WindowState.Hidden);
            end
        });
        v16.Close = v19;
    end;

    local createElement = React.createElement;
    local v20 = {
        BorderSizePixel = 0
    };
    local v21;

    if u13.WindowState == Enums.WindowState.Minimized then
        v21 = Theme.Colors.BACKGROUND_FORE_PANEL;
    else
        v21 = Theme.Colors.BACKGROUND_HEADER_FOOTER;
    end;

    v20.BackgroundColor3 = v21;
    v20.Size = p12.Size or UDim2.new(1, 0, 0, 43);
    v20.Position = p12.Position or UDim2.new();

    return createElement("Frame", v20, v16, {
        Corner = React.createElement("UICorner", {
            CornerRadius = UDim.new(0, 9)
        })
    });
end;