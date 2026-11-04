 
 

local Parent = script.Parent.Parent;
local Util = require(Parent.Util);
local State = require(Parent.State);
local React = require(Parent.Parent.Shared.React);
local Hooks = Parent.Hooks;
local useClock = require(Hooks.useClock);
local useProperty = require(Hooks.useProperty);

return function(p1: table) -- Line: 23, Name: DurationSlider
    -- upvalues: React (copy), State (copy), useProperty (copy), useClock (copy), Util (copy)
    local u2, u3 = React.useState(false);
    local v4 = React.useContext(State.Context);
    local AudioPlayer = v4.GetAudioPlayer();
    local SetJumpToTime = v4.SetJumpToTime;
    local u5 = React.useRef(nil);
    local Theme = v4.Theme;
    local Colors = Theme.Colors;
    local Fonts = Theme.Fonts;
    local u7 = useProperty(AudioPlayer, function(p6) -- Line: 35
        return p6 and p6.TimeLength or 0;
    end);
    local current = u5.current;

    if not current then
        if AudioPlayer and AudioPlayer.IsReady then
            current = AudioPlayer.TimePosition;
        else
            current = nil;
        end;
    end;

    local v8;

    if AudioPlayer and AudioPlayer.IsReady then
        v8 = AudioPlayer.TimeLength;
    else
        v8 = nil;
    end;

    local u9 = React.useRef(nil);
    local u10 = React.useRef(nil);
    local u11 = React.useRef(nil);

    local function stepTime(p12: userdata, p13: userdata) -- Line: 51
        -- upvalues: u5 (copy), u7 (copy)
        local Parent2 = p12.Parent;

        if Parent2 and Parent2:IsA("GuiObject") then
            u5.current = math.clamp((p13.Position.X - Parent2.AbsolutePosition.X) / Parent2.AbsoluteSize.X, 0, 1) * u7;
        end;
    end;

    useClock(10, function() -- Line: 60
        -- upvalues: AudioPlayer (copy), u11 (copy), u10 (copy), u9 (copy), current (ref), u5 (copy), u7 (copy)
        if not AudioPlayer then
            return;
        end;

        local current2 = u11.current;
        local current3 = u10.current;
        local current4 = u9.current;
        current = u5.current or AudioPlayer.TimePosition;

        if current and AudioPlayer.IsReady then
            if current3 then
                current3.Text = string.format("%02d:%02d", current // 60, current % 60);
            end;

            if current2 then
                current2.Size = UDim2.fromScale(current / u7, 1);
            end;
        else
            if current3 then
                current3.Text = "--:--";
            end;

            if current4 then
                current4.Text = "--:--";
            end;

            if current2 then
                current2.Size = UDim2.fromScale(0, 1);
            end;
        end;
    end, { AudioPlayer, u7 });
    React.useEffect(function() -- Line: 96
        -- upvalues: u9 (copy), u7 (copy)
        local current2 = u9.current;

        if current2 then
            current2.Text = string.format("%02d:%02d", u7 // 60, u7 % 60);
        end;
    end, { u7 });
    local createElement = React.createElement;
    local v14 = {
        BackgroundTransparency = 1,
        Position = p1.Position or UDim2.fromScale(0.5, 0.5),
        AnchorPoint = p1.AnchorPoint or Vector2.one / 2,
        Size = p1.Size or UDim2.new(1, 0, 0, 34),
        LayoutOrder = p1.Order
    };
    local v21 = {
        Slider = React.createElement("Frame", {
            BackgroundColor3 = Colors.BRIGHT,
            Position = UDim2.new(0.5, 0, 0, 10),
            AnchorPoint = Vector2.one / 2,
            Size = UDim2.new(1, -35, 0, 3)
        }, {
            Corner = React.createElement("UICorner", {
                CornerRadius = UDim.new(1, 0)
            }),
            Fill = React.createElement("Frame", {
                BorderSizePixel = 0,
                Size = UDim2.fromScale((current or 0) / (v8 or 1), 1),
                BackgroundColor3 = Colors.LIGHT,
                ref = u11
            }, {
                Corner = React.createElement("UICorner", {
                    CornerRadius = UDim.new(1, 0)
                })
            }),
            InputCapture = React.createElement("ImageButton", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 64, 1, 64),
                AnchorPoint = Vector2.one / 2,
                Position = UDim2.fromScale(0.5, 0),
                ZIndex = 0,

                [React.Event.InputBegan] = function(p15: userdata, p16: userdata) -- Line: 143
                    -- upvalues: Util (ref), u5 (copy), u7 (copy), u3 (copy)
                    if Util.IsPointerInput(p16) then
                        local Parent2 = p15.Parent;

                        if Parent2 and Parent2:IsA("GuiObject") then
                            u5.current = math.clamp((p16.Position.X - Parent2.AbsolutePosition.X) / Parent2.AbsoluteSize.X, 0, 1) * u7;
                        end;

                        u3(true);
                    end;
                end,

                [React.Event.InputChanged] = function(p17: userdata, p18: userdata) -- Line: 150
                    -- upvalues: Util (ref), u2 (copy), u5 (copy), u7 (copy)
                    if Util.IsMoveInput(p18) and u2 then
                        local Parent2 = p17.Parent;

                        if Parent2 and Parent2:IsA("GuiObject") then
                            u5.current = math.clamp((p18.Position.X - Parent2.AbsolutePosition.X) / Parent2.AbsoluteSize.X, 0, 1) * u7;
                        end;
                    end;
                end,

                [React.Event.InputEnded] = function(p19: userdata, p20: userdata) -- Line: 156
                    -- upvalues: Util (ref), u2 (copy), u5 (copy), u7 (copy), SetJumpToTime (copy), u3 (copy)
                    if Util.IsMoveInput(p20) and u2 then
                        local Parent2 = p19.Parent;

                        if Parent2 and Parent2:IsA("GuiObject") then
                            u5.current = math.clamp((p20.Position.X - Parent2.AbsolutePosition.X) / Parent2.AbsoluteSize.X, 0, 1) * u7;
                        end;

                        SetJumpToTime(u5.current);
                    end;

                    u5.current = nil;
                    u3(false);
                end
            }),
            TimePos = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                TextSize = 10,
                Position = UDim2.fromScale(0, 1),
                Size = UDim2.new(0.5, 0, 0, 20),
                Text = not current and "--:--" or string.format("%02d:%02d", current // 60, current % 60),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextColor3 = Colors.GRAY,
                FontFace = Fonts.Bold,
                ref = u10
            }),
            Duration = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                TextSize = 10,
                Position = UDim2.fromScale(1, 1),
                Size = UDim2.new(0.5, 0, 0, 20),
                AnchorPoint = Vector2.xAxis,
                Text = not u7 and "--:--" or string.format("%02d:%02d", u7 // 60, u7 % 60),
                TextXAlignment = Enum.TextXAlignment.Right,
                TextColor3 = Colors.GRAY,
                FontFace = Fonts.Bold,
                ref = u9
            })
        })
    };
    local v22 = p1.Scale and React.createElement("UIScale", {
        Scale = p1.Scale
    });
    v21.Scale = v22;

    return createElement("Frame", v14, v21);
end;