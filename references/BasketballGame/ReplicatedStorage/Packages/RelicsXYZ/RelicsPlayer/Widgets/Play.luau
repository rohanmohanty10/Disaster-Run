 
 

local Parent = script.Parent.Parent;
local Components = Parent.Components;
local Button = require(Components.Button);
local PlayButton = require(Components.PlayButton);
local Spectrogram = require(Components.Spectrogram);
local VolumeSlider = require(Components.VolumeSlider);
local DurationSlider = require(Components.DurationSlider);
local FavoriteButton = require(Components.FavoriteButton);
local Enums = require(Parent.Enums);
local State = require(Parent.State);
local Shared = Parent.Parent.Shared;
local React = require(Shared.React);
local ReactSpring = require(Shared.ReactSpring);
local Hooks = Parent.Hooks;
local useMetadata = require(Hooks.useMetadata);
local useComponent = require(Hooks.useComponent);

local function Default(p1) -- Line: 25
    -- upvalues: React (copy), State (copy), Enums (copy), useMetadata (copy), ReactSpring (copy), FavoriteButton (copy), Button (copy), DurationSlider (copy), PlayButton (copy), VolumeSlider (copy), Spectrogram (copy)
    local u2 = React.useContext(State.Context);
    local Features = u2.Features;
    local Theme = u2.Theme;
    local v3 = u2.WindowState == Enums.WindowState.Full;
    local Song = u2.Song;
    local v4 = useMetadata(Song);
    local v5 = ReactSpring.useSpring({
        Looped = u2.Looped and 1 or 0,
        config = {
            tension = 800,
            friction = 30
        }
    });
    local createElement = React.createElement;
    local v6 = {
        BackgroundTransparency = 0,
        BackgroundColor3 = Theme.Colors.BACKGROUND_FORE_PANEL,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, -15, 1, -20),
        AnchorPoint = Vector2.one / 2
    };
    local v7 = {
        Corner = React.createElement("UICorner", {
            CornerRadius = Theme.Tweaks.PanelCornerRadius
        })
    };
    local createElement2 = React.createElement;
    local v8 = {
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0)
    };
    local v9 = {
        Corner = React.createElement("UICorner", {
            CornerRadius = Theme.Tweaks.PanelCornerRadius
        }),
        List = React.createElement("UIListLayout", {
            Padding = UDim.new(0, 0),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Gradient = React.createElement("UIGradient", {
            Color = Theme.Tweaks.PanelGradientColor,
            Rotation = Theme.Tweaks.PanelGradientAngle
        })
    };
    local createElement3 = React.createElement;
    local v10 = {
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 63)
    };
    local v11 = {
        SongTitle = React.createElement("TextLabel", {
            TextSize = 18,
            BackgroundTransparency = 1,
            Text = v4.Title,
            TextColor3 = Theme.Colors.TEXT,
            FontFace = Theme.Fonts.Medium,
            Position = UDim2.fromOffset(15, 11),
            Size = UDim2.fromOffset(240, 21),
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left
        }),
        SongArtist = React.createElement("TextLabel", {
            TextSize = 14,
            BackgroundTransparency = 1,
            Text = v4.Artist,
            TextColor3 = Theme.Colors.LIGHT,
            FontFace = Theme.Fonts.Regular,
            Position = UDim2.fromOffset(15, 27),
            Size = UDim2.fromOffset(150, 18),
            TextXAlignment = Enum.TextXAlignment.Left
        })
    };
    local v12;

    if Song then
        v12 = React.createElement(FavoriteButton, {
            Position = UDim2.new(1, -32, 0.5, 0),
            Size = UDim2.fromOffset(30, 30),
            AnchorPoint = Vector2.one / 2,
            SongId = Song
        });
    else
        v12 = Song;
    end;

    v11.Favorite = v12;

    if Song then
        Song = React.createElement(Button, {
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -80, 0.5, 0),
            Size = UDim2.fromOffset(30, 30),
            AnchorPoint = Vector2.one / 2,
            Image = Theme.Images.Loop,
            ImageColor3 = v5.Looped:map(function(p13) -- Line: 122
                -- upvalues: Theme (copy)
                return Theme.Colors.GRAY:Lerp(Theme.Colors.ACTIVE, p13);
            end),

            OnActivated = function() -- Line: 126, Name: OnActivated
                -- upvalues: u2 (copy)
                u2.SetLooped(not u2.Looped);
            end
        });
    end;

    v11.Loop = Song;
    v9.SongInfo = createElement3("Frame", v10, v11);
    local v14;

    if v3 then
        v14 = React.createElement(DurationSlider, {
            Order = 2,
            AnchorPoint = Vector2.new(0.5, 1),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(1, 0, 0, 50)
        });
    else
        v14 = v3;
    end;

    v9.DurationSlider = v14;
    v7.UpperBlock = createElement2("Frame", v8, v9);
    v7.LowerBlock = React.createElement("Frame", {
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        AutomaticSize = Enum.AutomaticSize.Y,
        AnchorPoint = Vector2.yAxis,
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.fromScale(1, 0)
    }, {
        Corner = React.createElement("UICorner", {
            CornerRadius = Theme.Tweaks.PanelCornerRadius
        }),
        Gradient = React.createElement("UIGradient", {
            Color = Theme.Tweaks.PanelGradientColor,
            Rotation = Theme.Tweaks.PanelGradientAngle
        }),
        List = React.createElement("UIListLayout", {
            Padding = UDim.new(0, 0),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Controls = React.createElement("Frame", {
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            AnchorPoint = Vector2.new(0.5, 1),
            Size = UDim2.new(1, 0, 0, v3 and 70 or 50)
        }, {
            Play = React.createElement(PlayButton, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromOffset(50, 50)
            }),
            Backward = React.createElement(Button, {
                OnActivated = u2.GoBack,
                Position = UDim2.fromScale(0.25, 0.5),
                Image = Theme.Images.Backward,
                ImageColor3 = Theme.Colors.CONTROLS,
                Size = UDim2.fromOffset(50, 50),
                AnchorPoint = Vector2.one / 2
            }),
            Forward = React.createElement(Button, {
                OnActivated = u2.GoForward,
                Position = UDim2.fromScale(0.75, 0.5),
                Image = Theme.Images.Forward,
                ImageColor3 = Theme.Colors.CONTROLS,
                Size = UDim2.fromOffset(50, 50),
                AnchorPoint = Vector2.one / 2
            })
        }),
        Volume = React.createElement(VolumeSlider, {
            Order = 2,
            AnchorPoint = Vector2.new(0.5, 1),
            Position = UDim2.new(0.5, 0, 1, -9),
            Size = UDim2.new(1, 0, 0, 34)
        })
    });
    local v15 = Features.Spectrogram and React.createElement("Folder", {}, {
        Render = React.createElement(Spectrogram, {
            BackgroundTransparency = 1,
            GroupTransparency = 0.5,
            ZIndex = -1,
            Size = UDim2.new(1, 0, 1, 0)
        }, {
            Corner = React.createElement("UICorner", {
                CornerRadius = Theme.Tweaks.PanelCornerRadius
            }),
            Gradient = React.createElement("UIGradient", {
                Rotation = 90,
                Color = Theme.Colors.SPECTROGRAM_GRADIENT
            })
        })
    });
    v7.Spectrogram = v15;

    return createElement("Frame", v6, v7);
end;

return function(p16) -- Line: 225, Name: PlayWidget
    -- upvalues: useComponent (copy), Default (copy), React (copy)
    local v17 = useComponent("Play", Default);

    return React.createElement(v17, p16);
end;