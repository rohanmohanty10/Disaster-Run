 
 

local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local Hooks = Parent.Hooks;
local Parent2 = Parent.Parent;
local Shared = Parent2.Shared;
local State = require(Parent.State);
local Util = require(Parent.Util);
local React = require(Shared.React);
require(Parent2);
local RunContext = require(Shared.RunContext);
local Button = require(script_Parent.Button);
local ScrollFrame = require(script_Parent.ScrollFrame);
local FavoriteButton = require(script_Parent.FavoriteButton);
local useSignal = require(Hooks.useSignal);
local useMetadata = require(Hooks.useMetadata);
local useProductInfo = require(Hooks.useProductInfo);

local function SongItem(p1: table) -- Line: 43
    -- upvalues: React (copy), State (copy), useMetadata (copy), useProductInfo (copy), RunContext (copy), Util (copy), Button (copy), FavoriteButton (copy)
    local Theme = React.useContext(State.Context).Theme;
    local v2 = useMetadata(p1.Song);
    local v3 = p1.Song:match("%d+$") or 0;
    local v4 = useProductInfo((tonumber(v3)));
    local Search = p1.Search;
    local v5 = (v4 == nil and RunContext.IsStudio or v4 and v4.AssetTypeId == 3) and true or false;

    if Search and #Search > 0 then
        local v6 = not v2.Title and "" or v2.Title:lower();
        local v7 = not v2.Artist and "" or v2.Artist:lower();
        local v8 = Search:lower();

        if v7:sub(1, #v8) ~= v8 and v6:sub(1, #v8) ~= v8 then
            local v9 = Util.LevenshteinDistance(v8, v7);
            local v10 = Util.LevenshteinDistance(v8, v6);

            if math.min(v9, v10) > 3 then
                v5 = false;
            end;
        end;
    end;

    if v5 then
        local createElement = React.createElement;
        local v11 = {
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            HoverScale = 1,
            PressScale = 1
        };
        local v12;

        if p1.Index % 2 == 0 then
            v12 = Theme.Colors.BACKGROUND_MID_PANEL;
        else
            v12 = Theme.Colors.BACKGROUND_FORE_PANEL;
        end;

        v11.BackgroundColor3 = v12;
        v11.OnActivated = p1.OnActivated;
        v11.Size = UDim2.new(1, 0, 0, 45);
        v11.LayoutOrder = p1.Index;
        v5 = createElement(Button, v11, {
            Index = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                TextSize = 16,
                Size = UDim2.fromScale(1, 1),
                AnchorPoint = Vector2.one / 2,
                Position = UDim2.new(0, 21, 0.475, 0),
                SizeConstraint = Enum.SizeConstraint.RelativeYY,
                TextColor3 = Theme.Colors.GRAY,
                FontFace = Theme.Fonts.Bold,
                Text = `{p1.Index}.`
            }),
            Song = React.createElement("CanvasGroup", {
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.yAxis / 2,
                AutomaticSize = Enum.AutomaticSize.XY,
                Position = UDim2.fromScale(0.125, 0.5)
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
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextColor3 = Theme.Colors.TEXT,
                    FontFace = Theme.Fonts.Regular,
                    Text = v2.Title or "..."
                }),
                Artist = React.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    TextSize = 12,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextColor3 = Theme.Colors.GRAY,
                    FontFace = Theme.Fonts.Regular,
                    Text = v2.Artist or "..."
                })
            }),
            Favorite = React.createElement(FavoriteButton, {
                SongId = p1.Song,
                Size = UDim2.fromOffset(25, 25),
                Position = UDim2.fromScale(0.9, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5)
            })
        });
    end;

    return v5;
end;

return function(u13: table) -- Line: 151, Name: SongList
    -- upvalues: React (copy), State (copy), SongItem (copy), useSignal (copy), ScrollFrame (copy)
    local u14 = React.useRef(nil);
    local u15 = React.useContext(State.Context);
    local table_clone_ret = table.clone(u13.Songs);
    local Search = u13.Search;
    local v16 = {};

    if Search then
        local v17 = tonumber(Search:match("%d+$"));

        if v17 and v17 > 0 then
            table_clone_ret = { (`rbxassetid://{v17}`) };
            Search = "";
        end;
    end;

    for i, v in ipairs(table_clone_ret) do
        v16[`Song{i}`] = React.createElement(SongItem, {
            Index = i,
            Song = v,
            Search = Search,

            OnActivated = function() -- Line: 177, Name: OnActivated
                -- upvalues: u13 (copy), v (copy), u15 (copy), table_clone_ret (ref)
                if u13.OnSongSelected then
                    u13.OnSongSelected(v);

                    return;
                end;

                u15.SetQueue(table_clone_ret);
                u15.SetSong(v);
                u15.SetPlaying(true);
            end
        });
    end;

    useSignal(u15.ReturnEvent, function() -- Line: 189
        -- upvalues: u14 (copy), u15 (copy)
        local current = u14.current;

        if current and current.CanvasPosition.Y > 0 then
            current.CanvasPosition = Vector2.zero;

            return;
        end;

        u15.WidgetReturn();
    end);

    return React.createElement(ScrollFrame, {
        ScrollBarImageTransparency = 0.75,
        ScrollBarThickness = 2,
        Transparency = 1,
        Size = u13.Size or UDim2.new(1, -16, 1, -74),
        Position = u13.Position or UDim2.fromScale(0.5, 0),
        AnchorPoint = u13.AnchorPoint or Vector2.xAxis / 2,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.fromScale(1, 0),
        ScrollRef = u14,
        List = {
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }
    }, v16);
end;