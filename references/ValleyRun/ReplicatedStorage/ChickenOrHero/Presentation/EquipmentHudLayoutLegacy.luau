 

 

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local TouchCombatLayout = require(script.Parent.TouchCombatLayout);
local u1 = {};
local u2 = {};

function u1.register(u3, p4, p5) -- Line: 8
    -- upvalues: u2 (copy)
    u2[u3] = {
        scale = p4,
        order = p5
    };
    u3:SetAttribute("UIProportionalExclude", true);
    u3.Destroying:Once(function() -- Line: 11
        -- upvalues: u2 (ref), u3 (copy)
        u2[u3] = nil;
    end);
end;

function u1.update(p6) -- Line: 15
    -- upvalues: u2 (copy), u1 (copy), UserInputService (copy), TouchCombatLayout (copy), GuiService (copy)
    local HUD = p6:FindFirstChild("HUD");
    local v7;

    if HUD then
        v7 = HUD:FindFirstChild("MainFrame");
    else
        v7 = HUD;
    end;

    if v7 then
        v7 = v7:FindFirstChild("BarMainFrame");
    end;

    if not v7 then
        return;
    end;

    local v8 = {};

    for i, v in u2 do
        if i.Parent and i.Visible then
            table.insert(v8, {
                button = i,
                scale = v.scale,
                order = v.order
            });
        end;
    end;

    table.sort(v8, function(p9, p10) -- Line: 28
        return p9.order < p10.order;
    end);
    local v11 = #v8;
    u1.touchStack = nil;

    if v11 == 0 then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v12 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or HUD.AbsoluteSize;

    if not UserInputService.TouchEnabled then
        local v13 = math.min(v7.AbsoluteSize.X, v12.X * 0.92) / (v11 * 226 + (v11 - 1) * 10);
        local math_min_ret = math.min(1, v13, v12.Y * 0.14 / 88);
        local math_max_ret = math.max(math_min_ret * 88, v7.AbsolutePosition.Y - math_min_ret * 8);
        local v14 = math_min_ret * 0.782;
        local v15 = (v11 * 226 + (v11 - 1) * 10) * v14;
        local v16 = v7.AbsolutePosition.X + v7.AbsoluteSize.X * 0.5 - v15 * 0.5;
        local math_max_ret2 = math.max(0, v12.X - v15);
        local math_clamp_ret = math.clamp(v16, 0, math_max_ret2);

        for i, v in v8 do
            v.scale.Scale = v14;
            v.button.AnchorPoint = Vector2.new(0, 1);
            local AbsolutePosition = v.button.Parent.AbsolutePosition;
            v.button.Position = UDim2.fromOffset(math_clamp_ret + (i - 1) * 236 * v14 - AbsolutePosition.X, math_max_ret - AbsolutePosition.Y);
        end;

        return;
    end;

    local AbsoluteSize = HUD.AbsoluteSize;
    local v17 = math.min(AbsoluteSize.X, AbsoluteSize.Y) <= 500;
    local v18 = v17 and 70 or 120;
    local v19 = {
        x = AbsoluteSize.X - (v18 * 1.5 - 10),
        y = AbsoluteSize.Y - (v17 and v18 + 20 or v18 * 1.75),
        w = v18,
        h = v18
    };
    local Melee = TouchCombatLayout.rectangles(AbsoluteSize.X, AbsoluteSize.Y, v19).Melee;
    local MeleeButton = HUD:FindFirstChild("MeleeButton");
    local v20 = not HUD.IgnoreGuiInset and GuiService:GetGuiInset() or Vector2.zero;
    local v21 = HUD.AbsolutePosition.Y + Melee.y - v20.Y;

    if MeleeButton and (MeleeButton.Visible and MeleeButton.AbsoluteSize.Y > 0) then
        v21 = MeleeButton.AbsolutePosition.Y;
    end;

    local math_max_ret = math.max(10, v18 * 0.75 * 0.16);
    local v22 = v21 - math_max_ret;
    local v23 = (AbsoluteSize.X - 16) / 226;
    local v24 = math.max(1, v22 - 12 - (v11 - 1) * math_max_ret) / (v11 * 88);
    local math_min_ret = math.min(v18 * 0.75 / 88 * 0.85, v23, v24);
    local math_min_ret2 = math.min(AbsoluteSize.X - 8, v19.x + v19.w);
    local v25 = v22 - v11 * 88 * math_min_ret - (v11 - 1) * math_max_ret;

    for i, v in v8 do
        v.scale.Scale = math_min_ret;
        v.button.AnchorPoint = Vector2.new(1, 0);
        local AbsolutePosition = v.button.Parent.AbsolutePosition;
        v.button.Position = UDim2.fromOffset(math_min_ret2 - AbsolutePosition.X, v25 + (i - 1) * (math_min_ret * 88 + math_max_ret) - AbsolutePosition.Y);
    end;

    u1.touchStack = {
        top = v25,
        right = math_min_ret2,
        gap = math_max_ret,
        factor = math_min_ret,
        bottom = v22,
        left = math_min_ret2 - math_min_ret * 226
    };
end;

function u1.rowTop() -- Line: 93
    -- upvalues: UserInputService (copy), u2 (copy), GuiService (copy)
    if UserInputService.TouchEnabled then
        return nil;
    end;

    local v26 = nil;

    for i in u2 do
        if i.Parent and (i.Visible and i.AbsoluteSize.Y > 0) then
            local v27 = i:FindFirstAncestorWhichIsA("ScreenGui");

            if v27 and v27.Enabled then
                local v28 = i.AbsolutePosition.Y + (v27.IgnoreGuiInset and 0 or GuiService:GetGuiInset().Y);

                if not v26 or v28 < v26 then
                    v26 = v28;
                end;
            end;
        end;
    end;

    return v26;
end;

return u1;