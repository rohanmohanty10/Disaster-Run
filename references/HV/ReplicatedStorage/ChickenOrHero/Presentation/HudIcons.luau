 

 

local u1 = {};
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local u2 = {
    Shop = "shop",
    Inventory = "dagger",
    Spectate = "spectate",
    Journey = "journey",
    AFK = "afk",
    Settings = "gear",
    Music = "music",
    MusicOff = "mute",
    Servers = "list",
    Updates = "scroll",
    Coins = "coin",
    Gems = "gem",
    Codes = "rbxassetid://100627084510770",
    Abilities = "rbxassetid://88625045611008",
    Combine = "dagger"
};
u1.Names = u2;

function u1.skin(p3, p4) -- Line: 9
    -- upvalues: u2 (copy), Skin (copy)
    local v5 = u2[p4];

    if p3 and v5 then
        Skin.icon(p3, v5);
    end;

    return p3;
end;

function u1.draw(p6, p7, u8) -- Line: 14
    -- upvalues: u1 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Icon";
    Frame.Size = UDim2.fromOffset(24, 24);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p6;

    local function line(p9, p10, p11, p12, p13) -- Line: 16
        -- upvalues: u8 (copy), Frame (copy)
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = u8;
        Frame2.Position = UDim2.fromOffset(p9, p10);
        Frame2.Size = UDim2.fromOffset(p11, p12);
        Frame2.Rotation = p13 or 0;
        Frame2.Parent = Frame;

        return Frame2;
    end;

    local function outline(p14, p15, p16, p17, p18) -- Line: 19
        -- upvalues: u8 (copy), Frame (copy)
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = u8;
        Frame2.Position = UDim2.fromOffset(p14, p15);
        Frame2.Size = UDim2.fromOffset(p16, p17);
        Frame2.Rotation = 0;
        Frame2.Parent = Frame;
        Frame2.BackgroundTransparency = 1;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = u8;
        UIStroke.Thickness = 1.5;
        UIStroke.Parent = Frame2;

        if p18 then
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0, p18);
            UICorner.Parent = Frame2;
        end;

        return Frame2;
    end;

    if p7 == "Shop" then
        outline(4, 8, 16, 13, 2);
        outline(8, 3, 8, 9, 4);
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = u8;
        Frame2.Position = UDim2.fromOffset(6, 8);
        Frame2.Size = UDim2.fromOffset(12, 2);
        Frame2.Rotation = 0;
        Frame2.Parent = Frame;
    elseif p7 == "Inventory" then
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = u8;
        Frame2.Position = UDim2.fromOffset(11, 1);
        Frame2.Size = UDim2.fromOffset(5, 14);
        Frame2.Rotation = 35;
        Frame2.Parent = Frame;
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        Frame3.BackgroundColor3 = u8;
        Frame3.Position = UDim2.fromOffset(5, 13);
        Frame3.Size = UDim2.fromOffset(13, 2);
        Frame3.Rotation = 35;
        Frame3.Parent = Frame;
        local Frame4 = Instance.new("Frame");
        Frame4.BorderSizePixel = 0;
        Frame4.BackgroundColor3 = u8;
        Frame4.Position = UDim2.fromOffset(6, 16);
        Frame4.Size = UDim2.fromOffset(3, 7);
        Frame4.Rotation = 35;
        Frame4.Parent = Frame;
    elseif p7 == "Spectate" then
        outline(2, 6, 20, 12, 8);
        outline(9, 9, 6, 6, 4);
    elseif p7 == "Journey" then
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = u8;
        Frame2.Position = UDim2.fromOffset(6, 6);
        Frame2.Size = UDim2.fromOffset(2, 13);
        Frame2.Rotation = 0;
        Frame2.Parent = Frame;
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        Frame3.BackgroundColor3 = u8;
        Frame3.Position = UDim2.fromOffset(7, 18);
        Frame3.Size = UDim2.fromOffset(11, 2);
        Frame3.Rotation = 0;
        Frame3.Parent = Frame;
        outline(3, 2, 8, 8, 2);
        outline(15, 15, 7, 7, 2);
    elseif p7 == "AFK" then
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = u8;
        Frame2.Position = UDim2.fromOffset(6, 4);
        Frame2.Size = UDim2.fromOffset(4, 16);
        Frame2.Rotation = 0;
        Frame2.Parent = Frame;
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        Frame3.BackgroundColor3 = u8;
        Frame3.Position = UDim2.fromOffset(14, 4);
        Frame3.Size = UDim2.fromOffset(4, 16);
        Frame3.Rotation = 0;
        Frame3.Parent = Frame;
    elseif p7 == "Settings" then
        for _, v in { { 5, 7 }, { 12, 16 }, { 19, 9 } } do
            local v19 = v[1];
            local Frame2 = Instance.new("Frame");
            Frame2.BorderSizePixel = 0;
            Frame2.BackgroundColor3 = u8;
            Frame2.Position = UDim2.fromOffset(v19, 3);
            Frame2.Size = UDim2.fromOffset(1, 18);
            Frame2.Rotation = 0;
            Frame2.Parent = Frame;
            outline(v[1] - 2, v[2], 5, 4, 1);
        end;
    elseif p7 == "Music" then
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = u8;
        Frame2.Position = UDim2.fromOffset(9, 4);
        Frame2.Size = UDim2.fromOffset(2, 14);
        Frame2.Rotation = 0;
        Frame2.Parent = Frame;
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        Frame3.BackgroundColor3 = u8;
        Frame3.Position = UDim2.fromOffset(18, 2);
        Frame3.Size = UDim2.fromOffset(2, 14);
        Frame3.Rotation = 0;
        Frame3.Parent = Frame;
        local Frame4 = Instance.new("Frame");
        Frame4.BorderSizePixel = 0;
        Frame4.BackgroundColor3 = u8;
        Frame4.Position = UDim2.fromOffset(9, 3);
        Frame4.Size = UDim2.fromOffset(11, 2);
        Frame4.Rotation = -10;
        Frame4.Parent = Frame;
        outline(3, 15, 7, 5, 3);
        outline(12, 13, 7, 5, 3);
    elseif p7 == "Servers" then
        for _, v in { 3, 13 } do
            outline(2, v, 20, 7, 1);
            local Frame2 = Instance.new("Frame");
            Frame2.BorderSizePixel = 0;
            Frame2.BackgroundColor3 = u8;
            Frame2.Position = UDim2.fromOffset(5, v + 3);
            Frame2.Size = UDim2.fromOffset(2, 2);
            Frame2.Rotation = 0;
            Frame2.Parent = Frame;
            local Frame3 = Instance.new("Frame");
            Frame3.BorderSizePixel = 0;
            Frame3.BackgroundColor3 = u8;
            Frame3.Position = UDim2.fromOffset(10, v + 3);
            Frame3.Size = UDim2.fromOffset(8, 1);
            Frame3.Rotation = 0;
            Frame3.Parent = Frame;
        end;
    elseif p7 == "Updates" then
        outline(4, 2, 16, 20, 1);
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = u8;
        Frame2.Position = UDim2.fromOffset(7, 6);
        Frame2.Size = UDim2.fromOffset(10, 2);
        Frame2.Rotation = 0;
        Frame2.Parent = Frame;

        for _, v in { 11, 15, 18 } do
            local Frame3 = Instance.new("Frame");
            Frame3.BorderSizePixel = 0;
            Frame3.BackgroundColor3 = u8;
            Frame3.Position = UDim2.fromOffset(7, v);
            Frame3.Size = UDim2.fromOffset(10, 1);
            Frame3.Rotation = 0;
            Frame3.Parent = Frame;
        end;
    elseif p7 == "Coins" then
        outline(3, 3, 18, 18, 12);
        outline(7, 7, 10, 10, 6);
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = u8;
        Frame2.Position = UDim2.fromOffset(11, 7);
        Frame2.Size = UDim2.fromOffset(2, 10);
        Frame2.Rotation = 0;
        Frame2.Parent = Frame;
    elseif p7 == "Gems" then
        outline(5, 5, 14, 14, 1).Rotation = 45;
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = u8;
        Frame2.Position = UDim2.fromOffset(11, 4);
        Frame2.Size = UDim2.fromOffset(1, 17);
        Frame2.Rotation = 0;
        Frame2.Parent = Frame;
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        Frame3.BackgroundColor3 = u8;
        Frame3.Position = UDim2.fromOffset(5, 11);
        Frame3.Size = UDim2.fromOffset(14, 1);
        Frame3.Rotation = 0;
        Frame3.Parent = Frame;
    end;

    u1.skin(Frame, p7);

    return Frame;
end;

function u1.mark(p20, p21) -- Line: 41
    -- upvalues: Skin (copy)
    if not p20 then
        return;
    end;

    local SkinAfkOff = p20:FindFirstChild("SkinAfkOff");

    if not SkinAfkOff then
        SkinAfkOff = Instance.new("ImageLabel");
        SkinAfkOff.Name = "SkinAfkOff";
        SkinAfkOff.BackgroundTransparency = 1;
        SkinAfkOff.Size = UDim2.fromScale(1, 1);
        SkinAfkOff.Image = Skin.Icons.afkOff;
        SkinAfkOff.ScaleType = Enum.ScaleType.Fit;
        SkinAfkOff.ZIndex = 8;
        SkinAfkOff.Parent = p20;
    end;

    SkinAfkOff.Visible = p21 == true;
end;

return u1;