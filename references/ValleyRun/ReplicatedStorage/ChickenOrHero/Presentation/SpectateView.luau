 

 

local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;

return {
    new = function(u1) -- Line: 6, Name: new
        -- upvalues: Panels (copy), Skin (copy)
        local u2 = Panels.screen(u1, "ValleySpectate", 76);
        local u3 = {
            mode = "Follow",
            active = false,
            touch = false,
            gui = u2,
            open = Panels.button(u2, "Open", "◉  WATCH MATCH", 0, 0, 156, 42, Color3.fromRGB(31, 59, 72))
        };
        u3.open.AnchorPoint = Vector2.new(1, 1);
        u3.open.Position = UDim2.new(1, -18, 1, -30);
        Skin.button(u3.open, "dark");
        local u4 = Panels.make("Frame", u2, "Controls", {
            BorderSizePixel = 0,
            Visible = false,
            AnchorPoint = Vector2.new(0.5, 1),
            Position = UDim2.new(0.5, 0, 1, -16),
            Size = UDim2.fromOffset(760, 96),
            BackgroundColor3 = Panels.Ink
        });
        Panels.corner(u4, 12);
        Panels.stroke(u4, Panels.Blue, 0.35);
        u3.bar = u4;
        Skin.panel(u4, {
            transparency = 0.2
        });
        u3.scale = Panels.make("UIScale", u4, "Scale", {});
        u3.label = Panels.text(u4, "Label", "WATCHING", 18, 8, 550, 16, 11, Panels.Blue);
        u3.name = Panels.text(u4, "Subject", "", 18, 26, 410, 26, 20);
        u3.name.Font = Enum.Font.GothamBold;
        u3.role = Panels.text(u4, "Role", "", 18, 63, 180, 18, 12, Panels.Muted);
        u3.prev = Panels.button(u4, "Previous", "‹", 200, 52, 44, 36);
        u3.prev.TextSize = 26;
        Skin.button(u3.prev, "secondary");
        u3.next = Panels.button(u4, "Next", "›", 250, 52, 44, 36);
        u3.next.TextSize = 26;
        Skin.button(u3.next, "secondary");
        u3.follow = Panels.button(u4, "Follow", "FOLLOW", 310, 52, 104, 36);
        u3.free = Panels.button(u4, "Free", "FREE CAM", 422, 52, 115, 36);
        Skin.tab(u3.follow, true);
        Skin.tab(u3.free, false);
        u3.skinMode = "Follow";
        u3.exit = Panels.button(u4, "Exit", "EXIT SPECTATE  ×", 553, 20, 187, 62, Color3.fromRGB(130, 61, 62));
        u3.exit.TextSize = 16;
        Skin.button(u3.exit, "danger");
        u3.hint = Panels.text(u2, "ControlHint", "", 0, 0, 660, 25, 12, Panels.Paper);
        u3.hint.AnchorPoint = Vector2.new(0.5, 1);
        u3.hint.BackgroundColor3 = Panels.Ink;
        u3.hint.BackgroundTransparency = 0.28;
        Panels.corner(u3.hint, 5);
        u3.hint.TextXAlignment = Enum.TextXAlignment.Center;
        u3.hint.Visible = false;
        Skin.toast(u3.hint);
        u3.hintButton = Panels.button(u4, "HintToggle", "?", 507, 8, 26, 26);
        u3.hintButton.TextSize = 14;
        Skin.button(u3.hintButton, "dark");
        u3.hintVersion = 0;
        u3.hintConnection = u3.hintButton.Activated:Connect(function() -- Line: 27
            -- upvalues: u3 (copy)
            local v5 = u3;
            v5.hintVersion = v5.hintVersion + 1;
            u3.hint.Visible = not u3.hint.Visible;
        end);
        u3.note = Panels.text(u2, "Notice", "", 0, 0, 330, 36, 14, Panels.Paper);
        u3.note.AnchorPoint = Vector2.new(1, 1);
        u3.note.Position = UDim2.new(1, -18, 1, -130);
        u3.note.TextXAlignment = Enum.TextXAlignment.Right;
        local u6 = Panels.make("Frame", u2, "FlightPad", {
            BackgroundTransparency = 0.2,
            BorderSizePixel = 0,
            Active = true,
            Visible = false,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 24, 1, -152),
            Size = UDim2.fromOffset(126, 126),
            BackgroundColor3 = Panels.Ink
        });
        Panels.corner(u6, 63);
        Panels.stroke(u6, Panels.Blue, 0.15);
        u3.pad = u6;
        Skin.panel(u6);
        u3.knob = Panels.make("Frame", u6, "Knob", {
            BackgroundTransparency = 0.3,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(46, 46),
            BackgroundColor3 = Panels.Blue
        });
        Panels.corner(u3.knob, 23);
        Panels.text(u6, "Hint", "MOVE", 27, 96, 72, 20, 11, Panels.Paper).TextXAlignment = Enum.TextXAlignment.Center;
        u3.up = Panels.button(u2, "Up", "UP ↑", 0, 0, 66, 48);
        u3.up.AnchorPoint = Vector2.new(1, 1);
        u3.down = Panels.button(u2, "Down", "DOWN ↓", 0, 0, 66, 48);
        u3.down.AnchorPoint = Vector2.new(1, 1);
        u3.zoomIn = Panels.button(u2, "ZoomIn", "＋", 0, 0, 48, 44);
        u3.zoomIn.AnchorPoint = Vector2.new(1, 1);
        u3.zoomIn.TextSize = 24;
        u3.zoomOut = Panels.button(u2, "ZoomOut", "−", 0, 0, 48, 44);
        u3.zoomOut.AnchorPoint = Vector2.new(1, 1);
        u3.zoomOut.TextSize = 24;
        u3.up.Visible = false;
        u3.down.Visible = false;
        u3.zoomIn.Visible = false;
        u3.zoomOut.Visible = false;

        for _, v in {
            u3.up,
            u3.down,
            u3.zoomIn,
            u3.zoomOut
        } do
            Skin.button(v, "dark");
        end;

        function u3.layout(p7) -- Line: 40
            -- upvalues: u2 (copy), u4 (copy), u6 (copy)
            local AbsoluteSize = u2.AbsoluteSize;
            local v8 = AbsoluteSize.X < AbsoluteSize.Y;
            local v9 = v8 and 360 or 760;
            local v10 = v8 and 143 or 96;
            u4.Size = UDim2.fromOffset(v9, v10);
            p7.scale.Scale = math.min(1, AbsoluteSize.X * 0.94 / v9);
            p7.label.Size = UDim2.fromOffset(v8 and 320 or 550, 16);
            p7.name.Size = UDim2.fromOffset(v8 and 320 or 410, 26);
            p7.name.TextSize = v8 and 18 or 20;
            p7.role.Visible = not v8;
            local v11 = v8 and 50 or 52;
            p7.prev.Position = UDim2.fromOffset(v8 and 12 or 200, v11);
            p7.next.Position = UDim2.fromOffset(v8 and 62 or 250, v11);
            p7.follow.Position = UDim2.fromOffset(v8 and 113 or 310, v11);
            p7.free.Position = UDim2.fromOffset(v8 and 228 or 422, v11);
            p7.exit.Position = UDim2.fromOffset(v8 and 12 or 553, v8 and 92 or 20);
            p7.exit.Size = UDim2.fromOffset(v8 and 336 or 187, v8 and 42 or 62);
            p7.hintButton.Position = UDim2.fromOffset(v8 and 317 or 507, 8);
            p7.hint.Size = UDim2.fromOffset(math.min(AbsoluteSize.X * 0.9, 660), v8 and 34 or 25);
            p7.hint.Position = UDim2.new(0.5, 0, 1, -v10 * p7.scale.Scale - 22);
            local v12 = v10 * p7.scale.Scale + 32;
            u6.Position = UDim2.new(0, 20, 1, -v12);
            u6.Size = UDim2.fromOffset(v8 and 110 or 116, v8 and 110 or 116);
            u6.Hint.Position = UDim2.fromOffset(19, v8 and 84 or 90);
            p7.up.Position = UDim2.new(1, -20, 1, -v12 - 55);
            p7.down.Position = UDim2.new(1, -20, 1, -v12);
            p7.zoomIn.Position = UDim2.new(1, -20, 1, -v12 - 51);
            p7.zoomOut.Position = UDim2.new(1, -20, 1, -v12);
        end;

        function u3.render(u13, p14, p15, p16, p17) -- Line: 60
            -- upvalues: u1 (copy), u4 (copy), Skin (ref)
            local v18 = (u13.active ~= p14 or (u13.mode ~= p15 or u13.touch ~= p16)) and true or u13.gamepad ~= p17;
            u13.active = p14;
            u13.mode = p15;
            u13.touch = p16;
            u13.gamepad = p17;
            u13.hintButton.Visible = p14;
            local v19;

            if p16 then
                v19 = p15 == "Free" and "Left pad: fly · Swipe right: look · UP / DOWN" or "Swipe to orbit · + / − to zoom";
            elseif p17 then
                v19 = p15 == "Free" and "Left stick: fly · Right stick: look · Triggers: height" or "Right stick: orbit · Triggers: zoom · Bumpers: switch";
            else
                v19 = p15 == "Free" and "WASD: fly · Q / E: height · Right-drag: look · Shift: faster" or "Right-drag: orbit · Scroll: zoom · X: exit";
            end;

            u13.hint.Text = v19;

            if p14 and u1:GetAttribute("SpectatorHints") ~= false then
                if v18 then
                    u13.hintVersion = u13.hintVersion + 1;
                    local hintVersion = u13.hintVersion;
                    u13.hint.Visible = true;
                    task.delay(8, function() -- Line: 70
                        -- upvalues: u13 (copy), hintVersion (copy)
                        if u13.hintVersion == hintVersion and u13.hint.Parent then
                            u13.hint.Visible = false;
                        end;
                    end);
                end;
            else
                u13.hint.Visible = false;
            end;

            u4.Visible = p14;
            local v20;

            if p14 then
                if p15 == "Free" then
                    v20 = p16;
                else
                    v20 = false;
                end;
            else
                v20 = p14;
            end;

            u13.pad.Visible = v20;
            u13.up.Visible = u13.pad.Visible;
            u13.down.Visible = u13.pad.Visible;

            if p14 then
                if p15 ~= "Follow" then
                    p16 = false;
                end;
            else
                p16 = p14;
            end;

            u13.zoomIn.Visible = p16;
            u13.zoomOut.Visible = u13.zoomIn.Visible;
            u13.prev.Visible = p15 == "Follow";
            u13.next.Visible = p15 == "Follow";

            if u13.skinMode ~= p15 then
                u13.skinMode = p15;
                Skin.tab(u13.follow, p15 == "Follow");
                Skin.tab(u13.free, p15 == "Free");
            end;

            u13:layout();
        end;

        u3.connection = u2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 80
            -- upvalues: u3 (copy)
            u3:layout();
        end);
        u3:layout();

        function u3.destroy(p21) -- Line: 81
            -- upvalues: u2 (copy)
            p21.connection:Disconnect();
            p21.hintConnection:Disconnect();
            u2:Destroy();
        end;

        return u3;
    end
};