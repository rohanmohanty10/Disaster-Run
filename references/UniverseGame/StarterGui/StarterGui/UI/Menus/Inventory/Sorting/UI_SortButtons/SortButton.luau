  

 

local ClientLibrary = game:GetService("ReplicatedStorage").ClientLibrary;
local Fusion = require(ClientLibrary.Fusion);
local Children = Fusion.Children;
local New = Fusion.New;
local _ = Fusion.OnEvent;
local Computed = Fusion.Computed;
local Value = Fusion.Value;
local ForValues = Fusion.ForValues;
local u1 = nil;

local function UIStroke() -- Line: 13
    -- upvalues: New (copy), Children (copy), u1 (ref)
    return New("UIStroke")({
        ApplyStrokeMode = "Border",
        LineJoinMode = "Miter",
        Color = Color3.new(1, 1, 1),
        Thickness = 1,
        Transparency = 0,
        [Children] = { u1({
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.686275, 0.686275, 1)), ColorSequenceKeypoint.new(0.95, Color3.new(0.686275, 0.686275, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.294118, 0.588235, 1)) })
            }) }
    });
end;

local function UITextSizeConstraint() -- Line: 32
    -- upvalues: New (copy)
    return New("UITextSizeConstraint")({
        MaxTextSize = 28,
        MinTextSize = 1
    });
end;

local function TextBox() -- Line: 39
    -- upvalues: New (copy)
    return New("TextBox")({
        TextScaled = true,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        PlaceholderText = "Search",
        FontFace = Font.fromEnum(Enum.Font.Ubuntu),
        TextColor3 = Color3.new(1, 1, 1),
        Size = UDim2.fromScale(1, 1)
    });
end;

local function CreateFrameList(p2) -- Line: 51
    -- upvalues: New (copy), Children (copy), ForValues (copy), Value (copy), u1 (ref), UIStroke (copy), UITextSizeConstraint (copy), Fusion (copy)
    return New("Frame")({
        Name = "Types",
        Size = UDim2.fromScale(1, 1),
        ZIndex = 2,
        Visible = false,
        [Children] = { New("UIListLayout")({
                SortOrder = "Name",
                Padding = UDim.new(0, 2)
            }), ForValues(Value(p2), function(p3) -- Line: 62
                -- upvalues: New (ref), Children (ref), u1 (ref), UIStroke (ref), UITextSizeConstraint (ref)
                return New("TextButton")({
                    Name = p3.Name,
                    Text = p3.Text or p3.Name,
                    FontFace = Font.fromEnum(Enum.Font.SourceSansSemibold),
                    [Children] = { u1({
                            Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(125, 175, 255))
                        }), UIStroke(), UITextSizeConstraint() }
                });
            end, Fusion.cleanup) }
    });
end;

return function(p4, u5) -- Line: 82
    -- upvalues: u1 (ref), Fusion (copy), Children (copy), UIStroke (copy), New (copy), Computed (copy), CreateFrameList (copy), TextBox (copy)
    u1 = p4.FusionComponents.UIGradient;

    return Fusion.New("TextButton")({
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        BackgroundTransparency = 0.1,
        TextScaled = true,
        TextStrokeTransparency = 0.75,
        TextColor3 = Color3.new(1, 1, 1),
        Parent = u5.Parent,
        Name = u5.Name,
        Size = u5.Size,
        Visible = u5.Visible,
        Text = u5.Text,
        FontFace = Font.fromEnum(Enum.Font.SourceSansSemibold),
        [Children] = {
            u1({
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(125, 175, 255))
            }),
            UIStroke(p4),
            New("UITextSizeConstraint")({
                MaxTextSize = 28,
                MinTextSize = 1
            }),
            Computed(function() -- Line: 106
                -- upvalues: u5 (copy), CreateFrameList (ref), TextBox (ref)
                if u5.Buttons then
                    return CreateFrameList(u5.Buttons);
                end;

                return TextBox();
            end, Fusion.cleanup)
        }
    });
end;