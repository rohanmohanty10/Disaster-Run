 

 

local KnifeClipPreview = require(script.Parent.KnifeClipPreview);
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Color3_fromRGB_ret = Color3.fromRGB(23, 23, 25);
local Color3_fromRGB_ret2 = Color3.fromRGB(80, 255, 100);
local u1 = {};
u1.__index = u1;

local function style(p2, p3) -- Line: 14
    -- upvalues: Color3_fromRGB_ret2 (copy)
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = p3;
    UICorner.Parent = p2;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret2;
    UIStroke.Thickness = 2;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = p2;
end;

local function wire(u4, u5) -- Line: 24
    -- upvalues: KnifeClipPreview (copy)
    u4.connection = u4.button.Activated:Connect(function() -- Line: 25
        -- upvalues: u4 (copy), u5 (copy), KnifeClipPreview (ref)
        if u4.skin then
            u5:Fire("KnifePreview", u4.skin, KnifeClipPreview.first(u4.skin));
        end;
    end);

    return u4;
end;

function u1.row(p6, u7) -- Line: 32
    -- upvalues: Color3_fromRGB_ret (copy), Font_new_ret (copy), Color3_fromRGB_ret2 (copy), u1 (copy), KnifeClipPreview (copy)
    local v8 = 1;

    for _, descendant in p6:GetDescendants() do
        if descendant:IsA("GuiObject") then
            v8 = math.max(v8, descendant.ZIndex);
        end;
    end;

    local TextButton = Instance.new("TextButton");
    TextButton.Name = "ViewAnimations";
    TextButton.Size = UDim2.fromScale(1, 1);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret;
    TextButton.BackgroundTransparency = 0;
    TextButton.AutoButtonColor = true;
    TextButton.FontFace = Font_new_ret;
    TextButton.Text = "VIEW SOUNDS AND ANIMATIONS";
    TextButton.TextColor3 = Color3.new(1, 1, 1);
    TextButton.TextScaled = true;
    TextButton.TextWrapped = true;
    TextButton.ZIndex = v8 + 2;
    TextButton.Visible = false;
    TextButton:SetAttribute("SelfManagedText", true);
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = 16;
    UITextSizeConstraint.Parent = TextButton;
    local UIPadding = Instance.new("UIPadding");
    local UDim_new_ret = UDim.new(0, 4);
    local UDim_new_ret2 = UDim.new(0, 4);
    UIPadding.PaddingLeft = UDim_new_ret;
    UIPadding.PaddingRight = UDim_new_ret2;
    local UDim_new_ret3 = UDim.new(0, 2);
    local UDim_new_ret4 = UDim.new(0, 2);
    UIPadding.PaddingTop = UDim_new_ret3;
    UIPadding.PaddingBottom = UDim_new_ret4;
    UIPadding.Parent = TextButton;
    local UDim_new_ret5 = UDim.new(0, 8);
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim_new_ret5;
    UICorner.Parent = TextButton;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret2;
    UIStroke.Thickness = 2;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = TextButton;
    TextButton.Parent = p6;
    local u9 = setmetatable({
        button = TextButton
    }, u1);
    u9.connection = u9.button.Activated:Connect(function() -- Line: 25
        -- upvalues: u9 (copy), u7 (copy), KnifeClipPreview (ref)
        if u9.skin then
            u7:Fire("KnifePreview", u9.skin, KnifeClipPreview.first(u9.skin));
        end;
    end);

    return u9;
end;

function u1.new(p10, u11) -- Line: 65
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Font_new_ret (copy), u1 (copy), KnifeClipPreview (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "PreviewButton";
    TextButton.AnchorPoint = Vector2.new(1, 0);
    TextButton.Position = UDim2.new(1, -10, 0, 10);
    TextButton.Size = UDim2.fromOffset(104, 30);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret;
    TextButton.BackgroundTransparency = 0.1;
    TextButton.AutoButtonColor = true;
    TextButton.Text = "";
    TextButton.ZIndex = 20;
    TextButton.Visible = false;
    local UDim_new_ret = UDim.new(0.5, 0);
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim_new_ret;
    UICorner.Parent = TextButton;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret2;
    UIStroke.Thickness = 2;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = TextButton;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "TextLabel";
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.Text = "PREVIEW";
    TextLabel.TextSize = 14;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.ZIndex = 21;
    TextLabel.Parent = TextButton;
    TextButton.Parent = p10;
    local u12 = setmetatable({
        button = TextButton
    }, u1);
    u12.connection = u12.button.Activated:Connect(function() -- Line: 25
        -- upvalues: u12 (copy), u11 (copy), KnifeClipPreview (ref)
        if u12.skin then
            u11:Fire("KnifePreview", u12.skin, KnifeClipPreview.first(u12.skin));
        end;
    end);

    return u12;
end;

function u1.set(p13, p14) -- Line: 91
    -- upvalues: KnifeClipPreview (copy)
    if p14 == p13.skin then
        return;
    end;

    p13.skin = p14;
    local v15;

    if p14 == nil then
        v15 = false;
    else
        v15 = KnifeClipPreview.has(p14);
    end;

    p13.button.Visible = v15;
end;

function u1.destroy(p16) -- Line: 99
    p16.connection:Disconnect();
    p16.button:Destroy();
end;

return u1;