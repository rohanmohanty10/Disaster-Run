 

 

local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Palette = Skin.Palette;
local u5 = {
    Colors = {
        Panel = Palette.surface,
        Surface = Palette.row,
        Text = Palette.text,
        Muted = Palette.textSecondary,
        Blue = Palette.meter,
        Mint = Palette.green,
        Gold = Palette.gold,
        Red = Palette.danger,
        Border = Palette.neutral
    },

    make = function(p1, p2, p3, p4) -- Line: 11, Name: make
        local Instance_new_ret = Instance.new(p1);
        Instance_new_ret.Name = p2;

        for i, v in p4 or {} do
            Instance_new_ret[i] = v;
        end;

        Instance_new_ret.Parent = p3;

        return Instance_new_ret;
    end
};

function u5.corner(p6, p7) -- Line: 16
    -- upvalues: u5 (copy)
    return u5.make("UICorner", "Corner", p6, {
        CornerRadius = UDim.new(0, p7 or 12)
    });
end;

function u5.card(p8, p9) -- Line: 17
    -- upvalues: u5 (copy), Skin (copy)
    local v10 = u5.make("Frame", p8, p9, {
        BackgroundTransparency = 0.12,
        BorderSizePixel = 0,
        BackgroundColor3 = u5.Colors.Panel
    });
    u5.corner(v10);
    u5.make("UIStroke", "Border", v10, {
        Transparency = 0,
        Thickness = 2,
        Color = u5.Colors.Border,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        BorderStrokePosition = Enum.BorderStrokePosition.Inner,
        LineJoinMode = Enum.LineJoinMode.Round
    });
    Skin.outline(v10, 2);

    return v10;
end;

function u5.text(p11, p12, p13, p14) -- Line: 24
    -- upvalues: u5 (copy), Skin (copy)
    local v15 = u5.make("TextLabel", p11, p12, {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        TextWrapped = true,
        Font = Enum.Font.GothamMedium,
        TextSize = p13 or 16,
        TextColor3 = p14 or u5.Colors.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    });
    Skin.textStroke(v15, 1);

    return v15;
end;

return u5;