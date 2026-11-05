 
-- Decompiled with Potassium's decompiler.

local l__Debris__1 = game:GetService("Debris");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("RunService");
return {
    tweenHighlight = function(p1, p2, p3, p4, p5, p6, p7) --[[ Name: tweenHighlight, Line 7 ]]
        -- upvalues: l__TweenService__2 (copy), l__Debris__1 (copy)
        local v8 = p4 or 1;
        local v9 = Instance.new("Highlight");
        v9.Adornee = p1;
        v9.DepthMode = p5 or Enum.HighlightDepthMode.Occluded;
        v9.FillColor = p2 or Color3.new(1, 1, 1);
        v9.OutlineColor = p3 or Color3.new(1, 1, 1);
        v9.OutlineTransparency = 0;
        local v10, v11;
        if p6 == "Out" then
            v10 = 1;
            v11 = 0;
        else
            v10 = p7 or 0;
            v11 = 1;
        end;
        v9.FillTransparency = v10;
        v9.OutlineTransparency = v10;
        v9.Parent = p1;
        l__TweenService__2:Create(v9, TweenInfo.new(v8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FillTransparency = v11,
            OutlineTransparency = v11
        }):Play();
        l__Debris__1:AddItem(v9, v8);
        return v9;
    end,
    pulseHighlight = function(p12, p13, p14, p15, p16, p17, p18, p19) --[[ Name: pulseHighlight, Line 54 ]]
        -- upvalues: l__TweenService__2 (copy), l__Debris__1 (copy)
        local u20 = Instance.new("Highlight");
        u20.Adornee = p12;
        u20.DepthMode = p16 or Enum.HighlightDepthMode.Occluded;
        u20.FillColor = p13 or Color3.new(1, 1, 1);
        u20.OutlineColor = p14 or Color3.new(1, 1, 1);
        local v21 = p15 or 0.5;
        local v22 = p18 or 0;
        local v23 = p19 or 1;
        u20.FillTransparency = v22;
        u20.OutlineTransparency = v22;
        u20.Parent = p12;
        local v24 = TweenInfo.new(v21, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        local v25 = TweenInfo.new(v21, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        local u26 = l__TweenService__2:Create(u20, v24, {
            FillTransparency = v23,
            OutlineTransparency = v23
        });
        local u27 = l__TweenService__2:Create(u20, v25, {
            FillTransparency = v22,
            OutlineTransparency = v22
        });
        local u28 = 0;
        local u29 = p17 or 0;
        local function u30() --[[ Line: 90 ]]
            -- upvalues: u20 (copy), u26 (copy), u27 (copy), u28 (ref), u29 (copy), u30 (copy), l__Debris__1 (ref)
            if u20 and u20.Parent then
                u26:Play();
                u26.Completed:Wait();
                if u20 and u20.Parent then
                    u27:Play();
                    u27.Completed:Wait();
                    u28 = u28 + 1;
                    if u29 == 0 or u28 < u29 then
                        task.spawn(u30);
                    else
                        l__Debris__1:AddItem(u20, 0.1);
                    end;
                end;
            end;
        end;
        task.spawn(u30);
        return u20;
    end,
    flashHighlight = function(p31, p32, p33, p34, p35, p36) --[[ Name: flashHighlight, Line 115 ]]
        -- upvalues: l__TweenService__2 (copy), l__Debris__1 (copy)
        local u37 = Instance.new("Highlight");
        u37.Adornee = p31;
        u37.DepthMode = p36 or Enum.HighlightDepthMode.Occluded;
        u37.FillColor = p32 or Color3.new(1, 1, 1);
        u37.OutlineColor = p33 or Color3.new(1, 1, 1);
        u37.FillTransparency = 1;
        u37.OutlineTransparency = 1;
        u37.Parent = p31;
        local v38 = p35 or 0.1;
        local u39 = p34 or 1;
        local v40 = TweenInfo.new(v38 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local v41 = TweenInfo.new(v38 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local u42 = l__TweenService__2:Create(u37, v40, {
            FillTransparency = 0,
            OutlineTransparency = 0
        });
        local u43 = l__TweenService__2:Create(u37, v41, {
            FillTransparency = 1,
            OutlineTransparency = 1
        });
        local u44 = os.clock();
        local function u45() --[[ Line: 146 ]]
            -- upvalues: u37 (copy), u44 (copy), u39 (copy), l__Debris__1 (ref), u42 (copy), u43 (copy), u45 (copy)
            if u37 and u37.Parent then
                if u39 <= os.clock() - u44 then
                    l__Debris__1:AddItem(u37, 0.1);
                else
                    u42:Play();
                    u42.Completed:Wait();
                    if u37 and u37.Parent then
                        u43:Play();
                        u43.Completed:Wait();
                        task.spawn(u45);
                    end;
                end;
            end;
        end;
        task.spawn(u45);
        l__Debris__1:AddItem(u37, u39 + 0.5);
        return u37;
    end
};