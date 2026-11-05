  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local vide = require(ReplicatedStorage.ClientLibrary.vide);
local create = vide.create;
local action = vide.action;

return function() -- Line: 8
    -- upvalues: create (copy), action (copy), TweenService (copy)
    return create("TextButton")({
        Name = "Template",
        Active = false,
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0, 0.00500002),
        Selectable = false,
        Size = UDim2.fromScale(0, 0.227),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Text = "",
        Visible = false,
        action(function(p1) -- Line: 20
            -- upvalues: TweenService (ref)
            TweenService:Create(p1, TweenInfo.new(0.15, Enum.EasingStyle.Cubic), {
                Size = UDim2.fromScale(1, 0.227)
            }):Play();
        end),
        create("Frame")({
            Name = "Holder",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 106, 106),
            BackgroundTransparency = 0.8,
            BorderColor3 = Color3.new(),
            BorderSizePixel = 0,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.9, 0.9),
            ZIndex = 0,
            create("UIStroke")({
                Name = "UIStroke",
                Thickness = 2,
                Color = Color3.fromRGB(255, 106, 106)
            }),
            create("UIGradient")({
                Name = "UIGradient",
                Rotation = 90,
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.744164, 0.2875), NumberSequenceKeypoint.new(1, 1) })
            })
        }),
        create("TextLabel")({
            Name = "NameLabel",
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1,
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
            Position = UDim2.fromScale(0.5, 0.0500002),
            Size = UDim2.fromScale(0.86, 0.27),
            Text = "DRINK SIX MATCHAS",
            TextColor3 = Color3.new(1, 1, 1),
            TextScaled = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            create("UIStroke")({
                Name = "UIStroke",
                Thickness = 2,
                Transparency = 0.3
            })
        }),
        create("Frame")({
            Name = "Darken",
            BackgroundTransparency = 0.3,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = 2,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.new(),
            BorderColor3 = Color3.new(),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1, 1)
        }),
        create("Frame")({
            Name = "Seperator",
            BackgroundTransparency = 0.7,
            BorderSizePixel = 0,
            LayoutOrder = 999,
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundColor3 = Color3.fromRGB(165, 206, 255),
            BorderColor3 = Color3.fromRGB(27, 42, 53),
            Position = UDim2.fromScale(0.42, 0.35),
            Size = UDim2.new(0.7, 0, 0, 2)
        }),
        create("TextLabel")({
            Name = "ProgressLabel",
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1,
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic),
            Position = UDim2.fromScale(0.5, 0.429454),
            Size = UDim2.fromScale(0.86, 0.113464),
            Text = "Progress: 3/6",
            TextColor3 = Color3.new(1, 1, 1),
            TextScaled = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            create("UIStroke")({
                Name = "UIStroke",
                Thickness = 2,
                Transparency = 0.3
            })
        }),
        create("Frame")({
            Name = "ProgressBar",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 106, 106),
            BackgroundTransparency = 0.8,
            BorderColor3 = Color3.new(),
            BorderSizePixel = 0,
            Position = UDim2.fromScale(0.42, 0.615565),
            Size = UDim2.fromScale(0.7, 0.0725842),
            ZIndex = 0,
            create("UIStroke")({
                Name = "UIStroke",
                Thickness = 2,
                Color = Color3.fromRGB(255, 106, 106)
            }),
            create("UIGradient")({
                Name = "UIGradient",
                Rotation = 90,
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.744164, 0.2875), NumberSequenceKeypoint.new(1, 1) })
            }),
            create("Frame")({
                Name = "Bar",
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Color3.fromRGB(125, 255, 111),
                BorderColor3 = Color3.new(),
                BorderSizePixel = 0,
                Position = UDim2.fromScale(0, 0.5),
                Size = UDim2.fromScale(0.5, 1),
                ZIndex = 0,
                create("UIStroke")({
                    Name = "UIStroke",
                    Thickness = 2,
                    Color = Color3.fromRGB(125, 255, 111)
                }),
                create("UIGradient")({
                    Name = "UIGradient",
                    Rotation = 90,
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.744164, 0.2875), NumberSequenceKeypoint.new(1, 1) })
                })
            })
        }),
        create("TextLabel")({
            Name = "RewardsLabel",
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1,
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic),
            Position = UDim2.fromScale(0.5, 0.727597),
            Size = UDim2.fromScale(0.86, 0.181499),
            Text = "Reward: 100 Gems",
            TextColor3 = Color3.fromRGB(255, 194, 97),
            TextScaled = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            create("UIStroke")({
                Name = "UIStroke",
                Thickness = 2,
                Transparency = 0.3
            })
        })
    });
end;