 

 

local ValleyPanels = require(script.Parent.ValleyPanels);
local ValleyTheme = require(script.Parent.ValleyTheme);

return {
    new = function(p1) -- Line: 4, Name: new
        -- upvalues: ValleyPanels (copy), ValleyTheme (copy)
        local v2 = {};
        local u3 = ValleyPanels.screen(p1, "CreatorStudio", 83);
        v2.gui = u3;
        local u4 = ValleyPanels.button(u3, "Open", "CREATOR", 0, 0, 150, 36);
        v2.open = u4;
        u4.AnchorPoint = Vector2.new(1, 0);
        u4.Position = UDim2.new(1, -14, 0, 132);
        ValleyTheme.button(u4, ValleyTheme.Mint);
        u4.TextSize = 11;
        local u5, u6, v7 = ValleyPanels.panel(u3, "Studio", 550, 528);
        v2.shade = u5;
        v2.panel = u6;
        v2.close = v7;
        u5.BackgroundTransparency = 1;
        ValleyTheme.surface(u6, ValleyTheme.InventoryInk, ValleyTheme.Mint, 6, 0.45);
        ValleyPanels.text(u6, "Eyebrow", "VALLEY RUN  /  CONTENT CREATOR", 24, 19, 420, 16, 10, ValleyTheme.Mint);
        ValleyPanels.text(u6, "Heading", "Creator studio", 24, 45, 450, 36, 27, ValleyTheme.Paper).Font = Enum.Font.GothamBold;
        v2.status = ValleyPanels.text(u6, "Status", "Lobby tools · your character stays here", 24, 88, 500, 26, 12, ValleyTheme.Muted);

        local function action(p8, p9, p10, p11) -- Line: 15
            -- upvalues: ValleyPanels (ref), u6 (copy), ValleyTheme (ref)
            local v12 = ValleyPanels.button(u6, p8, p9, p11, 127, 244, 68);
            v12.Text = "";
            ValleyTheme.button(v12, ValleyTheme.Mint);
            ValleyPanels.text(v12, "Label", p9, 14, 10, 216, 23, 15, ValleyTheme.Paper).Font = Enum.Font.GothamBold;
            ValleyPanels.text(v12, "Key", p10, 14, 37, 216, 18, 11, ValleyTheme.Muted);

            return v12;
        end;

        v2.camera = action("Camera", "START FREECAM", "F6  ·  toggle camera", 24);
        v2.hide = action("CleanFrame", "HIDE UI", "F8  ·  hide / restore everything", 282);
        ValleyPanels.text(u6, "SpeedTitle", "CAMERA SPEED", 24, 215, 245, 19, 10, ValleyTheme.Muted);
        ValleyPanels.text(u6, "LensTitle", "LENS / FIELD OF VIEW", 282, 215, 245, 19, 10, ValleyTheme.Muted);
        v2.speeds = {};
        v2.lenses = {};

        for i, v in { { 0.35, "SLOW" }, { 0.65, "SMOOTH" }, { 1.25, "FAST" } } do
            local v13 = ValleyPanels.button(u6, "Speed" .. i, v[2], 24 + (i - 1) * 82, 240, 77, 34);
            ValleyTheme.button(v13, ValleyTheme.Blue);
            v13.TextSize = 10;
            table.insert(v2.speeds, {
                button = v13,
                value = v[1]
            });
        end;

        for i, v in { { 40, "CLOSE" }, { 60, "NORMAL" }, { 80, "WIDE" } } do
            local v14 = ValleyPanels.button(u6, "Lens" .. i, v[2], 282 + (i - 1) * 82, 240, 77, 34);
            ValleyTheme.button(v14, ValleyTheme.Purple);
            v14.TextSize = 10;
            table.insert(v2.lenses, {
                button = v14,
                value = v[1]
            });
        end;

        ValleyPanels.make("Frame", u6, "Rule", {
            BackgroundTransparency = 0.55,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(24, 295),
            Size = UDim2.new(1, -48, 0, 1),
            BackgroundColor3 = ValleyTheme.Border
        });
        ValleyPanels.text(u6, "Movement", "WASD move   ·   Q / E height   ·   Right-drag look", 24, 312, 502, 20, 12, ValleyTheme.Paper);
        ValleyPanels.text(u6, "Recovery", "Shift flies faster. F6 or X exits. F4 hides or shows staff tools.", 24, 340, 502, 33, 11, ValleyTheme.Muted);
        v2.commands = ValleyPanels.button(u6, "Commands", "TROLLS & SERVER COMMANDS  →", 24, 433, 502, 40);
        ValleyTheme.button(v2.commands, ValleyTheme.Purple);
        ValleyPanels.text(u6, "CommandHint", "Try ;bighead me · ;rainbow me · ;confetti me. Effects expire automatically.", 24, 480, 502, 28, 11, ValleyTheme.Muted);
        ValleyPanels.text(u6, "AFK", "Turn AFK on to stay out of matches while recording.", 24, 395, 502, 22, 11, ValleyTheme.Gold);
        local u15 = ValleyPanels.screen(p1, "CreatorRestore", 1000);
        u15:SetAttribute("CreatorCaptureExempt", true);
        v2.recovery = u15;
        v2.restore = ValleyPanels.button(u15, "Restore", "SHOW UI", 0, 0, 112, 36);
        v2.restore.AnchorPoint = Vector2.new(0.5, 1);
        v2.restore.Position = UDim2.new(0.5, 0, 1, -16);
        ValleyTheme.button(v2.restore, ValleyTheme.Mint);
        u15.Enabled = false;

        function v2.render(p16, p17, p18, p19, p20, p21, p22, p23, p24) -- Line: 45
            -- upvalues: u4 (copy), u5 (copy), u15 (copy)
            local v25;

            if p18 then
                v25 = not p17 and not p21;
            else
                v25 = p18;
            end;

            u4.Visible = v25;
            u5.Visible = p17 and p18;
            u4.Text = p20 and "CAMERA" or "CREATOR";
            p16.status.Text = p19 and (p20 and "LIVE CAMERA · character safely in the lobby" or "Lobby tools · your character stays here") or "Camera tools need the lobby · commands are available.";
            p16.camera.Label.Text = p20 and "EXIT FREECAM" or "START FREECAM";
            p16.camera.Interactable = p19 or p20;
            p16.camera.Label.TextTransparency = (p19 or p20) and 0 or 0.5;
            p16.hide.Interactable = p19;
            p16.hide.Label.Text = p21 and "RESTORE UI" or "HIDE UI";

            for _, v in p16.speeds do
                v.button.BackgroundTransparency = math.abs(p22 - v.value) < 0.01 and 0 or 0.5;
            end;

            for _, v in p16.lenses do
                v.button.BackgroundTransparency = p23 == v.value and 0 or 0.5;
            end;

            u15.Enabled = p21 and p24;
        end;

        function v2.destroy(p26) -- Line: 56
            -- upvalues: u3 (copy), u15 (copy)
            u3:Destroy();
            u15:Destroy();
        end;

        return v2;
    end
};