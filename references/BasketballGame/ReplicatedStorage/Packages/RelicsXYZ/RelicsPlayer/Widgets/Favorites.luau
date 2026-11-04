 
 

local Parent = script.Parent.Parent;
local State = require(Parent.State);
local Enums = require(Parent.Enums);
local React = require(Parent.Parent.Shared.React);
local Hooks = Parent.Hooks;
local Components = Parent.Components;
local SongList = require(Components.SongList);
local MiniPlayer = require(Components.MiniPlayer);
local useFavorites = require(Hooks.useFavorites);
local useComponent = require(Hooks.useComponent);

local function Default(p1: table) -- Line: 31
    -- upvalues: React (copy), SongList (copy), MiniPlayer (copy)
    local Theme = p1.State.Theme;
    local Search = p1.Search;
    local Favorites = p1.Favorites;

    return React.createElement(React.Fragment, {}, {
        Search = React.createElement("Frame", {
            BackgroundColor3 = Theme.Colors.WHITE,
            Position = UDim2.new(0.5, 0, 0, 5),
            AnchorPoint = Vector2.new(0.5, 0),
            Size = UDim2.new(1, -47, 0, 34)
        }, {
            Corner = React.createElement("UICorner", {
                CornerRadius = Theme.Tweaks.PanelCornerRadius
            }),
            Icon = React.createElement("ImageLabel", {
                BackgroundTransparency = 1,
                Image = Theme.Images.Search,
                Size = UDim2.fromOffset(25, 25),
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 4, 0.5, 0)
            }),
            SearchBox = React.createElement("TextBox", {
                PlaceholderText = "Search or Enter Sound ID",
                Text = "",
                TextSize = 14,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -35, 1, 0),
                Position = UDim2.new(0, 35, 0, 0),
                TextColor3 = Color3.new(0, 0, 0),
                FontFace = Theme.Fonts.Regular,
                TextXAlignment = Enum.TextXAlignment.Left,
                PlaceholderColor3 = Theme.Colors.GRAY,
                [React.Change.Text] = p1.OnSearchChanged,
                [React.Event.Focused] = p1.OnSearchFocused
            })
        }),
        SongList = React.createElement(SongList, {
            Songs = Favorites,
            Search = Search,
            Size = UDim2.new(1, -16, 1, -115),
            Position = UDim2.new(0.5, 0, 0, 45),
            OnSongSelected = p1.OnSongSelected
        }),
        MiniPlayer = React.createElement(MiniPlayer, {
            Position = UDim2.new(0.5, 0, 1, -10),
            AnchorPoint = Vector2.new(0.5, 1)
        })
    });
end;

return function(p2) -- Line: 89, Name: FavoritesWidget
    -- upvalues: React (copy), State (copy), useFavorites (copy), useComponent (copy), Default (copy), Enums (copy)
    local u3 = React.useContext(State.Context);
    local v4, u5 = React.useState("");
    local Status = u3.Status;
    local Features = u3.Features;
    local v6 = useFavorites();
    local v7 = useComponent("Favorites", Default);

    if Features.Favorites then
        return React.createElement(v7, {
            State = u3,
            Favorites = v6,
            Search = v4,
            SetSearch = u5,

            OnSearchFocused = function(p8: userdata) -- Line: 111, Name: OnSearchFocused
                -- upvalues: Status (copy), Enums (ref), u3 (copy)
                if Status ~= Enums.UserStatus.BoomboxPurchased then
                    p8:ReleaseFocus(false);
                    u3.SetWindowTab(Enums.WindowTab.Upsell);
                end;
            end,

            OnSearchChanged = function(p9: userdata) -- Line: 118, Name: OnSearchChanged
                -- upvalues: Status (copy), Enums (ref), u5 (copy)
                if Status == Enums.UserStatus.BoomboxPurchased then
                    u5(p9.Text:lower());
                end;
            end
        });
    end;

    u3.SetWindowTab(Enums.WindowTab.Play);

    return nil;
end;