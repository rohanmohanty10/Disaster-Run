  

 

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local u2 = {};

function u1.new(p3) -- Line: 10
    -- upvalues: u1 (copy), u2 (copy)
    local v4 = p3 or {};
    local v5 = setmetatable({}, u1);
    local v6 = v4.Parent or nil;
    v5.Frame = v6:FindFirstChild("Tooltip") or script.Tooltip:Clone();
    v5.TitleText = v5.Frame.TitleText;
    v5.TooltipText = v5.Frame.TooltipText;
    v5.Connection = nil;
    local v7 = v4.Text or "...";
    v5.TitleText.Text = v4.Title or "TITLE";
    v5.TooltipText.Text = v7;
    v5.Frame.Parent = v6;

    if v6 then
        u2[v6] = v5;
    end;

    return v5;
end;

function u1.ComputePosition(p8) -- Line: 36
    -- upvalues: GuiService (copy), UserInputService (copy)
    GuiService:GetGuiInset();

    return UserInputService:GetMouseLocation();
end;

function u1.GetFromParent(p9) -- Line: 43
    -- upvalues: u2 (copy)
    if u2[p9] then
        return u2[p9];
    end;
end;

function u1.Connect(u10) -- Line: 49
    -- upvalues: RunService (copy)
    if u10.Connection then
        return;
    end;

    u10.Connection = RunService.Heartbeat:Connect(function() -- Line: 52
        -- upvalues: u10 (copy)
        if not u10.Frame.Visible then
            return;
        end;

        u10:Update();
    end);
end;

function u1.Show(p11) -- Line: 61
    p11:MoveToPosition();
    p11.Frame.Visible = true;
end;

function u1.Hide(p12) -- Line: 66
    p12.Frame.Visible = false;
end;

function u1.Disconnect(p13) -- Line: 70
    if not (p13.Connection and p13.Connection.Connected) then
        return;
    end;

    p13.Connection:Disconnect();
    p13.Connection = nil;
end;

function u1.IsInScreenSpace(p14) -- Line: 76
    local ViewportSize = workspace.CurrentCamera.ViewportSize;
    local v15 = p14:ComputePosition();
    local v16 = Vector2.new(v15.X + p14.Frame.AbsoluteSize.X, v15.Y + p14.Frame.AbsoluteSize.Y);

    return v16.X < ViewportSize.X, v16.Y < ViewportSize.Y;
end;

function u1.MoveToPosition(p17) -- Line: 84
    local v18 = p17:ComputePosition();
    local v19, v20 = p17:IsInScreenSpace();
    local AbsoluteSize = p17.Frame.AbsoluteSize;
    local v21;

    if v19 then
        v21 = v18.X + 10;
    else
        v21 = v18.X - AbsoluteSize.X + 10;
    end;

    local v22;

    if v20 then
        v22 = v18.Y + 10;
    else
        v22 = v18.Y - AbsoluteSize.Y + 10;
    end;

    p17.Frame.Position = UDim2.new(0, v21, 0, v22);
end;

function u1.Update(p23) -- Line: 92
    local v24 = p23:ComputePosition();
    local v25, v26 = p23:IsInScreenSpace();
    local AbsoluteSize = p23.Frame.AbsoluteSize;
    local v27;

    if v25 then
        v27 = v24.X + 10;
    else
        v27 = v24.X - AbsoluteSize.X + 10;
    end;

    local v28;

    if v26 then
        v28 = v24.Y + 10;
    else
        v28 = v24.Y - AbsoluteSize.Y + 10;
    end;

    p23.Frame.Position = p23.Frame.Position:Lerp(UDim2.new(0, v27, 0, v28), 0.65);
end;

function u1.SetTitle(p29, p30) -- Line: 100
    p29.TitleText.Text = p30;
end;

function u1.SetText(p31, p32) -- Line: 104
    p31.TooltipText.Text = p32;
end;

return u1;