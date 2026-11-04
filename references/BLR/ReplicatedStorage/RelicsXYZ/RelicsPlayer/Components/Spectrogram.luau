  

local Parent = script.Parent.Parent;
local Shared = Parent.Parent.Shared;
local Hooks = Parent.Hooks;
local State = require(Parent.State);
local React = require(Shared.React);
local useClock = require(Hooks.useClock);

return function(p1: table) -- Line: 16, Name: Spectrogram
    -- upvalues: React (copy), State (copy), useClock (copy)
    local Spectrogram = React.useContext(State.Context).GetSpectrogram();
    local v2 = p1.children or {};
    local u3 = {};

    for i = 1, 128 do
        local v4 = React.useRef(nil);
        u3[i] = v4;
        v2[`Frame{i}`] = React.createElement("Frame", {
            BorderSizePixel = 0,
            Size = UDim2.new(0.0078125, 0, 1, 0),
            Position = UDim2.new((i - 1) / 128, 0, 0.5, 0),
            AnchorPoint = Vector2.yAxis / 2,
            BackgroundColor3 = Color3.fromHex("#FFFFFF")
        }, {
            Gradient = React.createElement("UIGradient", {
                Rotation = 90,
                ref = v4,
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.499, 1),
                    NumberSequenceKeypoint.new(0.5, 0),
                    NumberSequenceKeypoint.new(1, 0)
                }),
                Offset = Vector2.yAxis / 2
            })
        });
        local _ = i;
    end;

    p1.AutoPlay = nil;
    useClock(40, function(p5) -- Line: 53
        -- upvalues: Spectrogram (copy), u3 (copy)
        local v6 = not Spectrogram and {} or Spectrogram:GetSpectrum();

        for i, v in u3 do
            local v7 = v6[i + 4] or 0;
            local current = v.current;

            if current then
                local v8 = math.sqrt(v7) * 2;
                current.Offset = Vector2.new(0, 0.5 - v8);
            end;
        end;
    end, { Spectrogram });

    return React.createElement("CanvasGroup", p1, v2);
end;