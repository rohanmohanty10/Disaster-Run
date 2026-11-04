  

local Parent = script.Parent.Parent;
local React = require(Parent.Parent.Shared.React);
local script_Parent = script.Parent;
local Enums = require(Parent.Enums);
local State = require(Parent.State);
local SongList = require(script_Parent.SongList);
local MiniPlayer = require(script_Parent.MiniPlayer);
local PlaylistItem = require(script_Parent.PlaylistItem);
local ScrollFrame = require(script_Parent.ScrollFrame);
local Hooks = Parent.Hooks;
local useSignal = require(Hooks.useSignal);
local useTagged = require(Hooks.useTagged);

return function(p1) -- Line: 27, Name: Playlists
    -- upvalues: React (copy), State (copy), useTagged (copy), Enums (copy), useSignal (copy), PlaylistItem (copy), SongList (copy), MiniPlayer (copy), ScrollFrame (copy)
    local u2 = React.useContext(State.Context);
    local v3 = useTagged("RelicsPlaylist");
    local WindowState = u2.WindowState;
    local u4 = React.useRef(nil);
    local _ = WindowState == Enums.WindowState.Full;
    useSignal(u2.ReturnEvent, function() -- Line: 40
        -- upvalues: u4 (copy)
        local current = u4.current;

        if current and current.CanvasPosition.X > 0 then
            current.CanvasPosition = Vector2.zero;
        end;
    end);
    local v5 = {};

    for i, v in v3 do
        v5[v:GetAttribute("Id") or v.Name] = React.createElement(PlaylistItem, {
            Index = i,
            Playlist = v,
            SetPlaylist = p1.SetPlaylist or function(p6: string, u7: table) -- Line: 55
                -- upvalues: u2 (copy), React (ref), SongList (ref), MiniPlayer (ref)
                local Widget = u2.Widget;
                u2.SetWidget({
                    ReturnText = p6,

                    Widget = function(p8) -- Line: 61, Name: Widget
                        -- upvalues: React (ref), SongList (ref), u7 (copy), MiniPlayer (ref)
                        return React.createElement(React.Fragment, {}, {
                            SongList = React.createElement(SongList, {
                                Songs = u7
                            }),
                            MiniPlayer = React.createElement(MiniPlayer, {
                                Position = UDim2.new(0.5, 0, 1, -10),
                                AnchorPoint = Vector2.new(0.5, 1)
                            })
                        });
                    end,

                    ReturnFunc = function() -- Line: 77, Name: ReturnFunc
                        -- upvalues: u2 (ref), Widget (copy)
                        u2.SetWidget(Widget);
                    end
                });
            end
        });
    end;

    return React.createElement(ScrollFrame, {
        ScrollBarImageTransparency = 1,
        ScrollBarThickness = 0,
        ZIndex = 0,
        CanvasSize = UDim2.fromScale(0, WindowState == Enums.WindowState.Full and 1 or 0.975),
        Position = p1.Position,
        LayoutOrder = p1.LayoutOrder,
        AnchorPoint = p1.AnchorPoint,
        AutomaticCanvasSize = Enum.AutomaticSize.X,
        Size = p1.Size or UDim2.new(1, 0, 0.4, 0),
        ScrollingDirection = Enum.ScrollingDirection.X,
        List = {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder
        }
    }, v5);
end;