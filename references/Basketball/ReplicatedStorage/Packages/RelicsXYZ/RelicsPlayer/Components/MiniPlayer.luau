 
 

local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local Button = require(script_Parent.Button);
local PlayButton = require(script_Parent.PlayButton);
local FavoriteButton = require(script_Parent.FavoriteButton);
local Hooks = Parent.Hooks;
local useMetadata = require(Hooks.useMetadata);
local useComponent = require(Hooks.useComponent);
local React = require(Parent.Parent.Shared.React);
local State = require(Parent.State);

local function Default(p1) -- Line: 31
    -- upvalues: React (copy), State (copy), PlayButton (copy), Button (copy), FavoriteButton (copy)
    local v2 = React.useContext(State.Context);
    local Theme = v2.Theme;
    local Song = p1.Song;
    local Title = p1.Title;
    local Artist = p1.Artist;
    local createElement = React.createElement;
    local v3 = {
        Size = p1.Size or UDim2.new(1, -45, 0, 54),
        Position = p1.Position or UDim2.fromScale(0.5, 0.5),
        AnchorPoint = p1.AnchorPoint or Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Colors.BACKGROUND_FORE_PANEL
    };
    local v4 = {};
    local v5 = p1.Scale and React.createElement("UIScale", {
        Scale = p1.Scale
    });
    v4.Scale = v5;
    v4.Corner = React.createElement("UICorner", {
        CornerRadius = Theme.Tweaks.PanelCornerRadius
    });
    v4.Gradient = React.createElement("UIGradient", {
        Color = Theme.Tweaks.PanelGradientColor,
        Rotation = Theme.Tweaks.PanelGradientAngle
    });
    v4.SongInfo = React.createElement("Folder", {}, {
        SongTitle = React.createElement("TextLabel", {
            TextSize = 18,
            BackgroundTransparency = 1,
            Text = Title,
            TextColor3 = Theme.Colors.TEXT,
            FontFace = Theme.Fonts.Medium,
            Position = UDim2.fromOffset(15, 7),
            Size = UDim2.fromOffset(180, 21),
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left
        }),
        SongArtist = React.createElement("TextLabel", {
            TextSize = 14,
            BackgroundTransparency = 1,
            Text = Artist,
            TextColor3 = Theme.Colors.GRAY,
            FontFace = Theme.Fonts.Medium,
            Position = UDim2.fromOffset(15, 25),
            Size = UDim2.fromOffset(180, 18),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd
        })
    });
    v4.List = React.createElement("UIListLayout", {
        Padding = UDim.new(0, 15),
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder
    });
    v4.Padding = React.createElement("UIPadding", {
        PaddingRight = UDim.new(0, 15)
    });
    v4.Play = React.createElement("Frame", {
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Size = UDim2.fromOffset(32, 32)
    }, {
        Button = React.createElement(PlayButton, {
            Size = UDim2.fromScale(1, 1)
        })
    });
    v4.Forward = React.createElement(Button, {
        LayoutOrder = 3,
        ImageColor3 = Theme.Colors.CONTROLS,
        Size = UDim2.fromOffset(32, 32),
        OnActivated = v2.GoForward,
        Image = Theme.Images.Forward
    });
    local createElement2 = React.createElement;
    local v6 = {
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        Size = UDim2.fromOffset(32, 32)
    };
    local v7 = {};

    if Song then
        Song = React.createElement(FavoriteButton, {
            Size = UDim2.fromScale(1, 1),
            SongId = Song
        });
    end;

    v7.Button = Song;
    v4.Favorite = createElement2("Frame", v6, v7);

    return createElement("Frame", v3, v4);
end;

return function(p8: table) -- Line: 127, Name: MiniPlayer
    -- upvalues: React (copy), State (copy), useMetadata (copy), useComponent (copy), Default (copy)
    local Song = React.useContext(State.Context).Song;
    local v9 = useMetadata(Song);
    local v10 = useComponent("MiniPlayer", Default);

    return React.createElement(v10, {
        Song = Song,
        Title = v9 and (v9.Title or "") or "",
        Artist = v9 and v9.Artist or "",
        Size = p8.Size,
        Scale = p8.Scale,
        Position = p8.Position,
        AnchorPoint = p8.AnchorPoint
    });
end;