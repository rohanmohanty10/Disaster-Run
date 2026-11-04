 
 

local Parent = script.Parent.Parent;
local State = require(Parent.State);
local Util = require(Parent.Util);
local Shared = Parent.Parent.Shared;
local React = require(Shared.React);
local ReactSpring = require(Shared.ReactSpring);
require(script.Props);

return function(p1) -- Line: 15, Name: Button
    -- upvalues: React (copy), State (copy), ReactSpring (copy), Util (copy)
    local v2, u3 = React.useState(1);
    local u4 = React.useContext(State.Context);
    local Sounds = u4.Theme.Sounds;
    local v6 = ReactSpring.useSpring({
        from = {
            Scale = 1
        },
        to = {
            Scale = v2
        },
        config = {
            tension = 500,
            friction = 30
        }
    }).Scale:map(function(p5) -- Line: 32
        return UDim.new((1 - p5) / 2, 0);
    end);
    local u7 = p1.HoverScale or 1.1;
    local u8 = p1.PressScale or 0.9;
    local createElement = React.createElement;
    local v9 = {
        BackgroundTransparency = 1,
        Size = p1.Size,
        AnchorPoint = p1.AnchorPoint or Vector2.one / 2,
        Position = p1.Position or UDim2.fromScale(0.5, 0.5),
        SizeConstraint = p1.SizeConstraint,
        LayoutOrder = p1.LayoutOrder,
        ZIndex = p1.ZIndex
    };
    local v12 = {
        Scale = React.createElement("UIPadding", {
            PaddingTop = v6,
            PaddingLeft = v6,
            PaddingRight = v6,
            PaddingBottom = v6
        }),
        Button = React.createElement("ImageButton", {
            Image = p1.Image,
            ScaleType = p1.ScaleType,
            Size = UDim2.fromScale(1, 1),
            ImageColor3 = p1.ImageColor3,
            BorderColor3 = p1.BorderColor3,
            ImageRectSize = p1.ImageRectSize,
            AutoButtonColor = p1.AutoButtonColor,
            BorderSizePixel = p1.BorderSizePixel,
            ImageRectOffset = p1.ImageRectOffset,
            BackgroundColor3 = p1.BackgroundColor3,
            ImageTransparency = p1.ImageTransparency,
            BackgroundTransparency = p1.BackgroundTransparency or 1,

            [React.Change.GuiState] = function(p10: userdata) -- Line: 69
                -- upvalues: u4 (copy), u3 (copy), u7 (copy), Util (ref), Sounds (copy), u8 (copy)
                local GuiState = p10.GuiState;
                local v11 = u4.Volume / 5;

                if GuiState == Enum.GuiState.Hover then
                    u3(u7);
                    Util.PlaySound(Sounds.Hover, p10, v11);

                    return;
                end;

                if GuiState ~= Enum.GuiState.Press then
                    u3(1);

                    return;
                end;

                u3(u8);
                Util.PlaySound(Sounds.Press, p10, v11);
            end,

            [React.Event.Activated] = p1.OnActivated
        }, p1.children)
    };
    local v13 = p1.Flex and React.createElement("UIFlexItem", p1.Flex);
    v12.Flex = v13;

    return createElement("Frame", v9, v12);
end;