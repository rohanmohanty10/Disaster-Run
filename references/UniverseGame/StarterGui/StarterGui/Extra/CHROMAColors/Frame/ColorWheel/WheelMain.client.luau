  

 

local Parent = script.Parent;
local Button = Parent:WaitForChild("Button");
local H = Parent:WaitForChild("H");
local SV = Parent:WaitForChild("SV");
local u1 = Color3.new(1, 0, 0);
local u2, u3, u4 = u1:ToHSV();
local u5 = false;
local u6 = false;
local u7 = false;
Button.MouseEnter:Connect(function() -- Line: 12
    -- upvalues: u5 (ref)
    u5 = true;
end);
Button.MouseLeave:Connect(function() -- Line: 16
    -- upvalues: u5 (ref)
    u5 = false;
end);
local UserInputService = game:GetService("UserInputService");

local function corner2center(p8) -- Line: 22
    return p8 * 2 - Vector2.new(1, 1);
end;

local function center2corner(p9) -- Line: 26
    return p9 / 2 + Vector2.new(0.5, 0.5);
end;

local function redraw() -- Line: 30
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), Button (copy), H (copy), SV (copy), Parent (copy)
    u1 = Color3.fromHSV(u2, u3, u4);
    Button.ImageColor3 = Color3.fromHSV(u2, 1, 1);
    local v10 = u2 * 3.141592653589793 * 2 - 1.5707963267948966;
    local v11 = Vector2.new(math.cos(v10), (math.sin(v10))) * 0.9 / 2 + Vector2.new(0.5, 0.5);
    H.Position = UDim2.new(v11.X, 0, v11.Y, 0);
    H.Rotation = u2 * 360;
    local v12 = Vector2.new(u3 - 0.5, -u4 + 0.5) / 2 + Vector2.new(0.5, 0.5);
    SV.Position = UDim2.new(v12.X, 0, v12.Y, 0);
    Parent:SetAttribute("Color", u1);
end;

local function update(p13, p14) -- Line: 43
    -- upvalues: Button (copy), u7 (ref), u3 (ref), u4 (ref), u2 (ref), redraw (copy)
    local v15 = (p13 - Button.AbsolutePosition) / Button.AbsoluteSize * 2 - Vector2.new(1, 1);
    local Magnitude = v15.Magnitude;
    local v16;

    if p14 then
        v16 = Magnitude < 0.8;
    else
        v16 = not u7;
    end;

    if v16 then
        u7 = false;
        u3 = math.clamp(v15.X + 0.5, 0, 1);
        u4 = math.clamp(-v15.Y + 0.5, 0, 1);
    else
        local v17;

        if p14 then
            v17 = Magnitude < 1;
        else
            v17 = u7;
        end;

        if v17 then
            u7 = true;
            u2 = (math.atan2(v15.Y, v15.X) + 1.5707963267948966) / 6.283185307179586 % 1;
        end;
    end;

    redraw();
end;

UserInputService.InputBegan:Connect(function(p18) -- Line: 62
    -- upvalues: u5 (ref), u6 (ref), update (copy)
    if p18.UserInputType == Enum.UserInputType.MouseButton1 or p18.UserInputType == Enum.UserInputType.Touch and u5 then
        u6 = true;
        update(Vector2.new(p18.Position.X, p18.Position.Y), true);
    end;
end);
UserInputService.InputEnded:Connect(function(p19) -- Line: 69
    -- upvalues: u6 (ref)
    if p19.UserInputType == Enum.UserInputType.MouseButton1 or p19.UserInputType == Enum.UserInputType.Touch then
        u6 = false;
    end;
end);
UserInputService.InputChanged:Connect(function(p20) -- Line: 75
    -- upvalues: u6 (ref), update (copy)
    if (p20.UserInputType == Enum.UserInputType.MouseMovement or p20.UserInputType == Enum.UserInputType.Touch) and u6 then
        update(Vector2.new(p20.Position.X, p20.Position.Y));
    end;
end);

local function init() -- Line: 81
    -- upvalues: Parent (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), redraw (copy)
    local v21 = Parent:GetAttribute("Color");

    if v21 ~= u1 then
        local v22, v23, v24 = v21:ToHSV();
        u2 = v22;
        u3 = v23;
        u4 = v24;
        redraw();
    end;
end;

Parent:GetAttributeChangedSignal("Color"):Connect(init);
local v25 = Parent:GetAttribute("Color");

if v25 ~= u1 then
    local v26, v27, v28 = v25:ToHSV();
    u2 = v26;
    u3 = v27;
    u4 = v28;
    redraw();
end;