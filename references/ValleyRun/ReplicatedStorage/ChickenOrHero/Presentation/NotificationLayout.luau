 

 

return {
    apply = function(u1) -- Line: 4, Name: apply
        local NotificationsF = u1.MainFrame.NotificationsF;
        NotificationsF:SetAttribute("UIProportionalGroup", nil);

        for _, v in { "Proportions", "SizeLimits" } do
            local v2 = NotificationsF:FindFirstChild(v);

            if v2 then
                v2:Destroy();
            end;
        end;

        local function label(p3, p4, p5, p6) -- Line: 13
            p3.BackgroundTransparency = 1;
            p3.BorderSizePixel = 0;
            p3.TextScaled = true;
            p3.TextWrapped = true;
            p3.Font = p4;
            p3.TextStrokeColor3 = Color3.new(0, 0, 0);
            p3.TextStrokeTransparency = 0.65;
            p3.TextXAlignment = Enum.TextXAlignment.Center;
            p3.TextYAlignment = Enum.TextYAlignment.Center;
            p3.TextSize = p6;
            p3.TextTruncate = Enum.TextTruncate.None;

            for _, child in p3:GetChildren() do
                if child:IsA("UITextSizeConstraint") then
                    child:Destroy();
                end;
            end;
        end;

        local Frame = NotificationsF.Frame;
        Frame.AnchorPoint = Vector2.zero;
        Frame.Position = UDim2.fromScale(0, 0);
        Frame.Size = UDim2.fromScale(1, 1);
        Frame.BackgroundTransparency = 1;
        label(Frame.Location, Enum.Font.GothamBold, 9, 12);
        label(Frame.WhatsHappening, Enum.Font.GothamBold, 12, 23);
        label(Frame.Hint, Enum.Font.GothamMedium, 9, 12);
        Frame.Location.AnchorPoint = Vector2.zero;
        Frame.Location.Position = UDim2.fromScale(0, 0);
        Frame.Location.Size = UDim2.fromScale(1, 0.18);
        Frame.WhatsHappening.AnchorPoint = Vector2.zero;
        Frame.WhatsHappening.Position = UDim2.fromScale(0.025, 0.23);
        Frame.WhatsHappening.Size = UDim2.fromScale(0.95, 0.52);
        Frame.Hint.AnchorPoint = Vector2.zero;
        Frame.Hint.Position = UDim2.fromScale(0, 0.81);
        Frame.Hint.Size = UDim2.fromScale(1, 0.18);
        Frame.Hint.TextTransparency = 0.15;
        local EscapeStreak = NotificationsF.EscapeStreak;
        EscapeStreak.Position = UDim2.new(0.5, 0, 1, 7);
        EscapeStreak.AnchorPoint = Vector2.new(0.5, 0);
        label(EscapeStreak.Caption, Enum.Font.GothamBold, 9, 10);
        label(EscapeStreak.Count, Enum.Font.GothamBold, 9, 11);
        label(EscapeStreak.Hint, Enum.Font.GothamMedium, 8, 10);
        EscapeStreak.Caption.TextXAlignment = Enum.TextXAlignment.Left;
        EscapeStreak.Count.TextXAlignment = Enum.TextXAlignment.Right;
        EscapeStreak.Caption.Position = UDim2.fromScale(0, 0);
        EscapeStreak.Caption.Size = UDim2.fromScale(0.88, 0.32);
        EscapeStreak.Count.Position = UDim2.fromScale(0.88, 0);
        EscapeStreak.Count.Size = UDim2.fromScale(0.12, 0.32);
        EscapeStreak.Segments.Position = UDim2.fromScale(0, 0.42);
        EscapeStreak.Segments.Size = UDim2.fromScale(1, 0.065);

        for _, child in EscapeStreak.Segments:GetChildren() do
            if child:IsA("Frame") then
                child.BackgroundTransparency = 0.35;
            end;
        end;

        EscapeStreak.Hint.Position = UDim2.fromScale(0, 0.62);
        EscapeStreak.Hint.Size = UDim2.fromScale(1, 0.34);
        EscapeStreak.Hint.TextTransparency = 0.15;
        local ChoiceAnnouncement = NotificationsF.ChoiceAnnouncement;
        label(ChoiceAnnouncement.Title, Enum.Font.GothamBold, 12, 19);
        label(ChoiceAnnouncement.Description, Enum.Font.GothamMedium, 9, 12);
        ChoiceAnnouncement.Title.Position = UDim2.fromScale(0, 0.14);
        ChoiceAnnouncement.Title.Size = UDim2.fromScale(1, 0.47);
        ChoiceAnnouncement.Description.Position = UDim2.fromScale(0, 0.68);
        ChoiceAnnouncement.Description.Size = UDim2.fromScale(1, 0.27);
        ChoiceAnnouncement.Description.TextTransparency = 0.12;
        ChoiceAnnouncement.Accent.Size = UDim2.new(0.1, 0, 0, 1);
        ChoiceAnnouncement.Accent.BackgroundTransparency = 0.25;

        local function resize() -- Line: 81
            -- upvalues: u1 (copy), NotificationsF (copy), EscapeStreak (copy), ChoiceAnnouncement (copy)
            local AbsoluteSize = u1.MainFrame.AbsoluteSize;
            local math_clamp_ret = math.clamp(AbsoluteSize.Y / 720, 0.75, 1.15);
            local v7 = AbsoluteSize.X - 28;
            local math_clamp_ret2 = math.clamp(AbsoluteSize.X * (AbsoluteSize.X < AbsoluteSize.Y and 0.9 or 0.52), 280, 640);
            local math_min_ret = math.min(v7, math_clamp_ret2);
            local v8 = math_clamp_ret * 12;

            if AbsoluteSize.X < AbsoluteSize.Y then
                local Parent = u1.Parent;
                local ValleyHUD = Parent:FindFirstChild("ValleyHUD");
                local AdminUI = Parent:FindFirstChild("AdminUI");
                local v9 = {};
                local v10;

                if ValleyHUD then
                    v10 = ValleyHUD:FindFirstChild("Servers");
                else
                    v10 = ValleyHUD;
                end;

                if ValleyHUD then
                    ValleyHUD = ValleyHUD:FindFirstChild("Updates");
                end;

                if AdminUI then
                    AdminUI = AdminUI:FindFirstChild("OpenBroadcast");
                end;

                v9[1], v9[2], v9[3] = v10, ValleyHUD, AdminUI;

                for _, v in v9 do
                    if v and v.Visible then
                        v8 = math.max(v8, v.AbsolutePosition.Y + v.AbsoluteSize.Y - u1.MainFrame.AbsolutePosition.Y + 10);
                    end;
                end;
            end;

            NotificationsF.AnchorPoint = Vector2.new(0.5, 0);
            NotificationsF.Position = UDim2.new(0.5, 0, 0, v8);
            NotificationsF.Size = UDim2.fromOffset(math.max(100, math_min_ret), math_clamp_ret * 76);
            EscapeStreak.Size = UDim2.fromOffset(math.min(math_min_ret * 0.8, math_clamp_ret * 290), math_clamp_ret * 40);
            ChoiceAnnouncement.Size = UDim2.new(1, 0, 0, math_clamp_ret * 58);
        end;

        resize();

        return u1.MainFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(resize), resize;
    end
};