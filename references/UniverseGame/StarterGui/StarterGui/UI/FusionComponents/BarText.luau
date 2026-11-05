  

 

local ClientLibrary = game:GetService("ReplicatedStorage").ClientLibrary;
local Fusion = require(ClientLibrary.Fusion);
local Children = Fusion.Children;
local New = Fusion.New;
local _ = Fusion.OnEvent;

return function(p1) -- Line: 8
    -- upvalues: Fusion (copy), Children (copy), New (copy)
    return Fusion.New("Frame")({
        Visible = true,
        BackgroundTransparency = 0.4,
        SizeConstraint = "RelativeXY",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromScale(0.339, 0.01),
        Position = UDim2.fromScale(0.486, 0.982),
        BackgroundColor3 = Color3.new(),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Parent = p1.Parent,
        Name = p1.Name or "BarText",
        [Children] = { New("Frame")({
                Name = "bar",
                Visible = true,
                BackgroundColor3 = Color3.new(1, 1, 1),
                Size = UDim2.fromScale(0.835, 1)
            }), New("TextLabel")({
                Name = "txt",
                BackgroundTransparency = 1,
                RichText = true,
                TextScaled = true,
                TextTruncate = "AtEnd",
                BackgroundColor3 = Color3.new(1, 1, 1),
                TextColor3 = Color3.new(1, 1, 1),
                BorderColor3 = Color3.fromRGB(27, 42, 53),
                Position = UDim2.fromScale(0, -3.15),
                Size = UDim2.fromScale(1, 2.3),
                FontFace = Font.fromEnum(Enum.Font.GothamBold)
            }) }
    });
end;