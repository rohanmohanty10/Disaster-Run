 

 

if game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled == false then
    print("mobile");
    local l__Players__1 = game:GetService("Players");
    local l__UserInputService__2 = game:GetService("UserInputService");
    local l__GameSettings__3 = UserSettings().GameSettings;
    local u1 = {};
    while not l__Players__1.LocalPlayer do
        wait();
    end;
    local l__LocalPlayer__4 = l__Players__1.LocalPlayer;
    local u2 = l__LocalPlayer__4:GetMouse();
    l__LocalPlayer__4:WaitForChild("PlayerGui");
    local u3 = nil;
    local u4 = true;
    local u5 = false;
    local u6 = false;
    u1.OnShiftLockToggled = Instance.new("BindableEvent");
    local u7;
    if l__UserInputService__2.TouchEnabled then
        u7 = true;
    else
        u7 = l__LocalPlayer__4.DevEnableMouseLock;
        if u7 then
            if l__GameSettings__3.ControlMode == Enum.ControlMode.MouseLockSwitch and (l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and l__GameSettings__3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
                u7 = l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable;
            else
                u7 = false;
            end;
        end;
    end;
    function u1.IsShiftLocked(_) --[[ Line: 37 ]]
        -- upvalues: u7 (ref), u4 (ref)
        local v8 = u7;
        if v8 then
            v8 = u4;
        end;
        return v8;
    end;
    function u1.SetIsInFirstPerson(_, p9) --[[ Line: 40 ]]
        -- upvalues: u6 (ref)
        u6 = p9;
    end;
    local function u12(p10, p11) --[[ Line: 61 ]]
        if p11 then
        else
            if p10.UserInputType == Enum.UserInputType.Keyboard and p10.KeyCode ~= Enum.KeyCode.LeftShift then
                local _ = p10.KeyCode == Enum.KeyCode.RightShift;
            end;
        end;
    end;
    l__GameSettings__3.Changed:connect(function(p13) --[[ Line: 83 ]]
        -- upvalues: l__GameSettings__3 (copy), u7 (ref), l__LocalPlayer__4 (copy), u4 (ref), u1 (copy), u5 (ref), u3 (ref), l__UserInputService__2 (copy), u12 (copy), u2 (copy)
        if p13 == "ControlMode" then
            if l__GameSettings__3.ControlMode ~= Enum.ControlMode.MouseLockSwitch then
                u7 = false;
                u2.Icon = "";
                if u3 then
                    u3:disconnect();
                    u3 = nil;
                end;
                u5 = false;
                u1.OnShiftLockToggled:Fire();
                return;
            end;
            local l__DevEnableMouseLock__5 = l__LocalPlayer__4.DevEnableMouseLock;
            if l__DevEnableMouseLock__5 then
                if l__GameSettings__3.ControlMode == Enum.ControlMode.MouseLockSwitch and (l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and l__GameSettings__3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
                    l__DevEnableMouseLock__5 = l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable;
                else
                    l__DevEnableMouseLock__5 = false;
                end;
            end;
            u7 = l__DevEnableMouseLock__5;
            if u7 then
                if u4 then
                    u1.OnShiftLockToggled:Fire();
                end;
                if not u5 then
                    u3 = l__UserInputService__2.InputBegan:connect(u12);
                    u5 = true;
                end;
            end;
        elseif p13 == "ComputerMovementMode" then
            if l__GameSettings__3.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
                u7 = false;
                u2.Icon = "";
                if u3 then
                    u3:disconnect();
                    u3 = nil;
                end;
                u5 = false;
                u1.OnShiftLockToggled:Fire();
                return;
            end;
            local l__DevEnableMouseLock__6 = l__LocalPlayer__4.DevEnableMouseLock;
            if l__DevEnableMouseLock__6 then
                if l__GameSettings__3.ControlMode == Enum.ControlMode.MouseLockSwitch and (l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and l__GameSettings__3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
                    l__DevEnableMouseLock__6 = l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable;
                else
                    l__DevEnableMouseLock__6 = false;
                end;
            end;
            u7 = l__DevEnableMouseLock__6;
            if u7 then
                if u4 then
                    u1.OnShiftLockToggled:Fire();
                end;
                if not u5 then
                    u3 = l__UserInputService__2.InputBegan:connect(u12);
                    u5 = true;
                end;
            end;
        end;
    end);
    l__LocalPlayer__4.Changed:connect(function(p14) --[[ Line: 98 ]]
        -- upvalues: l__LocalPlayer__4 (copy), u7 (ref), l__GameSettings__3 (copy), u4 (ref), u1 (copy), u5 (ref), u3 (ref), l__UserInputService__2 (copy), u12 (copy), u2 (copy)
        if p14 == "DevEnableMouseLock" then
            if not l__LocalPlayer__4.DevEnableMouseLock then
                u7 = false;
                u2.Icon = "";
                if u3 then
                    u3:disconnect();
                    u3 = nil;
                end;
                u5 = false;
                u1.OnShiftLockToggled:Fire();
                return;
            end;
            local l__DevEnableMouseLock__7 = l__LocalPlayer__4.DevEnableMouseLock;
            if l__DevEnableMouseLock__7 then
                if l__GameSettings__3.ControlMode == Enum.ControlMode.MouseLockSwitch and (l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and l__GameSettings__3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
                    l__DevEnableMouseLock__7 = l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable;
                else
                    l__DevEnableMouseLock__7 = false;
                end;
            end;
            u7 = l__DevEnableMouseLock__7;
            if u7 then
                if u4 then
                    u1.OnShiftLockToggled:Fire();
                end;
                if not u5 then
                    u3 = l__UserInputService__2.InputBegan:connect(u12);
                    u5 = true;
                end;
            end;
        elseif p14 == "DevComputerMovementMode" then
            if l__LocalPlayer__4.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or l__LocalPlayer__4.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
                u7 = false;
                u2.Icon = "";
                if u3 then
                    u3:disconnect();
                    u3 = nil;
                end;
                u5 = false;
                u1.OnShiftLockToggled:Fire();
                return;
            end;
            local l__DevEnableMouseLock__8 = l__LocalPlayer__4.DevEnableMouseLock;
            if l__DevEnableMouseLock__8 then
                if l__GameSettings__3.ControlMode == Enum.ControlMode.MouseLockSwitch and (l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and l__GameSettings__3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
                    l__DevEnableMouseLock__8 = l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable;
                else
                    l__DevEnableMouseLock__8 = false;
                end;
            end;
            u7 = l__DevEnableMouseLock__8;
            if u7 then
                if u4 then
                    u1.OnShiftLockToggled:Fire();
                end;
                if not u5 then
                    u3 = l__UserInputService__2.InputBegan:connect(u12);
                    u5 = true;
                end;
            end;
        end;
    end);
    l__LocalPlayer__4.CharacterAdded:connect(function(_) --[[ Line: 113 ]]
        -- upvalues: l__UserInputService__2 (copy)
        if not l__UserInputService__2.TouchEnabled then
            print("enabled");
        end;
    end);
    local v15, v16;
    if not l__UserInputService__2.TouchEnabled then
        print("enabled");
        local l__DevEnableMouseLock__9 = l__LocalPlayer__4.DevEnableMouseLock;
        if l__DevEnableMouseLock__9 then
            if l__GameSettings__3.ControlMode == Enum.ControlMode.MouseLockSwitch and (l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and l__GameSettings__3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then
                l__DevEnableMouseLock__9 = l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable;
            else
                l__DevEnableMouseLock__9 = false;
            end;
        end;
        if l__DevEnableMouseLock__9 then
            v15 = l__UserInputService__2.InputBegan:connect(u12);
            v16 = true;
            u5 = v16;
        end;
    end;
    u7 = l__LocalPlayer__4.DevEnableMouseLock;
    if u7 then
        u7 = false;
        if l__GameSettings__3.ControlMode == Enum.ControlMode.MouseLockSwitch then
            u7 = false;
            if l__LocalPlayer__4.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove then
                u7 = false;
                if l__GameSettings__3.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove then
                    if l__LocalPlayer__4.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
                        u7 = false;
                    else
                        u7 = true;
                    end;
                end;
            end;
        end;
    end;
    if u7 then
        if u4 then
            u1.OnShiftLockToggled:Fire();
        end;
        if not u5 then
            v15 = l__UserInputService__2.InputBegan:connect(u12);
            v16 = true;
        end;
    end;
    return u1;
end;