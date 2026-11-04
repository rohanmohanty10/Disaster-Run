 
 

local Parent = script.Parent.Parent;
local Enums = require(Parent.Enums);
local State = require(Parent.State);
local Shared = Parent.Parent.Shared;
local Components = Parent.Components;
local Playlists = require(Components.Playlists);
local MiniPlayer = require(Components.MiniPlayer);
local useComponent = require(Parent.Hooks.useComponent);
local React = require(Shared.React);

local function Default(p1) -- Line: 20
    -- upvalues: React (copy), State (copy), Enums (copy), Playlists (copy), MiniPlayer (copy)
    local v2 = React.useContext(State.Context).WindowState == Enums.WindowState.Full;

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Size = p1.Size,
        Position = p1.Position,
        AnchorPoint = p1.AnchorPoint
    }, {
        Playlists = React.createElement(Playlists, {
            Size = UDim2.fromScale(1, v2 and 0.6 or 0.5),
            Position = UDim2.new(0.5, 0, 0, 8),
            AnchorPoint = Vector2.xAxis / 2
        }),
        MiniPlayer = React.createElement(MiniPlayer, {
            Position = UDim2.new(0.5, 0, 1, -10),
            AnchorPoint = Vector2.new(0.5, 1)
        })
    });
end;

return function(p3) -- Line: 44, Name: BrowseWidget
    -- upvalues: useComponent (copy), Default (copy), React (copy)
    local v4 = useComponent("Browse", Default);

    return React.createElement(v4, p3);
end;