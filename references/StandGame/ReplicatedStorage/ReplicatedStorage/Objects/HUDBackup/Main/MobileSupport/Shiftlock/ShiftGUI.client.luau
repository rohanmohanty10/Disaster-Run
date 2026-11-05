 

 

if game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled == false then
    print("mobile");
    local l__Players__1 = game:GetService("Players");
    local l__RunService__2 = game:GetService("RunService");
    local l__ContextActionService__3 = game:GetService("ContextActionService");
    local l__LocalPlayer__4 = l__Players__1.LocalPlayer;
    local v1 = l__LocalPlayer__4.Character or l__LocalPlayer__4.CharacterAdded:Wait();
    local l__HumanoidRootPart__5 = v1:WaitForChild("HumanoidRootPart");
    local l__Humanoid__6 = v1:WaitForChild("Humanoid");
    local l__CurrentCamera__7 = workspace.CurrentCamera;
    local l__Parent__8 = script.Parent;
    uis = game:GetService("UserInputService");
    ismobile = uis.TouchEnabled;
    l__Parent__8.Visible = ismobile;
    local u2 = {
        OFF = "rbxasset://textures/ui/mouseLock_off@2x.png",
        ON = "rbxasset://textures/ui/mouseLock_on@2x.png"
    };
    local u3 = false;
    local u4 = CFrame.new(1.7, 0, 0);
    local u5 = CFrame.new(-1.7, 0, 0);
    local function u6() --[[ Line: 49 ]]
        -- upvalues: l__Humanoid__6 (copy), l__Parent__8 (copy), u2 (copy), l__CurrentCamera__7 (copy), u5 (copy), u3 (ref)
        l__Humanoid__6.AutoRotate = true;
        l__Parent__8.Image = u2.OFF;
        if l__CurrentCamera__7.CameraSubject == l__Humanoid__6 then
            l__CurrentCamera__7.CFrame = l__CurrentCamera__7.CFrame * u5;
        end;
        pcall(function() --[[ Line: 55 ]]
            -- upvalues: u3 (ref)
            u3:Disconnect();
            u3 = nil;
        end);
        l__Parent__8.Parent.ShiftlockIndicator.Visible = false;
    end;
    l__Parent__8.Image = u2.OFF;
    u3 = false;
    function ShiftLock()
        -- upvalues: u3 (ref), l__RunService__2 (copy), l__Humanoid__6 (copy), l__Parent__8 (copy), u2 (copy), l__HumanoidRootPart__5 (copy), l__CurrentCamera__7 (copy), u4 (copy), u6 (copy)
        if u3 then
            u6();
        else
            u3 = l__RunService__2.RenderStepped:Connect(function() --[[ Line: 65 ]]
                -- upvalues: l__Humanoid__6 (ref), l__Parent__8 (ref), u2 (ref), l__HumanoidRootPart__5 (ref), l__CurrentCamera__7 (ref), u4 (ref)
                l__Humanoid__6.AutoRotate = false;
                l__Parent__8.Image = u2.ON;
                local v7 = l__CurrentCamera__7;
                l__HumanoidRootPart__5.CFrame = CFrame.new(l__HumanoidRootPart__5.Position, (Vector3.new(v7.CFrame.LookVector.X * 900000, l__HumanoidRootPart__5.Position.Y, v7.CFrame.LookVector.Z * 900000)));
                if l__CurrentCamera__7.CameraSubject == l__Humanoid__6 then
                    l__CurrentCamera__7.CFrame = l__CurrentCamera__7.CFrame * u4;
                end;
                l__Parent__8.Parent.ShiftlockIndicator.Visible = true;
            end);
        end;
    end;
    l__ContextActionService__3:BindAction("ShiftLOCK", ShiftLock, false, "On");
    l__ContextActionService__3:SetPosition("ShiftLOCK", UDim2.new(0.8, 0, 0.8, 0));
    l__Parent__8.MouseButton1Click:Connect(function() --[[ Line: 74 ]]
        -- upvalues: u3 (ref), l__RunService__2 (copy), l__Humanoid__6 (copy), l__Parent__8 (copy), u2 (copy), l__HumanoidRootPart__5 (copy), l__CurrentCamera__7 (copy), u4 (copy), u6 (copy)
        if u3 then
            u6();
        else
            u3 = l__RunService__2.RenderStepped:Connect(function() --[[ Line: 76 ]]
                -- upvalues: l__Humanoid__6 (ref), l__Parent__8 (ref), u2 (ref), l__HumanoidRootPart__5 (ref), l__CurrentCamera__7 (ref), u4 (ref)
                l__Humanoid__6.AutoRotate = false;
                l__Parent__8.Image = u2.ON;
                local v8 = l__CurrentCamera__7;
                l__HumanoidRootPart__5.CFrame = CFrame.new(l__HumanoidRootPart__5.Position, (Vector3.new(v8.CFrame.LookVector.X * 900000, l__HumanoidRootPart__5.Position.Y, v8.CFrame.LookVector.Z * 900000)));
                if l__CurrentCamera__7.CameraSubject == l__Humanoid__6 then
                    l__CurrentCamera__7.CFrame = l__CurrentCamera__7.CFrame * u4;
                end;
                l__Parent__8.Parent.ShiftlockIndicator.Visible = true;
            end);
        end;
    end);
    return {};
end;