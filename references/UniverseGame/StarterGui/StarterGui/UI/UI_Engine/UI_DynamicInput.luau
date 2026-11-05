  

 

return function(u1) -- Line: 1
    local UserInputService = game:GetService("UserInputService");
    game:GetService("ContextActionService");
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local u2 = UserInputService.TouchEnabled and "Mobile" or "Keyboard";
    local u3 = {
        MouseButton1 = "Keyboard",
        MouseButton2 = "Keyboard",
        MouseButton3 = "Keyboard",
        Touch = "Mobile",
        Accelerometer = "Mobile",
        Gyro = "Mobile",
        Gamepad1 = "Controller",
        Gamepad2 = "Controller",
        Gamepad3 = "Controller",
        Gamepad4 = "Controller",
        Gamepad5 = "Controller",
        Gamepad6 = "Controller",
        Gamepad7 = "Controller",
        Gamepad8 = "Controller"
    };

    function u1.ChangeInputType(p4) -- Line: 32
        -- upvalues: u2 (ref), u1 (copy)
        u2 = p4;
        u1.InputTypeChanged:Fire(p4);
    end;

    function u1.GetInputType() -- Line: 37
        -- upvalues: u2 (ref)
        return u2;
    end;

    UserInputService.LastInputTypeChanged:Connect(function(p5) -- Line: 41, Name: InputTypeChanged
        -- upvalues: u3 (copy), u2 (ref), u1 (copy)
        if not u3[p5.Name] then
            return;
        end;

        if u3[p5.Name] == nil or u3[p5.Name] == u2 then
            return;
        end;

        u1.ChangeInputType(u3[p5.Name]);
    end);
    task.delay(0.3, function() -- Line: 48
        -- upvalues: UserInputService (copy), u3 (copy), u2 (ref), u1 (copy)
        local v6 = UserInputService:GetLastInputType();

        if not u3[v6.Name] then
            return;
        end;

        if u3[v6.Name] ~= nil then
            if u3[v6.Name] == u2 then
                return;
            end;

            u1.ChangeInputType(u3[v6.Name]);
        end;
    end);
    UserInputService.InputBegan:Connect(function(p7, p8) -- Line: 51
        -- upvalues: u1 (copy)
        if p8 then
            return;
        end;

        if p7.KeyCode.Value < 97 or p7.KeyCode.Value > 122 then
            return;
        end;

        u1.ChangeInputType("Keyboard");
    end);
    local GuiService = game:GetService("GuiService");
    u1.InputTypeChanged:Connect(function(p9) -- Line: 59
        -- upvalues: GuiService (copy), LocalPlayer (copy)
        if p9 == "Mobile" then
            game:GetService("StarterGui"):SetCore("ChatWindowPosition", UDim2.new(0, 0, 0.1, 0));
        else
            game:GetService("StarterGui"):SetCore("ChatWindowPosition", UDim2.new(0, 0, 0.65, 0));
        end;

        GuiService.AutoSelectGuiEnabled = p9 == "Controller";

        if p9 == "Keyboard" then
            GuiService.SelectedObject = nil;
        end;

        LocalPlayer:SetAttribute("InputType", p9);
    end);

    if u2 == "Mobile" then
        game:GetService("StarterGui"):SetCore("ChatWindowPosition", UDim2.new(0, 0, 0.1, 0));
    else
        game:GetService("StarterGui"):SetCore("ChatWindowPosition", UDim2.new(0, 0, 0.65, 0));
    end;

    GuiService.AutoSelectGuiEnabled = u2 == "Controller";
end;