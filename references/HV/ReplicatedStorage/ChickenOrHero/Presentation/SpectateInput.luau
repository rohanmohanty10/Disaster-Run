 

 

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local SpectateConfig = require(script.Parent.SpectateConfig);
local SpectateGeometry = require(script.Parent.SpectateGeometry);

return {
    new = function(u1, u2) -- Line: 8, Name: new
        -- upvalues: LocalPlayer (copy), GuiService (copy), UserInputService (copy), SpectateConfig (copy), SpectateGeometry (copy)
        local u3 = {
            active = false,
            mode = "Follow",
            zoom = 0,
            focused = true,
            delta = Vector2.zero,
            stick = Vector2.zero,
            holds = {},
            connections = {}
        };

        local function connect(p4, p5) -- Line: 10
            -- upvalues: u3 (copy)
            table.insert(u3.connections, p4:Connect(p5));
        end;

        local function blocked() -- Line: 11
            -- upvalues: LocalPlayer (ref), u3 (copy), GuiService (ref), UserInputService (ref)
            return (LocalPlayer:GetAttribute("CreatorPanelOpen") == true or LocalPlayer:GetAttribute("GlobalWheelOpen") == true) and true or (not u3.active or (not u3.focused or GuiService.MenuIsOpen or UserInputService:GetFocusedTextBox() ~= nil));
        end;

        local function touch(p6) -- Line: 12
            return p6.UserInputType == Enum.UserInputType.Touch;
        end;

        local function point(p7) -- Line: 13
            return Vector2.new(p7.Position.X, p7.Position.Y);
        end;

        local function updatePad(p8) -- Line: 14
            -- upvalues: u1 (copy), u3 (copy)
            local v9 = u1.pad.AbsolutePosition + u1.pad.AbsoluteSize * 0.5;
            local v10 = (Vector2.new(p8.Position.X, p8.Position.Y) - v9) / (u1.pad.AbsoluteSize.X * 0.35);

            if v10.Magnitude > 1 then
                v10 = v10.Unit;
            end;

            u3.stick = v10;
            u1.knob.Position = UDim2.new(0.5, v10.X * u1.pad.AbsoluteSize.X * 0.3, 0.5, v10.Y * u1.pad.AbsoluteSize.Y * 0.3);
        end;

        table.insert(u3.connections, u1.pad.InputBegan:Connect(function(p11) -- Line: 20
            -- upvalues: LocalPlayer (ref), u3 (copy), GuiService (ref), UserInputService (ref), updatePad (copy)
            if not (LocalPlayer:GetAttribute("CreatorPanelOpen") == true or LocalPlayer:GetAttribute("GlobalWheelOpen") == true or (not (u3.active and u3.focused) or (GuiService.MenuIsOpen or UserInputService:GetFocusedTextBox() ~= nil)) or (p11.UserInputType ~= Enum.UserInputType.Touch or u3.padTouch)) then
                u3.padTouch = p11;
                updatePad(p11);
            end;
        end));

        for _, v in {
            { u1.up, 1 },
            { u1.down, -1 }
        } do
            table.insert(u3.connections, v[1].InputBegan:Connect(function(p12) -- Line: 22
                -- upvalues: LocalPlayer (ref), u3 (copy), GuiService (ref), UserInputService (ref), v (copy)
                if not (LocalPlayer:GetAttribute("CreatorPanelOpen") == true or LocalPlayer:GetAttribute("GlobalWheelOpen") == true or (not (u3.active and u3.focused) or (GuiService.MenuIsOpen or UserInputService:GetFocusedTextBox() ~= nil)) or p12.UserInputType ~= Enum.UserInputType.Touch and p12.UserInputType ~= Enum.UserInputType.MouseButton1) then
                    u3.holds[p12] = v[2];
                end;
            end));
        end;

        table.insert(u3.connections, UserInputService.InputBegan:Connect(function(p13, p14) -- Line: 24
            -- upvalues: LocalPlayer (ref), u3 (copy), GuiService (ref), UserInputService (ref), u2 (copy)
            if (LocalPlayer:GetAttribute("CreatorPanelOpen") == true or LocalPlayer:GetAttribute("GlobalWheelOpen") == true) and true or (not (u3.active and u3.focused) or (GuiService.MenuIsOpen or UserInputService:GetFocusedTextBox() ~= nil)) then
                return;
            end;

            if not p14 and p13.KeyCode == Enum.KeyCode.X or p13.KeyCode == Enum.KeyCode.ButtonB then
                u2("Stop");

                return;
            end;

            if p14 then
                return;
            end;

            if p13.UserInputType == Enum.UserInputType.MouseButton2 then
                u3.drag = true;

                return;
            end;

            if p13.UserInputType == Enum.UserInputType.Touch then
                if not (u3.lookTouch or u3.mode ~= "Follow" and p13.Position.X <= workspace.CurrentCamera.ViewportSize.X * 0.4) then
                    u3.lookTouch = p13;
                    u3.lastTouch = Vector2.new(p13.Position.X, p13.Position.Y);
                end;
            else
                if p13.KeyCode == Enum.KeyCode.Left or p13.KeyCode == Enum.KeyCode.ButtonL1 then
                    u2("Previous");

                    return;
                end;

                if p13.KeyCode == Enum.KeyCode.Right or p13.KeyCode == Enum.KeyCode.ButtonR1 then
                    u2("Next");

                    return;
                end;

                if p13.KeyCode == Enum.KeyCode.F or p13.KeyCode == Enum.KeyCode.ButtonY then
                    u2("Toggle");
                end;
            end;
        end));
        table.insert(u3.connections, UserInputService.InputChanged:Connect(function(p15, p16) -- Line: 35
            -- upvalues: LocalPlayer (ref), u3 (copy), GuiService (ref), UserInputService (ref), updatePad (copy), SpectateConfig (ref)
            if (LocalPlayer:GetAttribute("CreatorPanelOpen") == true or LocalPlayer:GetAttribute("GlobalWheelOpen") == true) and true or (not (u3.active and u3.focused) or (GuiService.MenuIsOpen or UserInputService:GetFocusedTextBox() ~= nil)) then
                return;
            end;

            if p15 == u3.padTouch then
                updatePad(p15);

                return;
            end;

            if p15 ~= u3.lookTouch then
                if p15.UserInputType ~= Enum.UserInputType.MouseMovement or (not u3.drag or (UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt))) then
                    if p15.UserInputType == Enum.UserInputType.MouseWheel and not p16 then
                        local v17 = u3;
                        v17.zoom = v17.zoom - p15.Position.Z * 2;
                    end;

                    return;
                end;

                local v18 = u3;
                v18.delta = v18.delta + Vector2.new(p15.Delta.X, p15.Delta.Y) * SpectateConfig.MouseSensitivity;

                return;
            end;

            local Vector2_new_ret = Vector2.new(p15.Position.X, p15.Position.Y);
            local v19 = u3;
            v19.delta = v19.delta + (Vector2_new_ret - u3.lastTouch) * SpectateConfig.TouchSensitivity;
            u3.lastTouch = Vector2_new_ret;
        end));
        table.insert(u3.connections, UserInputService.InputEnded:Connect(function(p20) -- Line: 44
            -- upvalues: u3 (copy), u1 (copy)
            u3.holds[p20] = nil;

            if p20.UserInputType == Enum.UserInputType.MouseButton1 then
                table.clear(u3.holds);
            end;

            if p20.UserInputType == Enum.UserInputType.MouseButton2 then
                u3.drag = false;
            end;

            if p20 == u3.padTouch then
                u3.padTouch = nil;
                u3.stick = Vector2.zero;
                u1.knob.Position = UDim2.fromScale(0.5, 0.5);
            end;

            if p20 == u3.lookTouch then
                u3.lookTouch = nil;
                u3.lastTouch = nil;
            end;
        end));

        function u3.reset(p21) -- Line: 51
            -- upvalues: u1 (copy)
            p21.delta = Vector2.zero;
            p21.zoom = 0;
            p21.stick = Vector2.zero;
            p21.padTouch = nil;
            p21.lookTouch = nil;
            p21.drag = false;
            table.clear(p21.holds);
            u1.knob.Position = UDim2.fromScale(0.5, 0.5);
        end;

        function u3.set(p22, p23, p24) -- Line: 55
            p22.active = p23;
            p22.mode = p24;
            p22:reset();
        end;

        table.insert(u3.connections, UserInputService.WindowFocusReleased:Connect(function() -- Line: 56
            -- upvalues: u3 (copy), UserInputService (ref)
            u3.focused = false;
            u3:reset();

            if u3.active then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
                UserInputService.MouseIconEnabled = true;
            end;
        end));
        table.insert(u3.connections, UserInputService.WindowFocused:Connect(function() -- Line: 57
            -- upvalues: u3 (copy)
            u3.focused = true;
        end));

        function u3.sample(p25, p26) -- Line: 58
            -- upvalues: LocalPlayer (ref), u3 (copy), GuiService (ref), UserInputService (ref), SpectateGeometry (ref), SpectateConfig (ref)
            if (LocalPlayer:GetAttribute("CreatorPanelOpen") == true or LocalPlayer:GetAttribute("GlobalWheelOpen") == true) and true or (not (u3.active and u3.focused) or (GuiService.MenuIsOpen or UserInputService:GetFocusedTextBox() ~= nil)) then
                p25:reset();

                return Vector3.new(0, 0, 0), Vector2.zero, 0, false, false;
            end;

            local v27 = UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt);

            local function key(p28) -- Line: 62
                -- upvalues: UserInputService (ref)
                return UserInputService:IsKeyDown(p28) and 1 or 0;
            end;

            local v29, v30;

            if v27 then
                v29 = Vector3.new(0, 0, 0);
                v30 = false;
            else
                local v31 = (UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0);
                local v32 = (UserInputService:IsKeyDown(Enum.KeyCode.E) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.Q) and 1 or 0);
                local v33 = UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0;
                local v34 = UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0;
                v29 = Vector3.new(v31, v32, v33 - v34);

                if (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 1 or 0) == 1 then
                    v30 = true;
                else
                    v30 = false;
                end;
            end;

            local Vector2_zero = Vector2.zero;
            local v35 = 0;

            if UserInputService.GamepadEnabled then
                for _, v in UserInputService:GetGamepadState(Enum.UserInputType.Gamepad1) do
                    if v.KeyCode == Enum.KeyCode.Thumbstick1 then
                        local v36 = SpectateGeometry.deadzone(Vector2.new(v.Position.X, v.Position.Y));
                        v29 = v29 + Vector3.new(v36.X, 0, -v36.Y);
                    elseif v.KeyCode == Enum.KeyCode.Thumbstick2 then
                        local v37 = SpectateGeometry.deadzone(Vector2.new(v.Position.X, v.Position.Y));
                        Vector2_zero = Vector2.new(v37.X, -v37.Y) * SpectateConfig.GamepadLookSpeed * p26;
                    elseif v.KeyCode == Enum.KeyCode.ButtonR2 then
                        v35 = v35 + v.Position.Z;
                    elseif v.KeyCode == Enum.KeyCode.ButtonL2 then
                        v35 = v35 - v.Position.Z;
                    end;
                end;
            end;

            for _, v in p25.holds do
                v35 = v35 + v;
            end;

            local v38 = v29 + Vector3.new(p25.stick.X, p25.mode == "Free" and v35 and v35 or 0, p25.stick.Y);

            if v38.Magnitude > 1 then
                v38 = v38.Unit;
            end;

            local v39 = p25.delta + Vector2_zero;
            p25.delta = Vector2.zero;
            local v40 = p25.zoom + (p25.mode == "Follow" and (-v35 * 20 * p26 or 0) or 0);
            p25.zoom = 0;

            return v38, v39, v40, v30, p25.drag and not v27;
        end;

        function u3.destroy(p41) -- Line: 81
            for _, v in p41.connections do
                v:Disconnect();
            end;

            p41:reset();
        end;

        return u3;
    end
};