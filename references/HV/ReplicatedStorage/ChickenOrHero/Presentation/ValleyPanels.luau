 

 

local u1 = {};
local FullscreenBackdrop = require(script.Parent.FullscreenBackdrop);
local Cursor = require(script.Parent.Parent:WaitForChild("Interface"):WaitForChild("Cursor"));

function u1.fullscreenShade(p2, p3) -- Line: 5
    -- upvalues: FullscreenBackdrop (copy)
    return FullscreenBackdrop.bind(p2, p3);
end;

u1.Ink = Color3.fromRGB(15, 26, 38);
u1.Paper = Color3.fromRGB(232, 237, 228);
u1.Muted = Color3.fromRGB(151, 175, 183);
u1.Gold = Color3.fromRGB(235, 201, 137);
u1.Blue = Color3.fromRGB(125, 205, 228);
u1.Purple = Color3.fromRGB(184, 157, 241);

function u1.make(p4, p5, p6, p7) -- Line: 9
    local Instance_new_ret = Instance.new(p4);
    Instance_new_ret.Name = p6;

    for i, v in p7 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p5;

    return Instance_new_ret;
end;

function u1.corner(p8, p9) -- Line: 12
    -- upvalues: u1 (copy)
    u1.make("UICorner", p8, "Corner", {
        CornerRadius = UDim.new(0, p9 or 10)
    });
end;

function u1.stroke(p10, p11, p12) -- Line: 13
    -- upvalues: u1 (copy)
    u1.make("UIStroke", p10, "Outline", {
        Thickness = 1,
        Color = p11 or u1.Muted,
        Transparency = p12 or 0.6
    });
end;

function u1.text(p13, p14, p15, p16, p17, p18, p19, p20, p21) -- Line: 14
    -- upvalues: u1 (copy)
    return u1.make("TextLabel", p13, p14, {
        BackgroundTransparency = 1,
        TextWrapped = true,
        Position = UDim2.fromOffset(p16, p17),
        Size = UDim2.fromOffset(p18, p19),
        Text = p15,
        TextColor3 = p21 or u1.Paper,
        Font = Enum.Font.Gotham,
        TextSize = p20 or 16,
        TextXAlignment = Enum.TextXAlignment.Left
    });
end;

function u1.button(p22, p23, p24, p25, p26, p27, p28, p29) -- Line: 18
    -- upvalues: u1 (copy)
    local v30 = u1.make("TextButton", p22, p23, {
        TextSize = 14,
        BorderSizePixel = 0,
        AutoButtonColor = true,
        Position = UDim2.fromOffset(p25, p26),
        Size = UDim2.fromOffset(p27, p28),
        Text = p24,
        BackgroundColor3 = p29 or Color3.fromRGB(36, 56, 70),
        TextColor3 = u1.Paper,
        Font = Enum.Font.GothamBold
    });
    u1.corner(v30, 8);

    return v30;
end;

function u1.cursorWhileVisible(u31) -- Line: 25
    -- upvalues: Cursor (copy)
    local u32 = false;
    local u33 = {};

    local function shown() -- Line: 27
        -- upvalues: u31 (copy)
        local v34 = u31;

        while v34 do
            if v34:IsA("LayerCollector") then
                local v35 = v34.Enabled and v34:IsDescendantOf(game);

                return v35;
            end;

            if v34:IsA("GuiObject") and not v34.Visible then
                return false;
            end;

            v34 = v34.Parent;
        end;

        return false;
    end;

    local function update() -- Line: 36
        -- upvalues: shown (copy), u32 (ref), Cursor (ref), u31 (copy)
        local v36 = shown();

        if v36 ~= u32 then
            u32 = v36;

            if v36 then
                Cursor.request(u31);

                return;
            end;

            Cursor.release(u31);
        end;
    end;

    local function clear() -- Line: 40
        -- upvalues: u33 (copy)
        for _, v in u33 do
            v:Disconnect();
        end;

        table.clear(u33);
    end;

    local function watch() -- Line: 41
        -- upvalues: u33 (copy), u31 (copy), update (copy), shown (copy), u32 (ref), Cursor (ref)
        for _, v in u33 do
            v:Disconnect();
        end;

        table.clear(u33);
        local v37 = u31;

        while v37 do
            if v37:IsA("LayerCollector") then
                local PropertyChangedSignal = v37:GetPropertyChangedSignal("Enabled");
                table.insert(u33, PropertyChangedSignal:Connect(update));
                break;
            end;

            if v37:IsA("GuiObject") then
                local PropertyChangedSignal = v37:GetPropertyChangedSignal("Visible");
                table.insert(u33, PropertyChangedSignal:Connect(update));
            end;

            v37 = v37.Parent;
        end;

        local v38 = shown();

        if v38 ~= u32 then
            u32 = v38;

            if v38 then
                Cursor.request(u31);

                return;
            end;

            Cursor.release(u31);
        end;
    end;

    u31.AncestryChanged:Connect(watch);
    u31.Destroying:Connect(function() -- Line: 52
        -- upvalues: u33 (copy), u32 (ref), Cursor (ref), u31 (copy)
        for _, v in u33 do
            v:Disconnect();
        end;

        table.clear(u33);

        if u32 then
            u32 = false;
            Cursor.release(u31);
        end;
    end);
    watch();
end;

function u1.screen(p39, p40, p41) -- Line: 55
    -- upvalues: u1 (copy)
    return u1.make("ScreenGui", p39:WaitForChild("PlayerGui"), p40, {
        ResetOnSpawn = false,
        IgnoreGuiInset = false,
        DisplayOrder = p41 or 65,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    });
end;

function u1.panel(u42, p43, p44, p45) -- Line: 58
    -- upvalues: u1 (copy)
    local v46 = u1.make("Frame", u42, p43 .. "Shade", {
        BackgroundTransparency = 0.28,
        BorderSizePixel = 0,
        Visible = false,
        Active = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(0, 0, 0)
    });
    u1.fullscreenShade(u42, v46);
    local u47 = u1.make("Frame", v46, p43, {
        BorderSizePixel = 0,
        Active = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(p44, p45),
        BackgroundColor3 = u1.Ink
    });
    u1.corner(u47, 14);
    u1.stroke(u47, u1.Gold, 0.5);
    local u48 = u1.make("UIScale", u47, "Scale", {});
    u42:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 64, Name: layout
        -- upvalues: u42 (copy), u48 (copy), u47 (copy)
        local AbsoluteSize = u42.AbsoluteSize;

        if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
            u48.Scale = math.min(AbsoluteSize.X * 0.94 / u47.Size.X.Offset, AbsoluteSize.Y * 0.91 / u47.Size.Y.Offset, 1.25);
        end;
    end);
    local AbsoluteSize = u42.AbsoluteSize;

    if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
        u48.Scale = math.min(AbsoluteSize.X * 0.94 / u47.Size.X.Offset, AbsoluteSize.Y * 0.91 / u47.Size.Y.Offset, 1.25);
    end;

    local v49 = u1.button(u47, "Close", "×", p44 - 64, 16, 44, 40);
    v49.Modal = true;
    u1.cursorWhileVisible(v49);
    v49.TextSize = 26;

    return v46, u47, v49;
end;

return u1;