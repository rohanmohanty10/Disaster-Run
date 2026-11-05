 

local l__Debris__1 = game:GetService("Debris");
local l__TweenService__2 = game:GetService("TweenService");
local l__Lighting__3 = game:GetService("Lighting");
return {
    colorCorrectionFlash = function(p1, p2, p3, p4, p5) --[[ Name: colorCorrectionFlash, Line 7 ]]
        -- upvalues: l__Lighting__3 (copy), l__TweenService__2 (copy), l__Debris__1 (copy)
        local v6 = p5 or 0.2;
        local v7 = Instance.new("ColorCorrectionEffect");
        v7.Brightness = p1;
        v7.Saturation = p2;
        v7.Contrast = p3;
        v7.TintColor = p4 or Color3.fromRGB(255, 255, 255);
        v7.Parent = l__Lighting__3;
        l__TweenService__2:Create(v7, TweenInfo.new(v6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = 0,
            Saturation = 0,
            Contrast = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        l__Debris__1:AddItem(v7, v6);
    end,
    PointLight = function(p8, p9, p10, p11, p12, p13) --[[ Name: PointLight, Line 35 ]]
        -- upvalues: l__TweenService__2 (copy), l__Debris__1 (copy)
        local v14 = p10 or 1;
        local v15 = Instance.new("PointLight");
        v15.Enabled = true;
        v15.Color = p9 or Color3.fromRGB(105, 195, 255);
        v15.Range = p11 or 10;
        v15.Brightness = p13 or 2;
        v15.Parent = p8;
        l__TweenService__2:Create(v15, TweenInfo.new(v14, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = 0,
            Range = p12 or (p11 or 10) * 1.5
        }):Play();
        l__Debris__1:AddItem(v15, v14);
        return v15;
    end
};