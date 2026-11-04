 

 

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u17 = {
    rectangles = function(p1, p2, p3) -- Line: 8, Name: rectangles
        local v4 = math.min(p3.w, p3.h) * 0.75;
        local v5 = v4 * 1.3;
        local math_max_ret = math.max(6, v5 * 0.08);
        local v6 = p3.x + p3.w;
        local v7 = p3.x + (p3.w - v5) / 2;
        local v8 = p3.y + (p3.h - v5) / 2;
        local v9 = v7 - math_max_ret - v5;
        local v10 = v8 - math_max_ret - v5;
        local v11 = v4 * 226 / 88;
        local v12 = v10 - math_max_ret - v4;
        local v13, v14;

        if v11 * 2 + math_max_ret <= v6 - 8 then
            v13 = {
                x = v6 - v11,
                y = v12,
                w = v11,
                h = v4
            };
            v14 = {
                x = v6 - v11 * 2 - math_max_ret,
                y = v12,
                w = v11,
                h = v4
            };
        else
            local math_min_ret = math.min(v11, p1 - 16);
            local v15 = math_min_ret * 88 / 226;
            local v16 = v10 - math_max_ret - v15;
            v13 = {
                x = math.max(8, v6 - math_min_ret),
                y = v16,
                w = math_min_ret,
                h = v15
            };
            v14 = {
                x = v13.x,
                y = v16 - math_max_ret - v15,
                w = math_min_ret,
                h = v15
            };
        end;

        return {
            Catch = {
                x = v7,
                y = v8,
                w = v5,
                h = v5
            },
            Melee = {
                x = v9,
                y = v10,
                w = v5,
                h = v5
            },
            Dive = {
                x = v9,
                y = v8,
                w = v5,
                h = v5
            },
            Ability = v13,
            Item = v14
        };
    end
};

function u17.place(p18, p19, p20) -- Line: 41
    -- upvalues: UserInputService (copy), LocalPlayer (copy), u17 (copy), GuiService (copy)
    p19:SetAttribute("UIProportionalExclude", true);
    p19:SetAttribute("UIProportionalGroup", nil);

    for _, descendant in p19:GetDescendants() do
        if descendant:IsA("UIScale") and descendant.Name == "ProportionalScale" then
            descendant:Destroy();
        end;
    end;

    if not UserInputService.TouchEnabled then
        return false;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return false;
    end;

    local HUD = LocalPlayer.PlayerGui:FindFirstChild("HUD");
    local v21 = HUD and HUD.AbsoluteSize or workspace_CurrentCamera.ViewportSize;
    local v22 = math.min(v21.X, v21.Y) <= 500;
    local v23 = v22 and 70 or 120;
    local v24 = u17.rectangles(v21.X, v21.Y, {
        x = v21.X - (v23 * 1.5 - 10),
        y = v21.Y - (v22 and v23 + 20 or v23 * 1.75),
        w = v23,
        h = v23
    })[p18];
    local v25 = p19:FindFirstAncestorWhichIsA("ScreenGui");
    local v26 = v25 and not v25.IgnoreGuiInset and GuiService:GetGuiInset() or Vector2.zero;
    p19.AnchorPoint = Vector2.zero;
    p19.Position = UDim2.fromOffset(v24.x - v26.X, v24.y - v26.Y);

    if p20 then
        p20.Scale = v24.w / 226;
    else
        p19.Size = UDim2.fromOffset(v24.w, v24.h);
    end;

    return true;
end;

return u17;