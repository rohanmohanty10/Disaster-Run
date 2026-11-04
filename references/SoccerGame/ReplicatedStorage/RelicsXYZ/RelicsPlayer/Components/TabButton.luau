  

local Parent = script.Parent.Parent;
local Shared = Parent.Parent.Shared;
local React = require(Shared.React);
local ReactSpring = require(Shared.ReactSpring);
local Button = require(script.Parent.Button);
local State = require(Parent.State);
local useClock = require(Parent.Hooks.useClock);

return function(u1: table) -- Line: 27, Name: TabButton
    -- upvalues: React (copy), State (copy), ReactSpring (copy), useClock (copy), Button (copy)
    local Theme = React.useContext(State.Context).Theme;
    local v2 = ReactSpring.useSpring({
        from = {
            value = 0
        },
        to = {
            value = u1.Active and 1 or 0
        },
        config = {
            tension = 800,
            friction = 30
        }
    });
    local v4 = v2.value:map(function(p3) -- Line: 46
        -- upvalues: Theme (copy)
        return Theme.Colors.GRAY:Lerp(Theme.Colors.ACTIVE, p3);
    end);
    local v5 = Theme.Images.NavBar[u1.Tab];
    local v6 = Theme.Images.NavOverlays[u1.Tab];
    local u7 = React.useRef(nil);
    useClock(u1.Spin and 30 or 1, function(p8) -- Line: 54
        -- upvalues: u1 (copy), u7 (copy)
        if not u1.Spin then
            return;
        end;

        local current = u7.current;

        if current then
            current.Rotation = current.Rotation + p8 * 90;
            current.Rotation = current.Rotation % 360;
        end;
    end);
    local createElement = React.createElement;
    local v9 = {
        OnActivated = u1.OnActivated,
        Size = UDim2.fromOffset(64, 36),
        LayoutOrder = u1.Order
    };
    local v10 = {};
    local createElement2 = React.createElement;
    local v11 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(25, 25),
        Position = UDim2.new(0.5, 0, 0, 1),
        AnchorPoint = Vector2.xAxis / 2,
        ImageColor3 = v4,
        Image = v5,
        ref = u7
    };
    local v12 = {};

    if v6 then
        v6 = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = v6,
            Size = UDim2.fromScale(1, 1),
            ImageColor3 = v4,
            ImageTransparency = v2.value:map(function(p13) -- Line: 87
                return 1 - p13;
            end)
        });
    end;

    v12.Overlay = v6;
    v10.Image = createElement2("ImageLabel", v11, v12);
    v10.Text = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        TextScaled = true,
        FontFace = Theme.Fonts.Regular,
        TextColor3 = v4,
        Text = u1.Tab,
        Position = UDim2.fromOffset(0, 27),
        Size = UDim2.new(1, 0, 0.325, 0)
    });

    return createElement(Button, v9, v10);
end;