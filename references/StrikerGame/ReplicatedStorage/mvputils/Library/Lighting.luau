 

 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");

return {
    CCFlash = function(p1: table) -- Line: 9, Name: CCFlash
        -- upvalues: Lighting (copy), TweenService (copy), Debris (copy)
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Brightness = p1.Brightness or 0;
        ColorCorrectionEffect.Saturation = p1.Saturation or 0;
        ColorCorrectionEffect.Contrast = p1.Contrast or 0;
        ColorCorrectionEffect.TintColor = p1.Color or Color3.fromRGB(255, 255, 255);
        ColorCorrectionEffect.Parent = Lighting;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(p1.Duration or 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = 0,
            Saturation = 0,
            Contrast = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        Debris:AddItem(ColorCorrectionEffect, p1.Duration or 0.2);

        return ColorCorrectionEffect;
    end,

    PointLight = function(p2: table) -- Line: 32, Name: PointLight
        -- upvalues: TweenService (copy), Debris (copy)
        assert(p2.Parent, "Parent Is Required");
        local PointLight = Instance.new("PointLight");
        PointLight.Enabled = true;
        PointLight.Color = p2.Color or Color3.fromRGB(105, 195, 255);
        PointLight.Range = p2.InitalRange or 10;
        PointLight.Brightness = p2.InitalBrightness or 2;
        PointLight.Parent = p2.Parent;
        TweenService:Create(PointLight, TweenInfo.new(p2.Duration or 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = 0,
            Range = p2.EndRange or (p2.InitalRange or 10) * 1.5
        }):Play();
        Debris:AddItem(PointLight, p2.Duration or 1);

        return PointLight;
    end,

    Highlight = function(p3: table) -- Line: 55, Name: Highlight
        -- upvalues: TweenService (copy), Debris (copy)
        assert(p3.Model, "BasePart Or Model Is Required");
        local Highlight = Instance.new("Highlight");
        Highlight.Adornee = p3.Model;
        Highlight.DepthMode = p3.DepthMode or Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = p3.FillColor or Color3.new(1, 1, 1);
        Highlight.OutlineColor = p3.OutlineColor or Color3.new(1, 1, 1);
        local v4 = p3.FadeDirection == "In" and "In" or "Out";
        local v5, v6;

        if v4 == "In" then
            v5 = p3.InitalFillTransparency or 0;
            v6 = 1;
        else
            v6 = p3.InitalFillTransparency or 0;
            v5 = 1;
        end;

        Highlight.FillTransparency = v6;
        Highlight.OutlineTransparency = v6;
        Highlight.Parent = p3.Model;
        TweenService:Create(Highlight, TweenInfo.new(p3.Duration or 0.5, Enum.EasingStyle.Sine, v4 == "In" and Enum.EasingDirection.In or Enum.EasingDirection.Out), {
            FillTransparency = v5,
            OutlineTransparency = v5
        }):Play();
        Debris:AddItem(Highlight, p3.Duration or 0.5);

        return Highlight;
    end,

    PulseHighlight = function(p7: table) -- Line: 91, Name: PulseHighlight
        -- upvalues: TweenService (copy), Debris (copy)
        assert(p7.Model, "Model Is Required");
        local Highlight = Instance.new("Highlight");
        Highlight.Adornee = p7.Model;
        Highlight.DepthMode = p7.DepthMode or Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = p7.FillColor or Color3.new(1, 1, 1);
        Highlight.OutlineColor = p7.OutlineColor or Color3.new(1, 1, 1);
        local v8 = p7.PulseDuration or 0.5;
        local v9 = p7.StartTransparency or 0;
        local v10 = p7.EndTransparency or 0;
        Highlight.FillTransparency = v9;
        Highlight.OutlineTransparency = v9;
        Highlight.Parent = p7.Model;
        local TweenInfo_new_ret = TweenInfo.new(v8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        local TweenInfo_new_ret2 = TweenInfo.new(v8, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        local u11 = TweenService:Create(Highlight, TweenInfo_new_ret, {
            FillTransparency = v10,
            OutlineTransparency = v10
        });
        local u12 = TweenService:Create(Highlight, TweenInfo_new_ret2, {
            FillTransparency = v9,
            OutlineTransparency = v9
        });
        local u13 = 0;
        local u14 = p7.RepeatCount or 0;

        local function DoPulse() -- Line: 116
            -- upvalues: Highlight (copy), u11 (copy), u12 (copy), u13 (ref), u14 (copy), DoPulse (copy), Debris (ref)
            if not (Highlight and Highlight.Parent) then
                return;
            end;

            u11:Play();
            u11.Completed:Wait();

            if not (Highlight and Highlight.Parent) then
                return;
            end;

            u12:Play();
            u12.Completed:Wait();
            u13 = u13 + 1;

            if u14 == 0 or u13 < u14 then
                task.spawn(DoPulse);

                return;
            end;

            Debris:AddItem(Highlight, 0.1);
        end;

        task.spawn(DoPulse);

        return Highlight;
    end,

    FlashHighlight = function(p15: table) -- Line: 141, Name: FlashHighlight
        -- upvalues: TweenService (copy), Debris (copy)
        assert(p15.Model, "Model Is Required");
        local Highlight = Instance.new("Highlight");
        Highlight.Adornee = p15.Model;
        Highlight.DepthMode = p15.DepthMode or Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = p15.FillColor or Color3.new(1, 1, 1);
        Highlight.OutlineColor = p15.OutlineColor or Color3.new(1, 1, 1);
        local v16 = p15.StartTransparency or 0;
        Highlight.FillTransparency = v16;
        Highlight.OutlineTransparency = v16;
        Highlight.Parent = p15.Model;
        local v17 = p15.FlashSpeed or 0.1;
        local u18 = p15.FlashDuration or 1;
        local TweenInfo_new_ret = TweenInfo.new(v17 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local TweenInfo_new_ret2 = TweenInfo.new(v17 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local u19 = TweenService:Create(Highlight, TweenInfo_new_ret, {
            FillTransparency = v16,
            OutlineTransparency = v16
        });
        local u20 = TweenService:Create(Highlight, TweenInfo_new_ret2, {
            FillTransparency = 1,
            OutlineTransparency = 1
        });
        local os_clock_ret = os.clock();

        local function DoFlash() -- Line: 165
            -- upvalues: Highlight (copy), os_clock_ret (copy), u18 (copy), Debris (ref), u19 (copy), u20 (copy), DoFlash (copy)
            if not (Highlight and Highlight.Parent) then
                return;
            end;

            if u18 <= os.clock() - os_clock_ret then
                Debris:AddItem(Highlight, 0.1);

                return;
            end;

            u19:Play();
            u19.Completed:Wait();

            if not (Highlight and Highlight.Parent) then
                return;
            end;

            u20:Play();
            u20.Completed:Wait();
            task.spawn(DoFlash);
        end;

        task.spawn(DoFlash);
        Debris:AddItem(Highlight, u18 + 0.5);

        return Highlight;
    end
};