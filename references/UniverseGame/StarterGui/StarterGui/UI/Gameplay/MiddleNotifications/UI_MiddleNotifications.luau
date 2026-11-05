  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local Notification = Assets.Notification;
    local u2 = { { "ImageLabel", "ImageTransparency" }, { "TextLabel", "TextTransparency" }, { "Frame", "BackgroundTransparency" }, { "ScrollingFrame", "BackgroundTransparency", "ScrollBarImageTransparency" }, { "TextButton", "TextTransparency", "BackgroundTransparency" }, { "UIStroke", "Transparency" }, { "ImageButton", "ImageTransparency" }, { "CanvasGroup", "Transparency", "GroupTransparency" } };

    local function Transparentize(p3, p4) -- Line: 19
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v[1] == p3.ClassName then
                local v5 = {};

                for _, v2 in v do
                    if v2 ~= p3.ClassName then
                        if not p3:GetAttribute("Original" .. v2) then
                            p3:SetAttribute("Original" .. v2, p3[v2]);
                        end;

                        v5[v2] = p4 == 1 and p4 and p4 or p3:GetAttribute("Original" .. v2);
                        p3[v2] = 1;
                    end;
                end;

                for i, v2 in v5 do
                    p3[i] = v2;
                end;
            end;
        end;
    end;

    function p1.MassTransparentize(p6, p7, p8) -- Line: 42
        -- upvalues: Transparentize (copy)
        Transparentize(p6, p7);

        if p8 then
            for _, descendant in p6:GetDescendants() do
                Transparentize(descendant, p7);
            end;
        end;
    end;

    local function TweenObj(p9, p10, p11) -- Line: 53
        -- upvalues: u2 (copy), TweenService (ref)
        for _, v in pairs(u2) do
            if v[1] == p9.ClassName then
                local v12 = {};

                for _, v2 in pairs(v) do
                    if v2 ~= p9.ClassName then
                        if not p9:GetAttribute("Original" .. v2) then
                            p9:SetAttribute("Original" .. v2, p9[v2]);
                        end;

                        v12[v2] = p11 == 1 and p11 and p11 or p9:GetAttribute("Original" .. v2);

                        if p11 ~= 1 then
                            p9[v2] = 1;
                        end;
                    end;
                end;

                TweenService:Create(p9, p10, v12):Play();
            end;
        end;
    end;

    p1.TweenObj = TweenObj;

    function p1.TweenTransparency(p13) -- Line: 77
        -- upvalues: TweenObj (copy)
        local Object = p13.Object;
        local TweenInfo2 = p13.TweenInfo;
        local Transparency = p13.Transparency;

        if p13.TweenObject then
            TweenObj(Object, TweenInfo2, Transparency);
        end;

        for _, descendant in Object:GetDescendants() do
            TweenObj(descendant, TweenInfo2, Transparency);
        end;
    end;

    local function CreateNotification(p14, p15) -- Line: 94
        -- upvalues: Notification (copy), Assets (copy), Parent (copy)
        local v16 = Notification;

        if p15 then
            v16 = Assets:FindFirstChild(p15);

            if not v16 then
                error("invalid template for middle notification; please provide a real name");

                return;
            end;
        end;

        local v17 = v16:Clone();
        v17.Content.NotificationText.TextColor3 = p14;
        v17.Visible = true;
        v17.Parent = Parent;

        return v17;
    end;

    function p1.CreateMiddleNotification(p18, p19) -- Line: 111
        -- upvalues: Parent (copy), Notification (copy), Assets (copy), TweenService (ref)
        local NumericalContent = p19.NumericalContent;
        local v20 = p19.NumericalSuffix or "";
        local Verb = p19.Verb;
        local Subject = p19.Subject;
        local v21 = p19.NotificationIdentifier or `{v20}{Verb}{Subject}`;

        if not p19.DisableStacking then
            for _, child in Parent:GetChildren() do
                if child:GetAttribute("NotificationIdentifier") and child:GetAttribute("NotificationIdentifier") == v21 then
                    local v22 = child:GetAttribute("NumericalContent");

                    if v22 then
                        NumericalContent = NumericalContent + v22;
                        child:Destroy();
                    end;
                end;
            end;
        end;

        local v23 = p19.NumericalContentColor or Color3.fromRGB(255, 225, 103);
        local v24 = p19.VerbColor or Color3.fromRGB(255, 255, 255);
        local v25 = p19.SubjectColor or Color3.fromRGB(255, 90, 90);
        local v26 = `[+{p18:AbbreviateNumber(NumericalContent)} {v20}]    `;
        local v27 = typeof(NumericalContent) == "number" and NumericalContent <= 0 and "" or v26;

        if p19.TextStrokeColor then
            v27 = `<stroke color="#{p19.TextStrokeColor:ToHex()}">{v27}</stroke>`;
        end;

        local v28 = v27 .. `{Verb} {Subject}`;
        local v29 = v27 .. `<font color="#{v24:ToHex()}">{Verb}</font> <font color="#{v25:ToHex()}">{Subject}</font>`;
        local Template = p19.Template;
        local v30 = Notification;
        local u31;

        if Template then
            v30 = Assets:FindFirstChild(Template);

            if v30 then
                u31 = v30:Clone();
                u31.Content.NotificationText.TextColor3 = v23;
                u31.Visible = true;
                u31.Parent = Parent;
            else
                error("invalid template for middle notification; please provide a real name");
                u31 = nil;
            end;
        else
            u31 = v30:Clone();
            u31.Content.NotificationText.TextColor3 = v23;
            u31.Visible = true;
            u31.Parent = Parent;
        end;

        u31:SetAttribute("NotificationIdentifier", v21);
        u31:SetAttribute("NumericalContent", NumericalContent);
        u31.Content.NotificationText.Text = v29;
        u31.Content.Position = p19.MiddleTemplatePosition or UDim2.fromScale(0.5, 0);
        TweenService:Create(u31.Content, TweenInfo.new(0.175, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = p19.OriginalTemplatePosition or UDim2.fromScale(0, 0)
        }):Play();
        p18.TweenTransparency({
            TweenObject = false,
            Transparency = 1,
            Object = u31.Content,
            TweenInfo = TweenInfo.new(0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        });
        TweenService:Create(u31.Content.NotificationText, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            MaxVisibleGraphemes = utf8.len(v28)
        }):Play();
        p18.TweenTransparency({
            TweenObject = false,
            Transparency = 0,
            Object = u31.Content,
            TweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        });
        task.wait(2.65);

        if not u31.Parent then
            return;
        end;

        p18.TweenTransparency({
            TweenObject = false,
            Transparency = 1,
            Object = u31.Content,
            TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        });
        task.delay(1, function() -- Line: 183
            -- upvalues: u31 (copy)
            if not u31.Parent then
                return;
            end;

            u31:Destroy();
        end);
    end;
end;