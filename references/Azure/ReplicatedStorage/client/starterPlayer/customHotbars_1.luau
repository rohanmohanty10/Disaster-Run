 
 

game:GetService("Players");
game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local u2 = {
    ["2011x"] = {
        frame = "rbxassetid://71789231315775",
        frameScale = 1.45,
        slotPadding = 32,
        hideFlowLabels = true,
        textColor = Color3.fromRGB(255, 25, 25)
    },
    sonic = {
        frame = "rbxassetid://123527190080329",
        frameScale = 1.1,
        fit_text = 0.8,
        cooldown_inset = 0.8,
        overtime_flow = {
            move = "FINALE",
            sprite = {
                image = "rbxassetid://132053073500613",
                columns = 8,
                frames = 59,
                fps = 24,
                frame_size = Vector2.new(128, 128)
            }
        }
    }
};
local u3 = { "Awakening", "ModeText", "saeText", "TextLabel" };
local u4 = { "ToolName", "Number" };

function u1.Has(p5: string?) -- Line: 31
    -- upvalues: u2 (copy)
    local v6;

    if p5 == nil then
        v6 = false;
    else
        v6 = u2[p5] ~= nil;
    end;

    return v6;
end;

function u1.Mount(p7: userdata, u8: string?) -- Line: 35
    -- upvalues: u2 (copy), u1 (copy), u4 (copy), RunService (copy), u3 (copy)
    if u8 then
        u8 = u2[u8];
    end;

    if not u8 then
        return nil;
    end;

    local u9 = setmetatable({
        connections = {},
        definition = u8
    }, u1);
    local overtime_flow = u8.overtime_flow;
    local u10 = {};

    local function keep(u11: userdata, u12: string, u13: any) -- Line: 45
        -- upvalues: u9 (copy)
        u11[u12] = u13;
        local connections = u9.connections;
        local PropertyChangedSignal = u11:GetPropertyChangedSignal(u12);
        table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 47
            -- upvalues: u11 (copy), u12 (copy), u13 (copy)
            if u11[u12] ~= u13 then
                u11[u12] = u13;
            end;
        end));
    end;

    local function styleSlot(u14: userdata) -- Line: 54
        -- upvalues: u8 (copy), u9 (copy), overtime_flow (copy), u10 (copy), u4 (ref)
        if not u14:IsA("GuiButton") or u14:FindFirstChild("CustomFrame") then
            return;
        end;

        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "CustomFrame";
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
        ImageLabel.Size = UDim2.fromScale(u8.frameScale, u8.frameScale);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = u8.frame;
        ImageLabel.ScaleType = Enum.ScaleType.Stretch;
        ImageLabel.ZIndex = 1;
        ImageLabel.Parent = u14;
        local Cooldown = u14:FindFirstChild("Cooldown");

        if u8.cooldown_inset and (Cooldown and Cooldown:IsA("GuiObject")) then
            local UDim2_fromScale_ret = UDim2.fromScale(0.5, 0.5 + u8.cooldown_inset / 2);
            Cooldown.Position = UDim2_fromScale_ret;
            local connections = u9.connections;
            local PropertyChangedSignal = Cooldown:GetPropertyChangedSignal("Position");
            local u15 = "Position";
            table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 47
                -- upvalues: Cooldown (copy), u15 (copy), UDim2_fromScale_ret (copy)
                if Cooldown[u15] ~= UDim2_fromScale_ret then
                    Cooldown[u15] = UDim2_fromScale_ret;
                end;
            end));
            local v16 = Cooldown:FindFirstChild("CooldownInset") or Instance.new("UIScale");
            v16.Name = "CooldownInset";
            v16.Scale = u8.cooldown_inset;
            v16.Parent = Cooldown;
        end;

        local Base = u14:FindFirstChild("Base");

        if not Base then
            return;
        end;

        Base.BackgroundTransparency = 1;
        local connections = u9.connections;
        local PropertyChangedSignal = Base:GetPropertyChangedSignal("BackgroundTransparency");
        local u17 = "BackgroundTransparency";
        local u18 = 1;
        table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 47
            -- upvalues: Base (copy), u17 (copy), u18 (copy)
            if Base[u17] ~= u18 then
                Base[u17] = u18;
            end;
        end));
        local ToolName = Base:FindFirstChild("ToolName");

        if u8.fit_text and (ToolName and ToolName:IsA("TextLabel")) then
            local TextSize = ToolName.TextSize;
            ToolName.AnchorPoint = Vector2.new(0.5, 0.5);
            ToolName.Position = UDim2.fromScale(0.5, 0.5);
            ToolName.Size = UDim2.fromScale(u8.fit_text, u8.fit_text);
            ToolName.TextScaled = true;
            local v19 = ToolName:FindFirstChildOfClass("UITextSizeConstraint") or Instance.new("UITextSizeConstraint");
            v19.MaxTextSize = TextSize;
            v19.Parent = ToolName;
        end;

        if overtime_flow and (ToolName and ToolName:IsA("TextLabel")) then
            u10[u14] = {
                active = false,
                tool_name = ToolName,
                frame = ImageLabel
            };
            table.insert(u9.connections, u14.Destroying:Connect(function() -- Line: 100
                -- upvalues: u10 (ref), u14 (copy)
                u10[u14] = nil;
            end));
        end;

        if u8.textColor then
            for _, v in u4 do
                local u20 = Base:FindFirstChild(v);

                if u20 and u20:IsA("TextLabel") then
                    local textColor = u8.textColor;
                    u20.TextColor3 = textColor;
                    local connections2 = u9.connections;
                    local PropertyChangedSignal2 = u20:GetPropertyChangedSignal("TextColor3");
                    local u21 = "TextColor3";
                    table.insert(connections2, PropertyChangedSignal2:Connect(function() -- Line: 47
                        -- upvalues: u20 (copy), u21 (copy), textColor (copy)
                        if u20[u21] ~= textColor then
                            u20[u21] = textColor;
                        end;
                    end));
                end;
            end;
        end;
    end;

    local v22 = p7:FindFirstChild("Backpack") and p7.Backpack:FindFirstChild("Hotbar");

    if v22 then
        local v23 = v22:FindFirstChildOfClass("UIListLayout");

        if v23 and u8.slotPadding then
            v23.Padding = UDim.new(0, u8.slotPadding);
        end;

        for _, child in v22:GetChildren() do
            styleSlot(child);
        end;

        table.insert(u9.connections, v22.ChildAdded:Connect(styleSlot));
    end;

    if overtime_flow then
        local sprite = overtime_flow.sprite;
        local u24 = overtime_flow.frame_scale or u8.frameScale;

        local function apply(p25: any, p26: boolean) -- Line: 130
            -- upvalues: u24 (copy), u8 (copy), sprite (copy)
            p25.active = p26;
            local frame = p25.frame;
            local v27;

            if p26 then
                v27 = u24;
            else
                v27 = u8.frameScale;
            end;

            frame.Size = UDim2.fromScale(v27, v27);

            if p26 and sprite.image ~= "" then
                frame.Image = sprite.image;
                frame.ImageRectSize = sprite.frame_size;

                return;
            end;

            frame.Image = u8.frame;
            frame.ImageRectSize = Vector2.zero;
            frame.ImageRectOffset = Vector2.zero;
        end;

        table.insert(u9.connections, RunService.RenderStepped:Connect(function() -- Line: 146
            -- upvalues: sprite (copy), u10 (copy), overtime_flow (copy), apply (copy)
            local v28 = os.clock() * sprite.fps;
            local v29 = math.floor(v28) % sprite.frames;
            local v30 = Vector2.new(v29 % sprite.columns, v29 // sprite.columns) * sprite.frame_size;

            for _, v in u10 do
                local v31 = v.tool_name.Text == overtime_flow.move;

                if v.active ~= v31 then
                    apply(v, v31);
                end;

                if v31 and sprite.image ~= "" then
                    v.frame.ImageRectOffset = v30;
                end;
            end;
        end));
        table.insert(u9.connections, p7.Destroying:Connect(function() -- Line: 159
            -- upvalues: u9 (copy)
            u9:Destroy();
        end));
    end;

    local MagicHealth = p7:FindFirstChild("MagicHealth");

    if u8.hideFlowLabels and MagicHealth then
        for _, v in u3 do
            local u32 = MagicHealth:FindFirstChild(v);

            if u32 and u32:IsA("GuiObject") then
                u32.Visible = false;
                local connections = u9.connections;
                local PropertyChangedSignal = u32:GetPropertyChangedSignal("Visible");
                local u33 = "Visible";
                local u34 = false;
                table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 47
                    -- upvalues: u32 (copy), u33 (copy), u34 (copy)
                    if u32[u33] ~= u34 then
                        u32[u33] = u34;
                    end;
                end));
            end;
        end;
    end;

    return u9;
end;

function u1.Destroy(p35) -- Line: 177
    for _, v in p35.connections do
        v:Disconnect();
    end;

    table.clear(p35.connections);
end;

return u1;