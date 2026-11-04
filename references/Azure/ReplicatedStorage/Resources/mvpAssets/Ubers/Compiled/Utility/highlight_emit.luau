 
 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");

return {
    tweenHighlight = function(p1: userdata, p2, p3, p4: number?, p5: any, p6: string?, p7: number?, p8: number?) -- Line: 7
        -- upvalues: TweenService (copy), Debris (copy)
        local v9 = p4 or 1;
        local Highlight = Instance.new("Highlight");
        Highlight.Adornee = p1;
        Highlight.DepthMode = p5 or Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = p2 or Color3.new(1, 1, 1);
        Highlight.OutlineColor = p3 or Color3.new(1, 1, 1);
        local v10, v11, v12, v13;

        if p6 == "Out" then
            v10 = 1;
            v11 = 1;
            v12 = 0;
            v13 = 0;
        else
            v10 = p7 or 0;
            v11 = p8 or 0;
            v12 = 1;
            v13 = 1;
        end;

        Highlight.FillTransparency = v10;
        Highlight.OutlineTransparency = v11;
        Highlight.Parent = p1;
        TweenService:Create(Highlight, TweenInfo.new(v9, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FillTransparency = v12,
            OutlineTransparency = v13
        }):Play();
        Debris:AddItem(Highlight, v9);

        return Highlight;
    end,

    pulseHighlight = function(p14: userdata, p15, p16, p17: number?, p18: any, p19: number?, p20: number?, p21: number?, p22: number?, p23: number?) -- Line: 57
        -- upvalues: TweenService (copy), Debris (copy)
        local Highlight = Instance.new("Highlight");
        Highlight.Adornee = p14;
        Highlight.DepthMode = p18 or Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = p15 or Color3.new(1, 1, 1);
        Highlight.OutlineColor = p16 or Color3.new(1, 1, 1);
        local v24 = p17 or 0.5;
        local v25 = p20 or 0;
        local v26 = p22 or 0;
        Highlight.FillTransparency = v25;
        Highlight.OutlineTransparency = v26;
        Highlight.Parent = p14;
        local TweenInfo_new_ret = TweenInfo.new(v24, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        local TweenInfo_new_ret2 = TweenInfo.new(v24, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        local v27 = {
            FillTransparency = v25,
            OutlineTransparency = v26
        };
        local u28 = TweenService:Create(Highlight, TweenInfo_new_ret, {
            FillTransparency = p21 or 1,
            OutlineTransparency = p23 or 1
        });
        local u29 = TweenService:Create(Highlight, TweenInfo_new_ret2, v27);
        local u30 = 0;
        local u31 = p19 or 0;

        local function doPulse() -- Line: 97
            -- upvalues: Highlight (copy), u28 (copy), u29 (copy), u30 (ref), u31 (copy), doPulse (copy), Debris (ref)
            if not (Highlight and Highlight.Parent) then
                return;
            end;

            u28:Play();
            u28.Completed:Wait();

            if not (Highlight and Highlight.Parent) then
                return;
            end;

            u29:Play();
            u29.Completed:Wait();
            u30 = u30 + 1;

            if u31 == 0 or u30 < u31 then
                task.spawn(doPulse);

                return;
            end;

            Debris:AddItem(Highlight, 0.1);
        end;

        task.spawn(doPulse);

        return Highlight;
    end,

    flashHighlight = function(p32: userdata, p33, p34, p35: number?, p36: number?, p37: any, p38: number?, p39: number?) -- Line: 116
        -- upvalues: TweenService (copy), Debris (copy)
        local Highlight = Instance.new("Highlight");
        Highlight.Adornee = p32;
        Highlight.DepthMode = p37 or Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = p33 or Color3.new(1, 1, 1);
        Highlight.OutlineColor = p34 or Color3.new(1, 1, 1);
        local v40 = p38 or 0;
        local v41 = p39 or 0;
        Highlight.FillTransparency = v40;
        Highlight.OutlineTransparency = v41;
        Highlight.Parent = p32;
        local v42 = p36 or 0.1;
        local u43 = p35 or 1;
        local TweenInfo_new_ret = TweenInfo.new(v42 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local TweenInfo_new_ret2 = TweenInfo.new(v42 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local u44 = TweenService:Create(Highlight, TweenInfo_new_ret, {
            FillTransparency = v40,
            OutlineTransparency = v41
        });
        local u45 = TweenService:Create(Highlight, TweenInfo_new_ret2, {
            FillTransparency = 1,
            OutlineTransparency = 1
        });
        local os_clock_ret = os.clock();

        local function doFlash() -- Line: 153
            -- upvalues: Highlight (copy), os_clock_ret (copy), u43 (copy), Debris (ref), u44 (copy), u45 (copy), doFlash (copy)
            if not (Highlight and Highlight.Parent) then
                return;
            end;

            if u43 <= os.clock() - os_clock_ret then
                Debris:AddItem(Highlight, 0.1);

                return;
            end;

            u44:Play();
            u44.Completed:Wait();

            if not (Highlight and Highlight.Parent) then
                return;
            end;

            u45:Play();
            u45.Completed:Wait();
            task.spawn(doFlash);
        end;

        task.spawn(doFlash);
        Debris:AddItem(Highlight, u43 + 0.5);

        return Highlight;
    end
};