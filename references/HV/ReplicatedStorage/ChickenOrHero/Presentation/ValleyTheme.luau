 

 

local u1 = {
    Ink = Color3.fromRGB(12, 28, 30),
    InventoryInk = Color3.fromRGB(16, 31, 46),
    Paper = Color3.fromRGB(240, 236, 218),
    Muted = Color3.fromRGB(166, 187, 179),
    Gold = Color3.fromRGB(228, 203, 137),
    Mint = Color3.fromRGB(127, 217, 191),
    Gem = Color3.fromRGB(87, 235, 159),
    Blue = Color3.fromRGB(147, 208, 237),
    Purple = Color3.fromRGB(197, 151, 255),
    Border = Color3.fromRGB(92, 124, 115)
};

function u1.surface(p2, p3, p4, p5, p6) -- Line: 14
    -- upvalues: u1 (copy)
    p2.BackgroundColor3 = p3;
    p2.BorderSizePixel = 0;
    local v7 = p2:FindFirstChildOfClass("UIGradient");

    if v7 then
        v7.Enabled = false;
    end;

    local v8 = p2:FindFirstChildOfClass("UICorner") or Instance.new("UICorner");
    v8.Name = "Corner";
    v8.CornerRadius = UDim.new(0, p5 or 5);
    v8.Parent = p2;
    local v9 = p2:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke");
    v9.Name = "Border";
    v9.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    v9.Thickness = 1;
    v9.Color = p4 or u1.Border;
    v9.Transparency = p6 or 0.62;
    v9.Parent = p2;
end;

function u1.button(p10, p11, p12) -- Line: 26
    -- upvalues: u1 (copy)
    u1.surface(p10, p12 or u1.Ink:Lerp(p11, 0.1), p11, 5, 0.62);
    p10.TextColor3 = u1.Paper;
    p10.Font = Enum.Font.GothamBold;
end;

return u1;