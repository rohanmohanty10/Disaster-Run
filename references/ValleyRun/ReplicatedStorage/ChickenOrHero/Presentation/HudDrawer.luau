 

 

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local TweenService = game:GetService("TweenService");

return {
    new = function(u1, u2, u3) -- Line: 7, Name: new
        -- upvalues: GuiService (copy), UserInputService (copy), TweenService (copy)
        u3.ensureDrawer(u1);
        local u4 = {
            opened = false,
            available = false,
            pinned = false,
            version = 0,
            connections = {}
        };
        local MenuToggle = u1.MenuToggle;
        local Panel = u1.DrawerClip.Panel;
        local DrawerReveal = u1.DrawerReveal;
        local u5 = nil;

        local function connect(p6, p7) -- Line: 14
            -- upvalues: u4 (copy)
            table.insert(u4.connections, p6:Connect(p7));
        end;

        local function contains(p8, p9) -- Line: 15
            local AbsolutePosition = p8.AbsolutePosition;
            local AbsoluteSize = p8.AbsoluteSize;
            local v10;

            if p9.X >= AbsolutePosition.X and (p9.X <= AbsolutePosition.X + AbsoluteSize.X and p9.Y >= AbsolutePosition.Y) then
                v10 = p9.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
            else
                v10 = false;
            end;

            return v10;
        end;

        local function mouseInside() -- Line: 19
            -- upvalues: GuiService (ref), UserInputService (ref), MenuToggle (copy), Panel (copy)
            local GuiInset = GuiService:GetGuiInset();
            local v11 = UserInputService:GetMouseLocation() - GuiInset;
            local v12 = MenuToggle;
            local AbsolutePosition = v12.AbsolutePosition;
            local AbsoluteSize = v12.AbsoluteSize;
            local v13;

            if v11.X >= AbsolutePosition.X and (v11.X <= AbsolutePosition.X + AbsoluteSize.X and v11.Y >= AbsolutePosition.Y) then
                v13 = v11.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
            else
                v13 = false;
            end;

            if not v13 then
                v13 = Panel.Visible;

                if v13 then
                    local v14 = Panel;
                    local AbsolutePosition2 = v14.AbsolutePosition;
                    local AbsoluteSize2 = v14.AbsoluteSize;

                    if v11.X >= AbsolutePosition2.X and (v11.X <= AbsolutePosition2.X + AbsoluteSize2.X and v11.Y >= AbsolutePosition2.Y) then
                        v13 = v11.Y <= AbsolutePosition2.Y + AbsoluteSize2.Y;
                    else
                        v13 = false;
                    end;
                end;
            end;

            return v13;
        end;

        function u4.setOpen(u15, p16, p17, p18) -- Line: 24
            -- upvalues: u5 (ref), MenuToggle (copy), UserInputService (ref), Panel (copy), DrawerReveal (copy), TweenService (ref), u1 (copy), GuiService (ref), u2 (copy)
            if p16 then
                p16 = u15.available;
            end;

            local v19;

            if p16 then
                v19 = p17 == true;
            else
                v19 = p16;
            end;

            u15.pinned = v19;
            u15.version = u15.version + 1;
            local version = u15.version;
            u15.opened = p16;

            if u5 then
                u5:Cancel();
                u5 = nil;
            end;

            MenuToggle.Arrow.Text = p16 and "‹" or "›";
            local v20;

            if p16 then
                v20 = UserInputService.PreferredInput ~= Enum.PreferredInput.Touch;
            else
                v20 = p16;
            end;

            MenuToggle.Modal = v20;

            if p16 then
                Panel.Visible = true;
            end;

            if p18 then
                DrawerReveal.Value = p16 and 1 or 0;
                Panel.Visible = p16;
            else
                u5 = TweenService:Create(DrawerReveal, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Value = p16 and 1 or 0
                });
                u5:Play();

                if not p16 then
                    task.delay(0.2, function() -- Line: 41
                        -- upvalues: u15 (copy), version (copy), Panel (ref)
                        if u15.version == version then
                            Panel.Visible = false;
                        end;
                    end);
                end;
            end;

            u1:SetAttribute("DrawerOpen", p16);

            if not p16 then
                u1.Notice.Visible = false;
            end;

            if not p16 and (GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(Panel)) then
                GuiService.SelectedObject = u15.available and MenuToggle or nil;
            end;

            u2.Changed:Fire("Drawer");
        end;

        function u4.setAvailable(p21, p22) -- Line: 50
            -- upvalues: MenuToggle (copy), u1 (copy)
            local v23 = p22 == true;

            if p21.available == v23 then
                return;
            end;

            p21.available = v23;
            MenuToggle.Visible = v23;
            u1.DrawerClip.Visible = v23;

            if not v23 then
                p21:setOpen(false, false, true);
            end;
        end;

        function u4.isOpen(p24) -- Line: 56
            return p24.opened;
        end;

        local function leave() -- Line: 57
            -- upvalues: u4 (copy), GuiService (ref), UserInputService (ref), MenuToggle (copy), Panel (copy)
            local version = u4.version;
            task.delay(0.28, function() -- Line: 59
                -- upvalues: u4 (ref), version (copy), GuiService (ref), UserInputService (ref), MenuToggle (ref), Panel (ref)
                if u4.opened and (not u4.pinned and u4.version == version) then
                    local GuiInset = GuiService:GetGuiInset();
                    local v25 = UserInputService:GetMouseLocation() - GuiInset;
                    local v26 = MenuToggle;
                    local AbsolutePosition = v26.AbsolutePosition;
                    local AbsoluteSize = v26.AbsoluteSize;
                    local v27;

                    if v25.X >= AbsolutePosition.X and (v25.X <= AbsolutePosition.X + AbsoluteSize.X and v25.Y >= AbsolutePosition.Y) then
                        v27 = v25.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
                    else
                        v27 = false;
                    end;

                    if not v27 then
                        v27 = Panel.Visible;

                        if v27 then
                            local v28 = Panel;
                            local AbsolutePosition2 = v28.AbsolutePosition;
                            local AbsoluteSize2 = v28.AbsoluteSize;

                            if v25.X >= AbsolutePosition2.X and (v25.X <= AbsolutePosition2.X + AbsoluteSize2.X and v25.Y >= AbsolutePosition2.Y) then
                                v27 = v25.Y <= AbsolutePosition2.Y + AbsoluteSize2.Y;
                            else
                                v27 = false;
                            end;
                        end;
                    end;

                    if not v27 then
                        u4:setOpen(false);
                    end;
                end;
            end);
        end;

        table.insert(u4.connections, DrawerReveal.Changed:Connect(function() -- Line: 63
            -- upvalues: u3 (copy), u1 (copy)
            u3.positionDrawer(u1);
        end));
        table.insert(u4.connections, MenuToggle.MouseEnter:Connect(function() -- Line: 64
            -- upvalues: u4 (copy), UserInputService (ref), GuiService (ref)
            if u4.available and not (u4.opened or (UserInputService.PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse or (UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default or (GuiService.MenuIsOpen or UserInputService:GetFocusedTextBox())))) then
                u4:setOpen(true, false);
            end;
        end));
        table.insert(u4.connections, MenuToggle.MouseLeave:Connect(leave));
        table.insert(u4.connections, Panel.MouseLeave:Connect(leave));
        table.insert(u4.connections, MenuToggle.Activated:Connect(function() -- Line: 71
            -- upvalues: u4 (copy), UserInputService (ref), u3 (copy), u2 (copy), GuiService (ref), Panel (copy)
            if u4.opened and u4.pinned then
                u4:setOpen(false);

                return;
            end;

            u4:setOpen(true, true);

            if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
                for _, v in u3.Order do
                    if u2.available[v] then
                        GuiService.SelectedObject = Panel.Navigation[v];

                        return;
                    end;
                end;
            end;
        end));
        table.insert(u4.connections, u2.Opening.Event:Connect(function() -- Line: 80
            -- upvalues: u4 (copy)
            u4:setOpen(false, false, true);
        end));
        table.insert(u4.connections, UserInputService.InputBegan:Connect(function(p29, p30) -- Line: 81
            -- upvalues: u4 (copy), UserInputService (ref)
            if not u4.opened or UserInputService:GetFocusedTextBox() then
                return;
            end;

            if p29.KeyCode == Enum.KeyCode.Escape or p29.KeyCode == Enum.KeyCode.ButtonB then
                u4:setOpen(false);

                return;
            end;

            if not (p30 or p29.KeyCode ~= Enum.KeyCode.W and (p29.KeyCode ~= Enum.KeyCode.A and (p29.KeyCode ~= Enum.KeyCode.S and (p29.KeyCode ~= Enum.KeyCode.D and p29.KeyCode ~= Enum.KeyCode.Space)))) then
                u4:setOpen(false);
            end;
        end));
        table.insert(u4.connections, UserInputService.WindowFocusReleased:Connect(function() -- Line: 86
            -- upvalues: u4 (copy)
            u4:setOpen(false, false, true);
        end));
        local PropertyChangedSignal = UserInputService:GetPropertyChangedSignal("PreferredInput");
        table.insert(u4.connections, PropertyChangedSignal:Connect(function() -- Line: 87
            -- upvalues: u4 (copy)
            if u4.opened then
                u4:setOpen(false, false, true);
            end;
        end));

        function u4.destroy(p31) -- Line: 90
            p31:setOpen(false, false, true);

            for _, v in p31.connections do
                v:Disconnect();
            end;
        end;

        MenuToggle.Visible = false;
        u1.DrawerClip.Visible = false;
        Panel.Visible = false;
        DrawerReveal.Value = 0;

        return u4;
    end
};