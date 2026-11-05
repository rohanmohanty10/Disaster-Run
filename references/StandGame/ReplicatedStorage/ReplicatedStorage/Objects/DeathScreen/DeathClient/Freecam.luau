 

 

local v1 = {};
local _ = Enum.ContextActionPriority.Low.Value;
local l__Value__1 = Enum.ContextActionPriority.High.Value;
local _ = {
    { Enum.KeyCode.LeftShift, Enum.KeyCode.O },
    { Enum.KeyCode.ButtonL1, Enum.KeyCode.DPadRight }
};
local u2 = Vector2.new(0.75, 1) * 8;
local l__UserGameSettings__2 = UserSettings():GetService("UserGameSettings");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__RunService__4 = game:GetService("RunService");
game:GetService("StarterGui");
local l__Workspace__5 = game:GetService("Workspace");
local l__Players__6 = game:GetService("Players");
local function u11(u3, u4, p5) --[[ Line: 30 ]]
    local u6 = u3:FindFirstChildWhichIsA(u4);
    if u6 then
        return u6;
    end;
    local u7 = nil;
    local u8 = coroutine.running();
    u7 = u3.ChildAdded:Connect(function(p9) --[[ Line: 39 ]]
        -- upvalues: u6 (ref), u4 (copy), u7 (ref), u8 (copy)
        if not u6 and p9:IsA(u4) then
            if u7 then
                if u7.Connected then
                    u7:Disconnect();
                end;
                u7 = nil;
            end;
            u6 = p9;
            task.spawn(u8, u6);
        end;
    end);
    if p5 then
        task.delay(p5, function() --[[ Line: 53 ]]
            -- upvalues: u6 (ref), u7 (ref), u8 (copy)
            if not u6 then
                if u7 then
                    if u7.Connected then
                        u7:Disconnect();
                    end;
                    u7 = nil;
                end;
                task.spawn(u8, nil);
            end;
        end);
    else
        task.delay(5, function() --[[ Line: 65 ]]
            -- upvalues: u6 (ref), u3 (copy), u4 (copy)
            if not u6 then
                warn(string.format("Infinite yield possible waiting on %s:FindFirstChildWhichIsA(\"%s\")", u3:GetFullName(), u4));
            end;
        end);
    end;
    local v10 = coroutine.isyieldable();
    assert(v10, "assertion failed!");
    return coroutine.yield();
end;
local l__LocalPlayer__7 = l__Players__6.LocalPlayer;
if not l__LocalPlayer__7 then
    l__Players__6:GetPropertyChangedSignal("LocalPlayer"):Wait();
    l__LocalPlayer__7 = l__Players__6.LocalPlayer;
end;
local l__CurrentCamera__8 = l__Workspace__5.CurrentCamera;
l__Workspace__5:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 91 ]]
    -- upvalues: l__Workspace__5 (copy), l__CurrentCamera__8 (ref)
    local l__CurrentCamera__9 = l__Workspace__5.CurrentCamera;
    if l__CurrentCamera__9 then
        l__CurrentCamera__8 = l__CurrentCamera__9;
    end;
end);
local u12 = "UserExitFreecamBreaksWithShiftlock";
local v13, v14 = pcall(function() --[[ Line: 78 ]]
    -- upvalues: u12 (copy)
    return UserSettings():IsUserFeatureEnabled(u12);
end);
local u15 = v13 and v14;
local v16 = u11(l__LocalPlayer__7, "PlayerScripts");
local u17 = u11(l__LocalPlayer__7, "PlayerGui");
local l__ContextActionModule__10 = require(script:WaitForChild("ContextActionModule"));
local l__PlayerModule__11 = require(v16:WaitForChild("PlayerModule"));
local l__PlayerInput__12 = l__ContextActionModule__10.PlayerInput;
local u18 = l__PlayerModule__11:GetControls();
local u19 = {};
u19.__index = u19;
function u19.new(p20, p21) --[[ Line: 112 ]]
    -- upvalues: u19 (copy)
    local v22 = setmetatable({}, u19);
    v22.F = p20;
    v22.P = p21;
    v22.V = p21 * 0;
    return v22;
end;
function u19.Update(p23, p24, p25) --[[ Line: 120 ]]
    local v26 = p23.F * 2 * 3.141592653589793;
    local l__P__13 = p23.P;
    local l__V__14 = p23.V;
    local v27 = p25 - l__P__13;
    local v28 = math.exp(-v26 * p24);
    local v29 = p25 + (l__V__14 * p24 - v27 * (v26 * p24 + 1)) * v28;
    local v30 = (v26 * p24 * (v27 * v26 - l__V__14) + l__V__14) * v28;
    p23.P = v29;
    p23.V = v30;
    return v29;
end;
function u19.Reset(p31, p32) --[[ Line: 137 ]]
    p31.Position = p32;
    p31.Velocity = p32 * 0;
end;
local u33 = Vector3.new(0, 0, 0);
local l__zero__15 = Vector2.zero;
local u34 = 0;
local u35 = u19.new(1.5, Vector3.new(0, 0, 0));
local u36 = u19.new(1, Vector2.zero);
local u37 = u19.new(4, 0);
local u38 = {};
local function u43(p39) --[[ Line: 154 ]]
    local v40 = math.sign(p39);
    local v41 = (math.abs(p39) - 0.15) / 0.85 * 2;
    local v42 = (math.exp(v41) - 1) / 6.38905609893065;
    return v40 * math.clamp(v42, 0, 1);
end;
local function u47(p44) --[[ Line: 181 ]]
    -- upvalues: u18 (copy)
    local l__touchGui__16 = u18.touchGui;
    if l__touchGui__16 and l__touchGui__16.Enabled then
        local l__touchControlFrame__17 = u18.touchControlFrame;
        local v45 = l__touchControlFrame__17 and l__touchControlFrame__17:FindFirstChild("DynamicThumbstickFrame");
        if v45 then
            local l__AbsolutePosition__18 = v45.AbsolutePosition;
            local v46 = l__AbsolutePosition__18 + v45.AbsoluteSize;
            if p44.X >= l__AbsolutePosition__18.X and (p44.Y >= l__AbsolutePosition__18.Y and (p44.X <= v46.X and p44.Y <= v46.Y)) then
                return true;
            end;
        end;
    end;
    return false;
end;
local u48 = {
    ButtonX = 0,
    ButtonY = 0,
    DPadDown = 0,
    DPadUp = 0,
    ButtonL2 = 0,
    ButtonR2 = 0,
    Thumbstick1 = Vector2.zero,
    Thumbstick2 = Vector2.zero
};
local u49 = {
    W = 0,
    A = 0,
    S = 0,
    D = 0,
    E = 0,
    Q = 0,
    U = 0,
    H = 0,
    J = 0,
    K = 0,
    I = 0,
    Y = 0,
    Up = 0,
    Down = 0,
    LeftShift = 0,
    RightShift = 0
};
local u50 = {
    MouseWheel = 0,
    Delta = Vector2.zero
};
local u51 = {
    Pinch = 0,
    Move = Vector2.zero
};
local u52 = Vector2.one * 0.04908738521234052;
local u53 = Vector2.one * 0.19634954084936207;
local u54 = Vector2.one * 0.39269908169872414;
local u55 = {};
local u56 = nil;
local u57 = nil;
local u58 = {};
local u59 = false;
local u60 = 1;
function u38.Vel(p61) --[[ Line: 263 ]]
    -- upvalues: u18 (copy), u60 (ref), u49 (copy), u43 (copy), u48 (copy), l__PlayerInput__12 (copy), u59 (ref)
    local v62 = u18:GetMoveVector();
    u60 = math.clamp(u60 + p61 * (u49.Up - u49.Down) * 0.75, 0.01, 4);
    local v63 = u43(u48.Thumbstick1.X);
    local v64 = u43(u48.ButtonR2) - u43(u48.ButtonL2);
    local v65 = u43(-u48.Thumbstick1.Y);
    local v66 = Vector3.new(v63, v64, v65) * Vector3.new(1, 1, 1);
    local v67 = Vector3.new(u49.D - u49.A + u49.K - u49.H, u49.E - u49.Q + u49.I - u49.Y, u49.S - u49.W + u49.J - u49.U) * Vector3.new(1, 1, 1);
    local v68;
    if l__PlayerInput__12.CurrentInput == l__PlayerInput__12.InputTypes.TOUCH then
        local v69 = u43(v62.X);
        local v70 = u43(v62.Y);
        local v71 = u43(v62.Z);
        v68 = Vector3.new(v69, v70, v71) * Vector3.new(1, 1, 1);
    else
        v68 = v66 + v67;
    end;
    return v68 * (u60 * (u59 and 0.25 or 1));
end;
function u38.Pan(_) --[[ Line: 295 ]]
    -- upvalues: u43 (copy), u48 (copy), u54 (copy), u50 (copy), u52 (copy), u51 (copy), u53 (copy)
    local v72 = Vector2.new(u43(u48.Thumbstick2.Y), (u43(-u48.Thumbstick2.X))) * u54;
    local v73 = u50.Delta * u52;
    local v74 = u51.Move * u53;
    u50.Delta = Vector2.zero;
    u51.Move = Vector2.zero;
    return v72 + v73 + v74;
end;
function u38.Fov(_) --[[ Line: 307 ]]
    -- upvalues: u48 (copy), u50 (copy), u51 (copy)
    local v75 = (u48.ButtonX - u48.ButtonY) * 0.25;
    local v76 = u50.MouseWheel * 1;
    local v77 = u51.Pinch * 0.04;
    u50.MouseWheel = 0;
    u51.Pinch = 0;
    return v75 + v76 + v77;
end;
local function u80(_, p78, p79) --[[ Line: 316 ]]
    -- upvalues: u49 (copy)
    u49[p79.KeyCode.Name] = p78 == Enum.UserInputState.Begin and 1 or 0;
    return Enum.ContextActionResult.Sink;
end;
local function u83(_, p81, p82) --[[ Line: 321 ]]
    -- upvalues: u48 (copy)
    u48[p82.KeyCode.Name] = p81 == Enum.UserInputState.Begin and 1 or 0;
    return Enum.ContextActionResult.Sink;
end;
local function u85(_, _, p84) --[[ Line: 326 ]]
    -- upvalues: u50 (copy)
    local l__Delta__19 = p84.Delta;
    u50.Delta = Vector2.new(-l__Delta__19.Y, -l__Delta__19.X);
    return Enum.ContextActionResult.Sink;
end;
local function u87(_, _, p86) --[[ Line: 332 ]]
    -- upvalues: u48 (copy)
    u48[p86.KeyCode.Name] = p86.Position;
    return Enum.ContextActionResult.Sink;
end;
local function u89(_, _, p88) --[[ Line: 337 ]]
    -- upvalues: u48 (copy)
    u48[p88.KeyCode.Name] = p88.Position.Z;
    return Enum.ContextActionResult.Sink;
end;
local function u91(_, _, p90) --[[ Line: 342 ]]
    -- upvalues: u50 (copy)
    u50[p90.UserInputType.Name] = -p90.Position.Z;
    return Enum.ContextActionResult.Sink;
end;
function u38.StartCapture() --[[ Line: 353 ]]
    -- upvalues: l__ContextActionModule__10 (copy), u80 (copy), l__Value__1 (copy), u85 (copy), u91 (copy), u83 (copy), u89 (copy), u87 (copy), u58 (copy), l__UserInputService__3 (copy), u50 (copy), u56 (ref), u47 (copy), u55 (ref), u51 (copy), l__Workspace__5 (copy), l__CurrentCamera__8 (ref), u57 (ref), u59 (ref)
    l__ContextActionModule__10:BindActionAtPriority("FreecamKeyboard", u80, false, l__Value__1, Enum.KeyCode.W, Enum.KeyCode.U, Enum.KeyCode.A, Enum.KeyCode.H, Enum.KeyCode.S, Enum.KeyCode.J, Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I, Enum.KeyCode.Q, Enum.KeyCode.Y, Enum.KeyCode.Up, Enum.KeyCode.Down);
    l__ContextActionModule__10:BindActionAtPriority("FreecamMousePan", u85, false, l__Value__1, Enum.UserInputType.MouseMovement);
    l__ContextActionModule__10:BindActionAtPriority("FreecamMouseWheel", u91, false, l__Value__1, Enum.UserInputType.MouseWheel);
    l__ContextActionModule__10:BindActionAtPriority("FreecamGamepadButton", u83, false, l__Value__1, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY);
    l__ContextActionModule__10:BindActionAtPriority("FreecamGamepadTrigger", u89, false, l__Value__1, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2);
    l__ContextActionModule__10:BindActionAtPriority("FreecamGamepadThumbstick", u87, false, l__Value__1, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2);
    table.insert(u58, l__UserInputService__3.PointerAction:Connect(function(p92, p93, p94, p95) --[[ Line: 368 ]]
        -- upvalues: u50 (ref)
        if not p95 then
            u50.Delta = Vector2.new(-p93.Y, -p93.X);
            u50.MouseWheel = -p92 + -p94;
        end;
    end));
    table.insert(u58, l__UserInputService__3.InputBegan:Connect(function(p96, p97) --[[ Line: 374 ]]
        -- upvalues: u56 (ref), u47 (ref), u55 (ref), l__UserInputService__3 (ref)
        if p96.UserInputType == Enum.UserInputType.Touch then
            if u56 or (not u47(p96.Position) or p97) then
                u55[p96] = p97;
            else
                u56 = p96;
            end;
        else
            if p96.UserInputType == Enum.UserInputType.MouseButton2 then
                l__UserInputService__3.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition;
            end;
        end;
    end));
    table.insert(u58, l__UserInputService__3.InputChanged:Connect(function(p98, p99) --[[ Line: 385 ]]
        -- upvalues: u56 (ref), u55 (ref), u51 (ref), l__Workspace__5 (ref), l__CurrentCamera__8 (ref), u57 (ref)
        if p98.UserInputType == Enum.UserInputType.Touch and (p98.UserInputState == Enum.UserInputState.Change and p98 ~= u56) then
            if type(u55[p98]) ~= "boolean" then
                u55[p98] = p99;
            end;
            local v100 = {};
            for v101, v102 in pairs(u55) do
                if not v102 then
                    table.insert(v100, v101);
                end;
            end;
            if #v100 == 1 and u55[p98] == false then
                local l__Delta__20 = p98.Delta;
                local v103 = u51;
                local l__Move__21 = v103.Move;
                local v104 = Vector2.new(-l__Delta__20.Y, -l__Delta__20.X);
                if l__Workspace__5.CurrentCamera == l__CurrentCamera__8 then
                    local v105 = l__CurrentCamera__8.CFrame:ToEulerAnglesYXZ();
                    if v104.Y * v105 < 0 then
                        local _ = (1 - (math.abs(v105) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;
                    end;
                end;
                v103.Move = l__Move__21 + v104;
            end;
            if #v100 == 2 then
                local l__Magnitude__22 = (v100[1].Position - v100[2].Position).Magnitude;
                if u57 then
                    local v106 = u51;
                    v106.Pinch = v106.Pinch + -(l__Magnitude__22 - u57);
                end;
                u57 = l__Magnitude__22;
                return;
            end;
            u57 = nil;
        end;
    end));
    table.insert(u58, l__UserInputService__3.InputEnded:Connect(function(p107, _) --[[ Line: 418 ]]
        -- upvalues: u56 (ref), u55 (ref), u57 (ref), l__UserInputService__3 (ref)
        if p107.UserInputType == Enum.UserInputType.Touch then
            if p107 == u56 then
                u56 = nil;
            end;
            if u55[p107] == false then
                u57 = nil;
            end;
            u55[p107] = nil;
        else
            if p107.UserInputType == Enum.UserInputType.MouseButton2 then
                l__UserInputService__3.MouseBehavior = Enum.MouseBehavior.Default;
            end;
        end;
    end));
    l__ContextActionModule__10:BindActionAtPriority("FreecamShiftSpeed", function(_, p108, _) --[[ Line: 433 ]]
        -- upvalues: u59 (ref)
        if p108 == Enum.UserInputState.Begin then
            u59 = true;
        else
            if p108 == Enum.UserInputState.End or p108 == Enum.UserInputState.Cancel then
                u59 = false;
            end;
        end;
    end, false, l__Value__1, Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonR1);
end;
function u38.StopCapture() --[[ Line: 442 ]]
    -- upvalues: u60 (ref), u48 (copy), u49 (copy), u50 (copy), l__ContextActionModule__10 (copy), u55 (ref), u56 (ref), u57 (ref), u58 (copy)
    u60 = 1;
    local v109 = u48;
    for v110, v111 in pairs(v109) do
        v109[v110] = v111 * 0;
    end;
    local v112 = u49;
    for v113, v114 in pairs(v112) do
        v112[v113] = v114 * 0;
    end;
    local v115 = u50;
    for v116, v117 in pairs(v115) do
        v115[v116] = v117 * 0;
    end;
    l__ContextActionModule__10:UnbindAction("FreecamKeyboard");
    l__ContextActionModule__10:UnbindAction("FreecamMousePan");
    l__ContextActionModule__10:UnbindAction("FreecamMouseWheel");
    l__ContextActionModule__10:UnbindAction("FreecamGamepadButton");
    l__ContextActionModule__10:UnbindAction("FreecamGamepadTrigger");
    l__ContextActionModule__10:UnbindAction("FreecamGamepadThumbstick");
    l__ContextActionModule__10:UnbindAction("FreecamShiftSpeed");
    u55 = {};
    u56 = nil;
    u57 = nil;
    for _, v118 in ipairs(u58) do
        if v118.Connected then
            v118:Disconnect();
        end;
    end;
    table.clear(u58);
end;
local function u129(p119) --[[ Line: 466 ]]
    -- upvalues: l__CurrentCamera__8 (ref), u34 (ref)
    local l__ViewportSize__23 = l__CurrentCamera__8.ViewportSize;
    local v120 = math.tan(u34 / 2) * 2;
    local v121 = l__ViewportSize__23.X / l__ViewportSize__23.Y * v120;
    local l__RightVector__24 = p119.RightVector;
    local l__UpVector__25 = p119.UpVector;
    local l__LookVector__26 = p119.LookVector;
    local v122 = 512;
    local v123 = Vector3.new(0, 0, 0);
    for v124 = 0, 1, 0.5 do
        for v125 = 0, 1, 0.5 do
            local v126 = l__RightVector__24 * ((v124 - 0.5) * v121) - l__UpVector__25 * ((v125 - 0.5) * v120) + l__LookVector__26;
            local v127 = p119.Position + v126 * 0.1;
            local v128 = workspace:Raycast(v127, v126.Unit * v122);
            if v128 then
                local l__Magnitude__27 = (v128.Position - v127).Magnitude;
                if l__Magnitude__27 < v122 then
                    v123 = v126.Unit;
                    v122 = l__Magnitude__27;
                end;
            end;
        end;
    end;
    return l__LookVector__26:Dot(v123) * v122;
end;
local u130 = nil;
local function u139(p131) --[[ Line: 499 ]]
    -- upvalues: u35 (copy), u38 (copy), u36 (copy), u37 (copy), u34 (ref), l__zero__15 (ref), u2 (copy), u130 (ref), u33 (ref), l__CurrentCamera__8 (ref), u129 (copy)
    local v132 = u35:Update(p131, u38.Vel(p131));
    local v133 = u36:Update(p131, u38.Pan(p131));
    local v134 = u37:Update(p131, u38.Fov(p131));
    local v135 = math.rad(u34 / 2);
    local v136 = 0.7002075382097097 / math.tan(v135);
    local v137 = math.sqrt(v136);
    u34 = math.clamp(u34 + v134 * 300 * (p131 / v137), 1, 120);
    l__zero__15 = l__zero__15 + v133 * u2 * (p131 / v137);
    l__zero__15 = Vector2.new(math.clamp(l__zero__15.X, -1.5707963267948966, 1.5707963267948966), l__zero__15.Y % 6.283185307179586);
    local v138 = CFrame.new(u130 or u33) * CFrame.fromOrientation(l__zero__15.X, l__zero__15.Y, 0) * CFrame.new(v132 * Vector3.new(64, 64, 64) * p131);
    u33 = v138.Position;
    l__CurrentCamera__8.CFrame = v138;
    l__CurrentCamera__8.Focus = v138 * CFrame.new(0, 0, -u129(v138));
    l__CurrentCamera__8.FieldOfView = u34;
    if u130 then
        u130 = nil;
    end;
end;
function v1.ForceUpdateCamera(p140) --[[ Line: 522 ]]
    -- upvalues: u130 (ref)
    u130 = p140.Position;
end;
local u141 = {};
local u142 = nil;
local u143 = nil;
local u144 = nil;
local u145 = nil;
local u146 = nil;
local u147 = nil;
local u148 = nil;
local u149 = {};
local u150 = {};
local u151 = {};
local u152 = nil;
local u153 = false;
local u154 = false;
local u155 = false;
local function u161(p156) --[[ Line: 564 ]]
    -- upvalues: u11 (copy), u153 (ref), u152 (ref), u154 (ref), u149 (copy), u147 (ref)
    local u157 = u11(p156, "Humanoid");
    local function v158() --[[ Line: 566 ]]
        -- upvalues: u153 (ref), u152 (ref), u157 (copy), u154 (ref)
        if not u153 then
            u153 = true;
            u152 = u157.WalkSpeed;
            if u154 then
                u157.WalkSpeed = 0;
            end;
            u153 = false;
        end;
    end;
    if not u153 then
        u153 = true;
        u152 = u157.WalkSpeed;
        if u154 then
            u157.WalkSpeed = 0;
        end;
        u153 = false;
    end;
    local v159 = u149;
    local v160 = u157:GetPropertyChangedSignal("WalkSpeed");
    table.insert(v159, v160:Connect(v158));
    u147 = u157;
end;
local function u163(_) --[[ Line: 581 ]]
    -- upvalues: u149 (copy), u147 (ref), u152 (ref)
    for _, v162 in ipairs(u149) do
        if v162.Connected then
            v162:Disconnect();
        end;
    end;
    table.clear(u149);
    if u147 then
        u147.WalkSpeed = u152;
        u147 = nil;
    end;
end;
function u141.Push() --[[ Line: 595 ]]
    -- upvalues: u154 (ref), u17 (copy), u18 (copy), u151 (copy), u146 (ref), l__CurrentCamera__8 (ref), u15 (copy), l__LocalPlayer__7 (ref), l__UserGameSettings__2 (copy), u142 (ref), l__UserInputService__3 (copy), u155 (ref), u143 (ref), u145 (ref), u144 (ref), u148 (ref), u161 (copy), u150 (copy), u163 (copy)
    if u154 then
        return;
    end;
    u154 = true;
    for _, v164 in ipairs(u17:GetChildren()) do
        if v164:IsA("ScreenGui") and (v164.Enabled and (v164 ~= u18.touchGui and (v164.Name ~= "ButtonScreenGui" and (v164.Name ~= "Spectate" and v164.Name ~= "Chat")))) then
            table.insert(u151, v164);
            v164.Enabled = false;
        end;
    end;
    u146 = l__CurrentCamera__8.FieldOfView;
    l__CurrentCamera__8.FieldOfView = 70;
    if u15 then
        local l__DevEnableMouseLock__28 = l__LocalPlayer__7.DevEnableMouseLock;
        local v165 = l__LocalPlayer__7.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable;
        local v166 = l__DevEnableMouseLock__28 and (l__UserGameSettings__2.ControlMode == Enum.ControlMode.MouseLockSwitch and l__UserGameSettings__2.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove);
        if v166 then
            v166 = not v165;
        end;
        if v166 then
            u142 = Enum.MouseBehavior.Default;
            l__UserInputService__3.MouseBehavior = Enum.MouseBehavior.Default;
            if u18.touchControlFrame then
                u155 = u18.touchControlFrame.Visible;
                u18.touchControlFrame.Visible = false;
            end;
            u143 = l__CurrentCamera__8.CameraType;
            l__CurrentCamera__8.CameraType = Enum.CameraType.Scriptable;
            u145 = l__CurrentCamera__8.CFrame;
            u144 = l__CurrentCamera__8.Focus;
            if l__LocalPlayer__7.Character then
                u148 = task.spawn(u161, l__LocalPlayer__7.Character);
            end;
            table.insert(u150, l__LocalPlayer__7.CharacterAdded:Connect(u161));
            table.insert(u150, l__LocalPlayer__7.CharacterRemoving:Connect(u163));
            return;
        end;
    end;
    u142 = l__UserInputService__3.MouseBehavior;
    l__UserInputService__3.MouseBehavior = Enum.MouseBehavior.Default;
    if u18.touchControlFrame then
        u155 = u18.touchControlFrame.Visible;
        u18.touchControlFrame.Visible = false;
    end;
    u143 = l__CurrentCamera__8.CameraType;
    l__CurrentCamera__8.CameraType = Enum.CameraType.Scriptable;
    u145 = l__CurrentCamera__8.CFrame;
    u144 = l__CurrentCamera__8.Focus;
    if l__LocalPlayer__7.Character then
        u148 = task.spawn(u161, l__LocalPlayer__7.Character);
    end;
    table.insert(u150, l__LocalPlayer__7.CharacterAdded:Connect(u161));
    table.insert(u150, l__LocalPlayer__7.CharacterRemoving:Connect(u163));
end;
function u141.Pop() --[[ Line: 636 ]]
    -- upvalues: u154 (ref), u148 (ref), u151 (copy), u150 (copy), l__LocalPlayer__7 (ref), u163 (copy), u18 (copy), u155 (ref), l__CurrentCamera__8 (ref), u146 (ref), u143 (ref), u145 (ref), u144 (ref), l__UserInputService__3 (copy), u142 (ref)
    if u154 then
        u154 = false;
        if u148 and coroutine.status(u148) == "running" then
            coroutine.close(u148);
        end;
        for _, v167 in ipairs(u151) do
            if v167:IsDescendantOf(game) then
                v167.Enabled = true;
            end;
        end;
        table.clear(u151);
        for _, v168 in ipairs(u150) do
            if v168.Connected then
                v168:Disconnect();
            end;
        end;
        table.clear(u150);
        if l__LocalPlayer__7.Character then
            u163(l__LocalPlayer__7.Character);
        end;
        if u18.touchControlFrame then
            u18.touchControlFrame.Visible = u155;
        end;
        l__CurrentCamera__8.FieldOfView = u146;
        u146 = nil;
        l__CurrentCamera__8.CameraType = u143;
        u143 = nil;
        l__CurrentCamera__8.CFrame = u145;
        u145 = nil;
        l__CurrentCamera__8.Focus = u144;
        u144 = nil;
        l__UserInputService__3.MouseBehavior = u142;
        u142 = nil;
    end;
end;
l__Players__6.PlayerRemoving:Connect(function(p169) --[[ Line: 684 ]]
    -- upvalues: l__LocalPlayer__7 (ref), u150 (copy), u163 (copy)
    if p169 == l__LocalPlayer__7 then
        for _, v170 in ipairs(u150) do
            if v170.Connected then
                v170:Disconnect();
            end;
        end;
        table.clear(u150);
        if l__LocalPlayer__7.Character then
            u163(l__LocalPlayer__7.Character);
        end;
    end;
end);
local function u171() --[[ Line: 700 ]]
    -- upvalues: l__CurrentCamera__8 (ref), l__zero__15 (ref), u33 (ref), u34 (ref), u35 (copy), u36 (copy), u37 (copy), u141 (copy), l__RunService__4 (copy), u139 (copy), u38 (copy)
    local l__CFrame__29 = l__CurrentCamera__8.CFrame;
    l__zero__15 = Vector2.new(l__CFrame__29:ToEulerAnglesYXZ());
    u33 = l__CFrame__29.Position;
    u34 = l__CurrentCamera__8.FieldOfView;
    u35:Reset(Vector3.new(0, 0, 0));
    u36:Reset(Vector2.zero);
    u37:Reset(0);
    u141.Push();
    l__RunService__4:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value + 1, u139);
    u38.StartCapture();
end;
local u172 = false;
local function v173() --[[ Line: 723 ]]
    -- upvalues: u172 (ref), u38 (copy), l__RunService__4 (copy), u141 (copy), u171 (copy)
    if u172 then
        u38.StopCapture();
        l__RunService__4:UnbindFromRenderStep("Freecam");
        u141.Pop();
    else
        u171();
    end;
    u172 = not u172;
end;
while l__CurrentCamera__8.CameraType ~= Enum.CameraType.Custom do
    l__CurrentCamera__8:GetPropertyChangedSignal("CameraType"):Wait();
end;
v1.ToggleFreecam = v173;
return v1;