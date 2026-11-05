  

 

local ClientLibrary = game:GetService("ReplicatedStorage").ClientLibrary;
local Fusion = require(ClientLibrary.Fusion);
local Children = Fusion.Children;
local New = Fusion.New;
local OnEvent = Fusion.OnEvent;

return function(p1, p2) -- Line: 8
    -- upvalues: Fusion (copy), OnEvent (copy), Children (copy), New (copy)
    local UIGradient = p1.FusionComponents.UIGradient;
    local UIStroke = p1.FusionComponents.UIStroke;

    return Fusion.New("TextButton")({
        Visible = true,
        AnchorPoint = Vector2.new(0, 1),
        Size = UDim2.fromOffset(28, 28),
        BackgroundTransparency = 0.25,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        SizeConstraint = "RelativeXY",
        Parent = p2.Parent,
        Name = p2.Name,

        [OnEvent("MouseButton1Down")] = function() -- Line: 22
            warn("CLICKED");
        end,

        [Children] = { UIGradient(), UIStroke(p1), New("ImageLabel")({
                AnchorPoint = Vector2.new(0.5, 0.5),
                BorderColor3 = Color3.fromRGB(27, 42, 53),
                BackgroundTransparency = 1,
                Position = UDim2.fromScale(0.5, 0.5),
                Size = p2.ImageSize or UDim2.fromScale(1, 1),
                Image = p2.Image,
                [Children] = { UIGradient({
                        Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(125, 175, 255))
                    }) }
            }) }
    });
end;