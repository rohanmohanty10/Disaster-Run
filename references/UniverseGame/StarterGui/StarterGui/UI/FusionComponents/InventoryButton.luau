  

 

local ClientLibrary = game:GetService("ReplicatedStorage").ClientLibrary;
local Fusion = require(ClientLibrary.Fusion);
local Children = Fusion.Children;
local New = Fusion.New;
local OnEvent = Fusion.OnEvent;

return function(u1, u2) -- Line: 8
    -- upvalues: Fusion (copy), OnEvent (copy), Children (copy), New (copy)
    local UIGradient = u1.FusionComponents.UIGradient;

    return Fusion.New("TextButton")({
        Visible = true,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        BackgroundTransparency = 0.4,
        SizeConstraint = "RelativeYY",
        TextColor3 = Color3.new(1, 1, 1),
        TextScaled = true,
        Parent = u2.Parent,
        Name = u2.Name,
        Text = u2.Text,

        [OnEvent("MouseButton1Down")] = function() -- Line: 24
            -- upvalues: u1 (copy), u2 (copy)
            u1:PlaySound("Click");
            u1:SetInventoryTab(u2.InventoryType or u2.Name);
            u1:SetMenu("Inventory");
        end,

        [Children] = { UIGradient(), New("UIStroke")({
                ApplyStrokeMode = "Border",
                Color = Color3.new(1, 1, 1),
                Thickness = 2,
                Transparency = 0,
                [Children] = { UIGradient() }
            }), New("ImageLabel")({
                AnchorPoint = Vector2.new(0.5, 0.5),
                BorderColor3 = Color3.fromRGB(27, 42, 53),
                BackgroundTransparency = 1,
                Position = UDim2.fromScale(0.5, 0.5),
                Size = u2.ImageSize or UDim2.fromScale(1, 1),
                Image = u2.Image,
                [Children] = { UIGradient() }
            }) }
    });
end;