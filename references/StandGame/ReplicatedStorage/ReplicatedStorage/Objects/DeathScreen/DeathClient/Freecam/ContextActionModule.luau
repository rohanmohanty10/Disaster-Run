 

 

local l__ContextActionService__1 = game:GetService("ContextActionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__ContentProvider__4 = game:GetService("ContentProvider");
local l__RunService__5 = game:GetService("RunService");
local l__GuiService__6 = game:GetService("GuiService");
local l__Players__7 = game:GetService("Players");
if l__RunService__5:IsServer() then
    error(script.Name .. " can only run on the client!");
end;
l__ContentProvider__4:PreloadAsync({ "rbxassetid://97166756", "rbxassetid://97166444" });
local v1 = l__ReplicatedStorage__2:FindFirstChild("ActionModuleReference");
if v1 then
    return require(v1.Value);
end;
local v2 = Instance.new("ObjectValue");
v2.Name = "ActionModuleReference";
v2.Value = script;
v2.Archivable = false;
v2.Parent = l__ReplicatedStorage__2;
local u3 = {};
local u4 = {};
local v5 = {
    PlayerInput = require(script:WaitForChild("PlayerInput"))
};
local u6 = {};
local function u12(p7) --[[ Line: 40 ]]
    -- upvalues: u12 (copy)
    local v8 = {};
    for v9, v11 in pairs(p7) do
        if type(v11) == "table" then
            local v11 = u12(v11);
        end;
        v8[v9] = v11;
    end;
    return v8;
end;
local function v21(u13, u14, p15) --[[ Line: 51 ]]
    local u16 = u13:FindFirstChildWhichIsA(u14);
    if u16 then
        return u16;
    end;
    local u17 = nil;
    local u18 = coroutine.running();
    u17 = u13.ChildAdded:Connect(function(p19) --[[ Line: 60 ]]
        -- upvalues: u16 (ref), u14 (copy), u17 (ref), u18 (copy)
        if not u16 and p19:IsA(u14) then
            if u17 then
                if u17.Connected then
                    u17:Disconnect();
                end;
                u17 = nil;
            end;
            u16 = p19;
            task.spawn(u18, u16);
        end;
    end);
    if p15 then
        task.delay(p15, function() --[[ Line: 74 ]]
            -- upvalues: u16 (ref), u17 (ref), u18 (copy)
            if not u16 then
                if u17 then
                    if u17.Connected then
                        u17:Disconnect();
                    end;
                    u17 = nil;
                end;
                task.spawn(u18, nil);
            end;
        end);
    else
        task.delay(5, function() --[[ Line: 86 ]]
            -- upvalues: u16 (ref), u13 (copy), u14 (copy)
            if not u16 then
                warn(string.format("Infinite yield possible waiting on %s:FindFirstChildWhichIsA(\"%s\")", u13:GetFullName(), u14));
            end;
        end);
    end;
    local v20 = coroutine.isyieldable();
    assert(v20, "assertion failed!");
    return coroutine.yield();
end;
function v5.GetAbsoluteSizeAndPositionOfJumpButton(_) --[[ Line: 105 ]]
    if not workspace.CurrentCamera then
        return 0, 0, 0, 0;
    end;
    local l__ViewportSize__8 = workspace.CurrentCamera.ViewportSize;
    local v22 = math.min(l__ViewportSize__8.X, l__ViewportSize__8.Y) <= 500;
    local v23 = v22 and 70 or 120;
    local v24 = UDim2.fromOffset(v23, v23);
    local v25 = Vector2.new(l__ViewportSize__8.X * v24.X.Scale + v24.X.Offset, l__ViewportSize__8.Y * v24.Y.Scale + v24.Y.Offset);
    local v26;
    if v22 then
        v26 = UDim2.new(1, -(v23 * 1.5 - 10), 1, -v23 - 20);
    else
        v26 = UDim2.new(1, -(v23 * 1.5 - 10), 1, -v23 * 1.75);
    end;
    local v27 = Vector2.new(l__ViewportSize__8.X * v26.X.Scale + v26.X.Offset, l__ViewportSize__8.Y * v26.Y.Scale + v26.Y.Offset);
    return v25.X, v25.Y, v27.X, v27.Y;
end;
local l__LocalPlayer__9 = l__Players__7.LocalPlayer;
if not l__LocalPlayer__9 then
    l__Players__7:GetPropertyChangedSignal("LocalPlayer"):Wait();
    l__LocalPlayer__9 = l__Players__7.LocalPlayer;
end;
local u28, u29, u30, u31 = v5:GetAbsoluteSizeAndPositionOfJumpButton();
local u32 = "UserHideControlsWhenMenuOpen";
local v33, v34 = pcall(function() --[[ Line: 124 ]]
    -- upvalues: u32 (copy)
    return UserSettings():IsUserFeatureEnabled(u32);
end);
local v35 = v33 and v34;
local v36 = v21(l__LocalPlayer__9, "PlayerGui");
local l__None__10 = Enum.UserInputType.None;
local l__PlayerInput__11 = v5.PlayerInput;
local l__TouchEnabled__12 = l__UserInputService__3.TouchEnabled;
local u37 = Instance.new("ScreenGui");
u37.Name = "ButtonScreenGui";
u37.ZIndexBehavior = Enum.ZIndexBehavior.Global;
u37.IgnoreGuiInset = true;
u37.ResetOnSpawn = false;
u37.DisplayOrder = 1;
u37.Archivable = false;
local v38;
if l__TouchEnabled__12 then
    v38 = v36;
else
    v38 = nil;
end;
u37.Parent = v38;
u37.Enabled = l__GuiService__6.TouchControlsEnabled;
l__GuiService__6:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function() --[[ Name: OnTouchControlsEnabledChanged, Line 153 ]]
    -- upvalues: u37 (copy), l__GuiService__6 (copy)
    u37.Enabled = l__GuiService__6.TouchControlsEnabled;
end);
local u39 = Instance.new("Frame");
u39.Name = "ButtonFrame";
u39.Size = UDim2.fromScale(1, 1);
u39.BackgroundTransparency = 1;
u39.BorderSizePixel = 0;
u39.ZIndex = 1;
u39.Active = false;
u39.Archivable = false;
u39.Parent = u37;
if v35 then
    u39.Visible = not l__GuiService__6.MenuIsOpen;
    l__GuiService__6.MenuOpened:Connect(function() --[[ Line: 170 ]]
        -- upvalues: u39 (copy)
        u39.Visible = false;
    end);
    l__GuiService__6.MenuClosed:Connect(function() --[[ Line: 173 ]]
        -- upvalues: u39 (copy)
        u39.Visible = true;
    end);
end;
local function v42(_) --[[ Line: 178 ]]
    -- upvalues: l__UserInputService__3 (copy), l__None__10 (ref), u4 (copy)
    local v40 = l__UserInputService__3:GetLastInputType();
    if v40 ~= l__None__10 then
        l__None__10 = v40;
        for _, v41 in pairs(u4) do
            if v41.Button then
                v41.Button.Visible = l__None__10 == Enum.UserInputType.Touch;
            end;
        end;
    end;
end;
if l__PlayerInput__11.CurrentInput then
    v42(l__PlayerInput__11.CurrentInput);
end;
l__PlayerInput__11.InputTypeChanged.Event:Connect(v42);
local function u54(p43) --[[ Line: 194 ]]
    -- upvalues: l__PlayerInput__11 (copy), u28 (copy), u29 (copy), u30 (copy), u31 (copy)
    local u44 = Instance.new("ImageButton");
    u44.Name = p43 .. "Button";
    u44.BackgroundTransparency = 1;
    u44.BorderSizePixel = 0;
    u44.AutoButtonColor = false;
    u44.Image = "rbxassetid://97166444";
    u44.AnchorPoint = Vector2.new(0.5, 1);
    u44.Active = true;
    u44.ZIndex = 2;
    u44.Visible = l__PlayerInput__11.CurrentInput == l__PlayerInput__11.InputTypes.TOUCH;
    u44.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    u44.Archivable = false;
    u44:SetAttribute("Size", UDim2.fromOffset(u28 * 0.8, u29 * 0.8));
    u44:SetAttribute("Position", UDim2.new(0.5, 0, 0, -20));
    local v45 = Instance.new("UISizeConstraint");
    v45.MinSize = Vector2.new(35, 35);
    v45.MaxSize = Vector2.new(85, 85);
    v45.Archivable = false;
    v45.Parent = u44;
    local v46 = Instance.new("UICorner");
    v46.CornerRadius = UDim.new(1, 0);
    v46.Archivable = false;
    v46.Parent = u44;
    local v47 = Instance.new("ImageLabel");
    v47.Name = "ActionIcon";
    v47.BackgroundTransparency = 1;
    v47.BorderSizePixel = 0;
    v47.Image = "";
    v47.Size = UDim2.fromScale(0.65, 0.65);
    v47.AnchorPoint = Vector2.new(0.5, 0.5);
    v47.Position = UDim2.fromScale(0.5, 0.5);
    v47.Active = false;
    v47.ZIndex = 5;
    v47.Archivable = false;
    v47.Parent = u44;
    local v48 = Instance.new("TextLabel");
    v48.Name = "ActionTitle";
    v48.FontFace = Font.fromEnum(Enum.Font.SourceSansBold);
    v48.TextColor3 = Color3.fromRGB(255, 255, 255);
    v48.BackgroundTransparency = 1;
    v48.BorderSizePixel = 0;
    v48.Text = "";
    v48.Size = UDim2.fromScale(1, 1);
    v48.TextWrapped = true;
    v48.TextScaled = true;
    v48.Active = false;
    v48.ZIndex = 6;
    v48.Archivable = false;
    v48.Parent = u44;
    local v49 = Instance.new("UIStroke");
    v49.LineJoinMode = Enum.LineJoinMode.Miter;
    v49.Archivable = false;
    v49.Parent = v48;
    local v50 = Instance.new("UITextSizeConstraint");
    v50.MinTextSize = 9;
    v50.MaxTextSize = 18;
    v50.Archivable = false;
    v50.Parent = v48;
    local function v53() --[[ Line: 260 ]]
        -- upvalues: u44 (copy), u28 (ref), u29 (ref), u30 (ref), u31 (ref)
        local v51 = u44:GetAttribute("Size");
        local v52 = u44:GetAttribute("Position");
        u44.Size = UDim2.fromOffset(u28 * v51.X.Scale + v51.X.Offset, u29 * v51.Y.Scale + v51.Y.Offset);
        u44.Position = UDim2.fromOffset(u30 + u28 * v52.X.Scale + v52.X.Offset, u31 + u29 * v52.Y.Scale + v52.Y.Offset);
    end;
    v53();
    u44:GetAttributeChangedSignal("Size"):Connect(v53);
    u44:GetAttributeChangedSignal("Position"):Connect(v53);
    return u44;
end;
local function u62(u55) --[[ Line: 281 ]]
    -- upvalues: u4 (copy), l__GuiService__6 (copy)
    local u56 = u4[u55];
    if u56 and u56.Events then
        local u57 = nil;
        local function u59(p58) --[[ Line: 286 ]]
            -- upvalues: u57 (ref), u56 (copy), u55 (copy)
            if p58 == u57 then
                u57 = nil;
                u56.Button.Image = "rbxassetid://97166444";
                u56.FunctionToBind(u55, Enum.UserInputState.End, {
                    Delta = p58.Delta,
                    KeyCode = p58.KeyCode,
                    Position = p58.Position,
                    UserInputState = Enum.UserInputState.End,
                    UserInputType = p58.UserInputType
                });
            end;
        end;
        table.insert(u56.Events, u56.Button.InputBegan:Connect(function(p60) --[[ Line: 300 ]]
            -- upvalues: u57 (ref), u56 (copy), u55 (copy)
            if not u57 and (p60.UserInputType == Enum.UserInputType.Touch and p60.UserInputState == Enum.UserInputState.Begin) then
                u57 = p60;
                u56.Button.Image = "rbxassetid://97166756";
                u56.FunctionToBind(u55, Enum.UserInputState.Begin, {
                    Delta = p60.Delta,
                    KeyCode = p60.KeyCode,
                    Position = p60.Position,
                    UserInputState = Enum.UserInputState.Begin,
                    UserInputType = p60.UserInputType
                });
            end;
        end));
        table.insert(u56.Events, u56.Button.InputChanged:Connect(function(p61) --[[ Line: 314 ]]
            -- upvalues: u57 (ref), u56 (copy), u55 (copy)
            if p61 == u57 then
                u56.FunctionToBind(u55, Enum.UserInputState.Change, {
                    Delta = p61.Delta,
                    KeyCode = p61.KeyCode,
                    Position = p61.Position,
                    UserInputState = Enum.UserInputState.Change,
                    UserInputType = p61.UserInputType
                });
            end;
        end));
        table.insert(u56.Events, l__GuiService__6.MenuOpened:Connect(function() --[[ Line: 326 ]]
            -- upvalues: u57 (ref), u59 (copy)
            if u57 then
                u59(u57);
            end;
        end));
        table.insert(u56.Events, u56.Button.MouseLeave:Connect(function() --[[ Line: 332 ]]
            -- upvalues: u56 (copy)
            u56.Button.Image = "rbxassetid://97166444";
        end));
        table.insert(u56.Events, u56.Button.InputEnded:Connect(u59));
    end;
end;
local function u66(p63) --[[ Line: 340 ]]
    -- upvalues: u4 (copy)
    local v64 = u4[p63];
    if v64 and (v64.Events and table.getn(v64.Events) > 0) then
        for _, v65 in ipairs(v64.Events) do
            if v65.Connected then
                v65:Disconnect();
            end;
        end;
        table.clear(v64.Events);
    end;
end;
local function u72(p67, p68) --[[ Line: 364 ]]
    -- upvalues: u4 (copy), u66 (copy), u3 (copy), u54 (copy), u39 (copy), u62 (copy)
    local v69 = u4[p67];
    local v70;
    if v69 then
        if v69.Events and table.getn(v69.Events) > 0 then
            u66(p67);
        end;
        if v69.Button then
            v70 = v69.Button;
            v70.Image = "rbxassetid://97166444";
            if u4[p67] then
                local v71 = u3[p67];
                if v71 then
                    v71.ShaderFrame:Destroy();
                    v71.ShadowImage:Destroy();
                    u3[p67] = nil;
                end;
            end;
        else
            v70 = u54(p67);
        end;
    else
        v70 = u54(p67);
    end;
    v70.Parent = u39;
    u4[p67] = {
        Button = v70,
        FunctionToBind = p68,
        Events = {}
    };
    u62(p67);
end;
function v5.BindAction(_, p73, p74, p75, ...) --[[ Line: 400 ]]
    -- upvalues: l__ContextActionService__1 (copy), l__TouchEnabled__12 (copy), u72 (copy), u4 (copy), u3 (copy), u66 (copy), u6 (copy)
    l__ContextActionService__1:BindAction(p73, p74, false, ...);
    local v76 = l__ContextActionService__1:GetBoundActionInfo(p73);
    if p75 then
        v76.createTouchButton = true;
        if l__TouchEnabled__12 then
            u72(p73, p74);
        end;
    else
        local v77 = l__TouchEnabled__12 and u4[p73];
        if v77 then
            local v78 = u4[p73] and u3[p73];
            if v78 then
                v78.ShaderFrame:Destroy();
                v78.ShadowImage:Destroy();
                u3[p73] = nil;
            end;
            u66(p73);
            if v77.Button and v77.Button:IsDescendantOf(game) then
                v77.Button:Destroy();
            end;
            u4[p73] = nil;
        end;
    end;
    u6[p73] = v76;
end;
function v5.BindActionAtPriority(_, p79, p80, p81, p82, ...) --[[ Line: 416 ]]
    -- upvalues: l__ContextActionService__1 (copy), l__TouchEnabled__12 (copy), u72 (copy), u4 (copy), u3 (copy), u66 (copy), u6 (copy)
    l__ContextActionService__1:BindActionAtPriority(p79, p80, false, p82, ...);
    local v83 = l__ContextActionService__1:GetBoundActionInfo(p79);
    if p81 then
        v83.createTouchButton = true;
        if l__TouchEnabled__12 then
            u72(p79, p80);
        end;
    else
        local v84 = l__TouchEnabled__12 and u4[p79];
        if v84 then
            local v85 = u4[p79] and u3[p79];
            if v85 then
                v85.ShaderFrame:Destroy();
                v85.ShadowImage:Destroy();
                u3[p79] = nil;
            end;
            u66(p79);
            if v84.Button and v84.Button:IsDescendantOf(game) then
                v84.Button:Destroy();
            end;
            u4[p79] = nil;
        end;
    end;
    u6[p79] = v83;
end;
function v5.GetAllBoundActionInfo(_) --[[ Line: 432 ]]
    -- upvalues: u6 (copy)
    return u6;
end;
function v5.GetBoundActionInfo(_, p86) --[[ Line: 436 ]]
    -- upvalues: u6 (copy)
    return u6[p86];
end;
function v5.SetDescription(_, p87, p88) --[[ Line: 440 ]]
    -- upvalues: l__ContextActionService__1 (copy), u6 (copy)
    l__ContextActionService__1:SetDescription(p87, p88);
    local v89 = u6[p87];
    if v89 then
        if p88 ~= "" then
            v89.description = p88;
            return;
        end;
        v89.description = nil;
    end;
end;
function v5.SetImage(_, p90, p91) --[[ Line: 452 ]]
    -- upvalues: u4 (copy), u6 (copy)
    local v92 = u4[p90];
    if v92 and v92.Button then
        v92.Button.ActionIcon.Image = p91;
    end;
    local v93 = u6[p90];
    if v93 then
        if p91 ~= "" then
            v93.image = p91;
            return;
        end;
        v93.image = nil;
    end;
end;
function v5.SetSize(_, p94, p95, p96) --[[ Line: 467 ]]
    -- upvalues: u4 (copy)
    local v97 = u4[p94];
    if v97 and v97.Button then
        if p96 then
            v97.Button:SetAttribute("Size", p95);
            return;
        end;
        v97.Button.Size = p95;
    end;
end;
function v5.SetPosition(_, p98, p99, p100) --[[ Line: 478 ]]
    -- upvalues: u4 (copy)
    local v101 = u4[p98];
    if v101 and v101.Button then
        if p100 then
            v101.Button:SetAttribute("Position", p99);
            return;
        end;
        v101.Button.Position = p99;
    end;
end;
function v5.SetTitle(_, p102, p103) --[[ Line: 489 ]]
    -- upvalues: u4 (copy), u6 (copy)
    local v104 = u4[p102];
    if v104 and v104.Button then
        v104.Button.ActionTitle.Text = p103;
    end;
    local v105 = u6[p102];
    if v105 then
        if p103 ~= "" then
            v105.title = p103;
            return;
        end;
        v105.title = nil;
    end;
end;
function v5.SetButtonCooldown(_, p106, p107) --[[ Line: 504 ]]
    -- upvalues: u4 (copy), u3 (copy), u66 (copy)
    if p107 and p107 > 0 then
        local v108 = u4[p106];
        if v108 and v108.Button then
            local v109 = u4[p106] and u3[p106];
            if v109 then
                v109.ShaderFrame:Destroy();
                v109.ShadowImage:Destroy();
                u3[p106] = nil;
            end;
            u66(p106);
            v108.Button.Image = "rbxassetid://97166444";
            local v110 = Instance.new("Frame");
            v110.Name = "Shader";
            v110.AnchorPoint = Vector2.yAxis;
            v110.Size = UDim2.fromScale(1, 1);
            v110.Position = UDim2.fromScale(0, 1);
            v110.BackgroundTransparency = 1;
            v110.BorderSizePixel = 0;
            v110.Active = false;
            v110.ZIndex = 3;
            v110.ClipsDescendants = true;
            v110.Archivable = false;
            v110.Parent = v108.Button;
            local v111 = Instance.new("ImageLabel");
            v111.Name = "Image";
            v111.BackgroundTransparency = 1;
            v111.BorderSizePixel = 0;
            v111.AnchorPoint = Vector2.yAxis;
            v111.Size = UDim2.fromScale(1, 1);
            v111.Position = UDim2.fromScale(0, 1);
            v111.Image = v108.Button.Image;
            v111.ImageColor3 = Color3.new(0.5, 0.5, 0.5);
            v111.ImageRectOffset = v108.Button.ImageRectOffset;
            v111.ImageRectSize = v108.Button.ImageRectSize;
            v111.Active = false;
            v111.ZIndex = 4;
            v111.Archivable = false;
            v111.Parent = v110;
            u3[p106] = {
                StartedAt = tick(),
                Length = p107,
                ShaderFrame = v110,
                ShadowImage = v111,
                Button = v108.Button
            };
        end;
    end;
end;
function v5.UnbindAction(_, p112, _) --[[ Line: 552 ]]
    -- upvalues: l__ContextActionService__1 (copy), l__TouchEnabled__12 (copy), u4 (copy), u3 (copy), u66 (copy), u6 (copy)
    l__ContextActionService__1:UnbindAction(p112);
    local v113 = l__TouchEnabled__12 and u4[p112];
    if v113 then
        local v114 = u4[p112] and u3[p112];
        if v114 then
            v114.ShaderFrame:Destroy();
            v114.ShadowImage:Destroy();
            u3[p112] = nil;
        end;
        u66(p112);
        if v113.Button and v113.Button:IsDescendantOf(game) then
            v113.Button:Destroy();
        end;
        u4[p112] = nil;
    end;
    if u6[p112] then
        u6[p112] = nil;
    end;
end;
function v5.UnbindAllActions(_) --[[ Line: 562 ]]
    -- upvalues: u12 (copy), u6 (copy), l__ContextActionService__1 (copy), l__TouchEnabled__12 (copy), u4 (copy), u3 (copy), u66 (copy)
    for v115 in pairs((u12(u6))) do
        l__ContextActionService__1:UnbindAction(v115);
        local v116 = l__TouchEnabled__12 and u4[v115];
        if v116 then
            local v117 = u4[v115] and u3[v115];
            if v117 then
                v117.ShaderFrame:Destroy();
                v117.ShadowImage:Destroy();
                u3[v115] = nil;
            end;
            u66(v115);
            if v116.Button and v116.Button:IsDescendantOf(game) then
                v116.Button:Destroy();
            end;
            u4[v115] = nil;
        end;
        u6[v115] = nil;
    end;
end;
function v5.GetButton(_, p118) --[[ Line: 572 ]]
    -- upvalues: l__TouchEnabled__12 (copy), u4 (copy), u39 (copy)
    local v119 = l__TouchEnabled__12 and u4[p118];
    if v119 then
        return v119.Button or u39:WaitForChild(p118 .. "Button");
    else
        return nil;
    end;
end;
if l__TouchEnabled__12 then
    local u120 = nil;
    local function v126(p121) --[[ Line: 584 ]]
        -- upvalues: u120 (ref)
        if p121:IsA("ScreenGui") and p121.Name == "TouchGui" then
            local l__TouchControlFrame__13 = p121:WaitForChild("TouchControlFrame", 5);
            if l__TouchControlFrame__13 and l__TouchControlFrame__13:IsA("Frame") then
                if u120 then
                    if u120.Connected then
                        u120:Disconnect();
                    end;
                    u120 = nil;
                end;
                local function v124(p122) --[[ Line: 594 ]]
                    if p122:IsA("ImageButton") and p122.Name == "JumpButton" then
                        local v123 = p122:FindFirstChildWhichIsA("UICorner") or Instance.new("UICorner");
                        v123.CornerRadius = UDim.new(1, 0);
                        v123.Archivable = false;
                        v123.Parent = p122;
                    end;
                end;
                for _, v125 in ipairs(l__TouchControlFrame__13:GetChildren()) do
                    task.spawn(v124, v125);
                end;
                u120 = l__TouchControlFrame__13.ChildAdded:Connect(v124);
            end;
        end;
    end;
    for _, v127 in ipairs(v36:GetChildren()) do
        task.spawn(v126, v127);
    end;
    v36.ChildAdded:Connect(v126);
end;
l__RunService__5.RenderStepped:Connect(function() --[[ Line: 615 ]]
    -- upvalues: u3 (copy), u4 (copy), u62 (copy)
    for v128, v129 in pairs(u3) do
        local v130 = (tick() - v129.StartedAt) / v129.Length;
        local v131 = math.min(v130, 1);
        v129.ShaderFrame.Size = UDim2.fromScale(1, 1 - v131);
        v129.ShadowImage.Size = UDim2.new(1, 0, 0, v129.Button.AbsoluteSize.Y);
        if v131 == 1 then
            local v132 = u4[v128] and u3[v128];
            if v132 then
                v132.ShaderFrame:Destroy();
                v132.ShadowImage:Destroy();
                u3[v128] = nil;
            end;
            local v133 = u4[v128];
            if v133.Events and table.getn(v133.Events) == 0 then
                u62(v128);
            end;
        end;
    end;
end);
return v5;