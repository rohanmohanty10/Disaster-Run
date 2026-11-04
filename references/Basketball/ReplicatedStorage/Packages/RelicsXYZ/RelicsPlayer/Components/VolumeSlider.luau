 
 

local Parent = script.Parent.Parent;
local Util = require(Parent.Util);
local State = require(Parent.State);
local React = require(Parent.Parent.Shared.React);
local Button = require(script.Parent.Button);

return function(p1: table) -- Line: 22, Name: VolumeSlider
    -- upvalues: React (copy), State (copy), Util (copy), Button (copy)
    local u2, u3 = React.useState(false);
    local u4 = React.useContext(State.Context);
    local Theme = u4.Theme;
    local SetVolume = u4.SetVolume;
    local Volume = u4.Volume;

    local function stepVolume(p5: userdata, p6: userdata) -- Line: 30
        -- upvalues: u4 (copy), SetVolume (copy), Util (ref), Theme (copy)
        local Parent2 = p5.Parent;

        if Parent2 and Parent2:IsA("GuiObject") then
            local AudioPlayer = u4.GetAudioPlayer();
            local math_clamp_ret = math.clamp((p6.Position.X - Parent2.AbsolutePosition.X) / Parent2.AbsoluteSize.X, 0, 1);
            SetVolume(math_clamp_ret);

            if AudioPlayer and not AudioPlayer.IsPlaying then
                Util.PlaySound(Theme.Sounds.Volume, Parent2, math_clamp_ret / 60);
            end;
        end;
    end;

    local createElement = React.createElement;
    local v7 = {
        BackgroundTransparency = 1,
        Position = p1.Position or UDim2.fromScale(0.5, 0.5),
        AnchorPoint = p1.AnchorPoint or Vector2.one / 2,
        Size = p1.Size or UDim2.fromOffset(375, 34),
        LayoutOrder = p1.Order
    };
    local v14 = {
        Lower = React.createElement(Button, {
            ZIndex = 2,

            OnActivated = function() -- Line: 54, Name: OnActivated
                -- upvalues: SetVolume (copy), Volume (copy)
                SetVolume((math.clamp(Volume - 0.05, 0, 1)));
            end,

            ImageColor3 = Theme.Colors.GRAY,
            Image = Theme.Images.Volume.Low,
            Position = UDim2.new(0, 25, 0.5, 0),
            Size = UDim2.fromOffset(25, 25)
        }),
        Higher = React.createElement(Button, {
            ZIndex = 2,

            OnActivated = function() -- Line: 67, Name: OnActivated
                -- upvalues: SetVolume (copy), Volume (copy)
                SetVolume((math.clamp(Volume + 0.05, 0, 1)));
            end,

            ImageColor3 = Theme.Colors.GRAY,
            Image = Theme.Images.Volume.High,
            Position = UDim2.new(1, -25, 0.5, 0),
            Size = UDim2.fromOffset(25, 25)
        }),
        Slider = React.createElement("Frame", {
            BackgroundColor3 = Theme.Colors.WHITE,
            Position = UDim2.new(0, 37, 0.5, 0),
            AnchorPoint = Vector2.yAxis / 2,
            Size = UDim2.new(1, -80, 0, 3)
        }, {
            Corner = React.createElement("UICorner", {
                CornerRadius = UDim.new(1, 0)
            }),
            Fill = React.createElement("Frame", {
                BorderSizePixel = 0,
                Size = UDim2.fromScale(Volume, 1),
                BackgroundColor3 = Theme.Colors.ACTIVE
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

                [React.Event.InputBegan] = function(p8: userdata, p9: userdata) -- Line: 106
                    -- upvalues: Util (ref), stepVolume (copy), u3 (copy)
                    if Util.IsPointerInput(p9) then
                        stepVolume(p8, p9);
                        u3(true);
                    end;
                end,

                [React.Event.InputChanged] = function(p10: userdata, p11: userdata) -- Line: 113
                    -- upvalues: u2 (copy), Util (ref), stepVolume (copy)
                    if u2 and Util.IsMoveInput(p11) then
                        stepVolume(p10, p11);
                    end;
                end,

                [React.Event.InputEnded] = function(p12: userdata, p13: userdata) -- Line: 119
                    -- upvalues: Util (ref), u2 (copy), stepVolume (copy), u3 (copy)
                    if Util.IsMoveInput(p13) and u2 then
                        stepVolume(p12, p13);
                        u3(false);
                    end;
                end
            })
        })
    };
    local v15 = p1.Scale and React.createElement("UIScale", {
        Scale = p1.Scale
    });
    v14.Scale = v15;

    return createElement("Frame", v7, v14);
end;