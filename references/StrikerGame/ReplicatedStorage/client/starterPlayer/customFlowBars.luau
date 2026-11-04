 

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local u2 = {
    ["2011x"] = {
        direction = "vertical",
        height = 0.6,
        max_attribute = "2011xCuriosity",
        position = UDim2.new(0, 6, 0.45, 0),
        anchor = Vector2.new(0, 0.5),
        canvas = Vector2.new(607, 1054),
        fill = {
            image = "rbxassetid://129476056770624",
            top = 4,
            bottom = 948,
            offset = Vector2.new(24.5, 26.5),
            size = Vector2.new(113, 961)
        },
        frames = {
            normal = {
                image = "rbxassetid://79345249723530",
                offset = Vector2.new(0, 0),
                size = Vector2.new(607, 1054)
            },
            max = {
                image = "rbxassetid://118993590307715",
                offset = Vector2.new(-2, 1),
                size = Vector2.new(581, 1084)
            }
        },
        shake = {
            strength = 2.5,
            rate = 30
        }
    },
    sonic = {
        direction = "horizontal",
        mount = "MagicHealth",
        width = 1,
        mount_offset = UDim2.fromOffset(-29, -30),
        position = UDim2.fromScale(0.5, 0.5),
        anchor = Vector2.new(0.5, 0.5),
        canvas = Vector2.new(512, 122),
        fill = {
            image = "rbxassetid://77640918526566",
            left = 0,
            right = 372,
            offset = Vector2.new(100, 61),
            size = Vector2.new(372, 11),
            color = Color3.fromRGB(0, 140, 255)
        },
        frames = {
            normal = {
                image = "rbxassetid://104693425990297",
                offset = Vector2.new(0, 0),
                size = Vector2.new(512, 122)
            }
        },
        hidden_labels = { "TextLabel" },
        sprite = {
            replace = "Awakening",
            image = "rbxassetid://100203563691850",
            columns = 6,
            frames = 30,
            fps = 33,
            frame_size = Vector2.new(64, 64),
            size = Vector2.new(25, 27),
            position = UDim2.new(0.764512241, 0, -1.4814589, 22),
            counter = {
                prefix = ":",
                height = 30,
                text_size = 26,
                position = UDim2.new(0.74861449, 19, -1.51111066, 22),
                font = Font.new("rbxasset://fonts/families/PressStart2P.json"),
                color = Color3.fromRGB(255, 255, 255),
                stroke = Color3.fromRGB(0, 40, 140)
            }
        },
        labels = {
            ModeText = {
                stroke_transparency = 0,
                color = Color3.fromRGB(20, 90, 255),
                stroke = Color3.fromRGB(255, 255, 255),
                offset = UDim2.fromOffset(0, 12)
            }
        }
    }
};

local function scaled(p3, p4, p5) -- Line: 80
    return UDim2.fromScale(p4.X / p3.X, p4.Y / p3.Y), UDim2.fromScale(p5.X / p3.X, p5.Y / p3.Y);
end;

local function image(p6: string, p7: userdata, p8: number) -- Line: 84
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = p6;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.ScaleType = Enum.ScaleType.Stretch;
    ImageLabel.ZIndex = p8;
    ImageLabel.Parent = p7;

    return ImageLabel;
end;

function u1.Has(p9: string?) -- Line: 94
    -- upvalues: u2 (copy)
    local v10;

    if p9 == nil then
        v10 = false;
    else
        v10 = u2[p9] ~= nil;
    end;

    return v10;
end;

function u1.Mount(p11: userdata, u12: string?) -- Line: 98
    -- upvalues: u2 (copy), u1 (copy), RunService (copy)
    if u12 then
        u12 = u2[u12];
    end;

    if not u12 then
        return nil;
    end;

    local v13 = u12.direction == "horizontal";
    local v14;

    if u12.mount then
        v14 = p11:FindFirstChild(u12.mount, true) or p11;
    else
        v14 = p11;
    end;

    local canvas = u12.canvas;
    local Frame = Instance.new("Frame");
    Frame.Name = "CustomFlowBar";
    Frame.AnchorPoint = u12.anchor;
    Frame.Position = u12.position;
    local v15;

    if v13 then
        v15 = UDim2.fromScale(u12.width, u12.width * canvas.Y / canvas.X);
    else
        v15 = UDim2.fromScale(1, u12.height);
    end;

    Frame.Size = v15;

    if v13 then
        Frame.SizeConstraint = Enum.SizeConstraint.RelativeXX;
    end;

    Frame.BackgroundTransparency = 1;
    Frame.ZIndex = 2;

    if not v13 then
        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
        UIAspectRatioConstraint.AspectRatio = canvas.X / canvas.Y;
        UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height;
        UIAspectRatioConstraint.Parent = Frame;
    end;

    local fill = u12.fill;
    local offset = fill.offset;
    local size = fill.size;
    local UDim2_fromScale_ret = UDim2.fromScale(offset.X / canvas.X, offset.Y / canvas.Y);
    local UDim2_fromScale_ret2 = UDim2.fromScale(size.X / canvas.X, size.Y / canvas.Y);
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "FillClip";
    Frame2.BackgroundTransparency = 1;
    Frame2.ClipsDescendants = true;
    Frame2.ZIndex = 2;

    if v13 then
        Frame2.AnchorPoint = Vector2.new(0, 0);
        Frame2.Position = UDim2_fromScale_ret;
        Frame2.Size = UDim2.fromScale(0, UDim2_fromScale_ret2.Y.Scale);
    else
        Frame2.AnchorPoint = Vector2.new(0, 1);
        Frame2.Position = UDim2.fromScale(UDim2_fromScale_ret.X.Scale, UDim2_fromScale_ret.Y.Scale + UDim2_fromScale_ret2.Y.Scale);
        Frame2.Size = UDim2.fromScale(UDim2_fromScale_ret2.X.Scale, 0);
    end;

    Frame2.Parent = Frame;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Fill";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.ScaleType = Enum.ScaleType.Stretch;
    ImageLabel.ZIndex = 2;
    ImageLabel.Parent = Frame2;
    ImageLabel.Image = fill.image;

    if fill.color then
        ImageLabel.ImageColor3 = fill.color;
    end;

    if v13 then
        ImageLabel.AnchorPoint = Vector2.new(0, 0);
        ImageLabel.Position = UDim2.fromScale(0, 0);
    else
        ImageLabel.AnchorPoint = Vector2.new(0, 1);
        ImageLabel.Position = UDim2.fromScale(0, 1);
    end;

    local v16 = {};

    for i, v in u12.frames do
        local offset2 = v.offset;
        local size2 = v.size;
        local UDim2_fromScale_ret3 = UDim2.fromScale(offset2.X / canvas.X, offset2.Y / canvas.Y);
        local UDim2_fromScale_ret4 = UDim2.fromScale(size2.X / canvas.X, size2.Y / canvas.Y);
        local ImageLabel2 = Instance.new("ImageLabel");
        ImageLabel2.Name = i == "max" and "FrameMax" or "Frame";
        ImageLabel2.BackgroundTransparency = 1;
        ImageLabel2.ScaleType = Enum.ScaleType.Stretch;
        ImageLabel2.ZIndex = 3;
        ImageLabel2.Parent = Frame;
        ImageLabel2.Image = v.image;
        ImageLabel2.Position = UDim2_fromScale_ret3;
        ImageLabel2.Size = UDim2_fromScale_ret4;
        ImageLabel2.Visible = i == "normal";
        v16[i] = ImageLabel2;
    end;

    local NumberValue = Instance.new("NumberValue");
    NumberValue.Name = "Progress";
    NumberValue.Parent = Frame;
    local u17 = setmetatable({
        maxed = false,
        ready = false,
        tween = nil,
        root = Frame,
        clip = Frame2,
        fillImage = ImageLabel,
        frames = v16,
        progress = NumberValue,
        definition = u12,
        horizontal = v13
    }, u1);
    u17.connection = NumberValue.Changed:Connect(function(p18) -- Line: 184
        -- upvalues: u17 (copy)
        u17:_render(p18);
    end);
    local u19 = u12.max_attribute and game:GetService("Players").LocalPlayer.Character;

    if u19 then
        u17.max_connection = u19:GetAttributeChangedSignal(u12.max_attribute):Connect(function() -- Line: 191
            -- upvalues: u17 (copy), u19 (copy), u12 (copy)
            u17:_setMaxed(u19:GetAttribute(u12.max_attribute) == true);
        end);
        Frame.Destroying:Once(function() -- Line: 194
            -- upvalues: u17 (copy)
            if u17.max_connection then
                u17.max_connection:Disconnect();
                u17.max_connection = nil;
            end;
        end);
    end;

    u17:_render(0);
    Frame.Parent = v14;

    if u12.mount_offset and (v14 ~= p11 and v14:IsA("GuiObject")) then
        v14.Position = v14.Position + u12.mount_offset;
    end;

    u17.hidden_connections = {};

    if u12.hidden_labels and v14 ~= p11 then
        for _, v in u12.hidden_labels do
            local u20 = v14:FindFirstChild(v);

            if u20 and u20:IsA("GuiObject") then
                u20.Visible = false;
                local hidden_connections = u17.hidden_connections;
                local PropertyChangedSignal = u20:GetPropertyChangedSignal("Visible");
                table.insert(hidden_connections, PropertyChangedSignal:Connect(function() -- Line: 214
                    -- upvalues: u20 (copy)
                    if u20.Visible then
                        u20.Visible = false;
                    end;
                end));
            end;
        end;

        Frame.Destroying:Once(function() -- Line: 221
            -- upvalues: u17 (copy)
            for _, v in u17.hidden_connections do
                v:Disconnect();
            end;

            table.clear(u17.hidden_connections);
        end);
    end;

    local sprite = u12.sprite;
    local u21;

    if sprite then
        u21 = p11:FindFirstChild(sprite.replace, true);
    else
        u21 = sprite;
    end;

    if sprite and (u21 and u21:IsA("GuiObject")) then
        u21.Visible = false;
        u17.sprite_visibility = u21:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 233
            -- upvalues: u21 (copy)
            if u21.Visible then
                u21.Visible = false;
            end;
        end);
        local Size = u21.Size;
        local AnchorPoint = u21.AnchorPoint;
        local Parent = u21.Parent;
        local ZIndex = u21.ZIndex;
        local ImageLabel2 = Instance.new("ImageLabel");
        ImageLabel2.Name = "FlowSprite";
        ImageLabel2.BackgroundTransparency = 1;
        ImageLabel2.ScaleType = Enum.ScaleType.Stretch;
        ImageLabel2.ZIndex = ZIndex;
        ImageLabel2.Parent = Parent;
        ImageLabel2.Image = sprite.image;
        ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel2.Position = sprite.position or u21.Position + UDim2.new(Size.X.Scale * (0.5 - AnchorPoint.X), Size.X.Offset * (0.5 - AnchorPoint.X), Size.Y.Scale * (0.5 - AnchorPoint.Y), Size.Y.Offset * (0.5 - AnchorPoint.Y));
        local v22;

        if typeof(sprite.size) == "Vector2" then
            v22 = sprite.size;
        else
            v22 = Vector2.new(sprite.size, sprite.size);
        end;

        ImageLabel2.Size = UDim2.fromOffset(v22.X, v22.Y);
        ImageLabel2.ImageRectSize = sprite.frame_size;
        u17.sprite_image = ImageLabel2;
        local counter = sprite.counter;

        if counter then
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "FlowCounter";
            TextLabel.BackgroundTransparency = 1;
            TextLabel.AnchorPoint = Vector2.new(0, 0.5);
            TextLabel.Position = counter.position or ImageLabel2.Position + UDim2.fromOffset(v22.X / 2 + (counter.gap or 4), 0);
            TextLabel.AutomaticSize = Enum.AutomaticSize.X;
            TextLabel.Size = UDim2.fromOffset(0, counter.height or v22.Y);
            TextLabel.FontFace = counter.font;
            TextLabel.TextSize = counter.text_size;
            TextLabel.TextColor3 = counter.color;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.ZIndex = ImageLabel2.ZIndex;
            TextLabel.Text = counter.prefix .. "0";
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Color = counter.stroke;
            UIStroke.Thickness = 2;
            UIStroke.Parent = TextLabel;
            TextLabel.Parent = ImageLabel2.Parent;
            u17.sprite_counter = TextLabel;
        end;

        u17.sprite_connection = RunService.RenderStepped:Connect(function() -- Line: 273
            -- upvalues: sprite (copy), ImageLabel2 (copy)
            local v23 = os.clock() * sprite.fps;
            local v24 = math.floor(v23) % sprite.frames;
            ImageLabel2.ImageRectOffset = Vector2.new(v24 % sprite.columns * sprite.frame_size.X, math.floor(v24 / sprite.columns) * sprite.frame_size.Y);
        end);
        Frame.Destroying:Once(function() -- Line: 277
            -- upvalues: u17 (copy)
            u17:_stopSprite();
        end);
    end;

    if u12.labels then
        for i, v in u12.labels do
            local v25 = p11:FindFirstChild(i, true);

            if v25 and v25:IsA("TextLabel") then
                if v.color then
                    v25.TextColor3 = v.color;
                end;

                if v.stroke then
                    v25.TextStrokeColor3 = v.stroke;
                end;

                if v.stroke_transparency then
                    v25.TextStrokeTransparency = v.stroke_transparency;
                end;

                if v.offset then
                    v25.Position = v25.Position + v.offset;
                end;
            end;
        end;
    end;

    return u17;
end;

function u1._render(p26: table, p27: number) -- Line: 306
    local fill = p26.definition.fill;
    local canvas = p26.definition.canvas;
    local math_clamp_ret = math.clamp(p27, 0, 1);
    p26.clip.Visible = p27 > 0;

    if p26.sprite_counter then
        p26.sprite_counter.Text = p26.definition.sprite.counter.prefix .. math.floor(math_clamp_ret * 100 + 0.5);
    end;

    if p26.horizontal then
        local X = fill.size.X;
        local v28;

        if p27 >= 1 then
            v28 = X;
        else
            v28 = fill.left + (fill.right - fill.left) * math_clamp_ret;
        end;

        p26.clip.Size = UDim2.fromScale(fill.size.X / canvas.X * v28 / X, p26.clip.Size.Y.Scale);
        p26.fillImage.Size = UDim2.fromScale(X / math.max(v28, 1), 1);

        return;
    end;

    local Y = fill.size.Y;
    local v29 = Y - (p27 >= 1 and 0 or fill.bottom - (fill.bottom - fill.top) * math_clamp_ret);
    p26.clip.Size = UDim2.fromScale(p26.clip.Size.X.Scale, fill.size.Y / canvas.Y * v29 / Y);
    p26.fillImage.Size = UDim2.fromScale(1, Y / math.max(v29, 1));
end;

function u1.Set(p30: table, p31: number, p32: boolean?) -- Line: 330
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    local math_clamp_ret = math.clamp(p31, 0, 1);
    local v33 = math_clamp_ret >= 1 and true or p32 == true;

    if p30.tween then
        p30.tween:Cancel();
    end;

    p30.tween = TweenService:Create(p30.progress, TweenInfo_new_ret, {
        Value = math_clamp_ret
    });
    p30.tween:Play();
    local v34;

    if math_clamp_ret >= 1 then
        v34 = p32 ~= true;
    else
        v34 = false;
    end;

    p30:_setReady(v34);
    local max_attribute = p30.definition.max_attribute;

    if not max_attribute then
        p30:_setMaxed(v33);

        return;
    end;

    local Character = game:GetService("Players").LocalPlayer.Character;
    local v35;

    if Character == nil then
        v35 = false;
    else
        v35 = Character:GetAttribute(max_attribute) == true;
    end;

    p30:_setMaxed(v35);
end;

function u1._setMaxed(p36: table, p37: boolean) -- Line: 351
    if p37 == p36.maxed then
        return;
    end;

    p36.maxed = p37;

    if p36.frames.max then
        p36.frames.normal.Visible = not p37;
        p36.frames.max.Visible = p37;
    end;

    local fill = p36.definition.fill;

    if fill.color and fill.max_color then
        local v38;

        if p37 then
            v38 = fill.max_color;
        else
            v38 = fill.color;
        end;

        p36.fillImage.ImageColor3 = v38;
    end;
end;

function u1._setReady(u39: table, p40: boolean) -- Line: 368
    -- upvalues: RunService (copy)
    local shake = u39.definition.shake;

    if not shake or p40 == u39.ready then
        return;
    end;

    u39.ready = p40;

    if u39.shake_connection then
        u39.shake_connection:Disconnect();
        u39.shake_connection = nil;
    end;

    local position = u39.definition.position;
    u39.root.Position = position;

    if not p40 then
        return;
    end;

    local u41 = 1 / shake.rate;
    local u42 = 0;
    u39.shake_connection = RunService.RenderStepped:Connect(function(p43) -- Line: 388
        -- upvalues: u42 (ref), u41 (copy), u39 (copy), position (copy), shake (copy)
        u42 = u42 + p43;

        if u42 < u41 then
            return;
        end;

        u42 = 0;
        u39.root.Position = position + UDim2.fromOffset((math.random() * 2 - 1) * shake.strength, (math.random() * 2 - 1) * shake.strength);
    end);
    u39.root.Destroying:Once(function() -- Line: 396
        -- upvalues: u39 (copy)
        if u39.shake_connection then
            u39.shake_connection:Disconnect();
            u39.shake_connection = nil;
        end;
    end);
end;

function u1._stopSprite(p44) -- Line: 404
    if p44.sprite_connection then
        p44.sprite_connection:Disconnect();
        p44.sprite_connection = nil;
    end;

    if p44.sprite_visibility then
        p44.sprite_visibility:Disconnect();
        p44.sprite_visibility = nil;
    end;

    if p44.sprite_image then
        p44.sprite_image:Destroy();
        p44.sprite_image = nil;
    end;

    if p44.sprite_counter then
        p44.sprite_counter:Destroy();
        p44.sprite_counter = nil;
    end;
end;

function u1.Destroy(p45) -- Line: 423
    if p45.tween then
        p45.tween:Cancel();
    end;

    p45.connection:Disconnect();

    if p45.shake_connection then
        p45.shake_connection:Disconnect();
        p45.shake_connection = nil;
    end;

    p45:_stopSprite();
    p45.root:Destroy();
end;

return u1;