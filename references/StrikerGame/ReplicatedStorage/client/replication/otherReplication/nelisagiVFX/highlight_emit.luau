 

 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");

return {
    tweenHighlight = function(p1: userdata, p2, p3, p4: number?, p5: any, p6: string?, p7: number?) -- Line: 7
        -- upvalues: TweenService (copy), Debris (copy)
        print("cab u work?");
        local v8 = p4 or 1;
        local Highlight = Instance.new("Highlight");
        Highlight.Adornee = p1;
        Highlight.DepthMode = p5 or Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = p2 or Color3.new(1, 1, 1);
        Highlight.OutlineColor = p3 or Color3.new(1, 1, 1);
        Highlight.OutlineTransparency = 0;
        local v9, v10;

        if p6 == "Out" then
            v9 = 1;
            v10 = 0;
        else
            v9 = p7 or 0;
            v10 = 1;
        end;

        Highlight.FillTransparency = v9;
        Highlight.OutlineTransparency = v9;
        Highlight.Parent = p1;
        TweenService:Create(Highlight, TweenInfo.new(v8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FillTransparency = v10,
            OutlineTransparency = v10
        }):Play();
        Debris:AddItem(Highlight, v8);

        return Highlight;
    end,

    pulseHighlight = function(p11: userdata, p12, p13, p14: number?, p15: any, p16: number?, p17: number?, p18: number?) -- Line: 54
        -- upvalues: TweenService (copy), Debris (copy)
        local Highlight = Instance.new("Highlight");
        Highlight.Adornee = p11;
        Highlight.DepthMode = p15 or Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = p12 or Color3.new(1, 1, 1);
        Highlight.OutlineColor = p13 or Color3.new(1, 1, 1);
        local v19 = p14 or 0.5;
        local v20 = p17 or 0;
        local v21 = p18 or 1;
        Highlight.FillTransparency = v20;
        Highlight.OutlineTransparency = v20;
        Highlight.Parent = p11;
        local TweenInfo_new_ret = TweenInfo.new(v19, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        local TweenInfo_new_ret2 = TweenInfo.new(v19, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        local v22 = {
            FillTransparency = v21,
            OutlineTransparency = v21
        };
        local v23 = {
            FillTransparency = v20,
            OutlineTransparency = v20
        };
        local u24 = TweenService:Create(Highlight, TweenInfo_new_ret, v22);
        local u25 = TweenService:Create(Highlight, TweenInfo_new_ret2, v23);
        local u26 = 0;
        local u27 = p16 or 0;

        local function doPulse() -- Line: 91
            -- upvalues: Highlight (copy), u24 (copy), u25 (copy), u26 (ref), u27 (copy), doPulse (copy), Debris (ref)
            if not (Highlight and Highlight.Parent) then
                return;
            end;

            u24:Play();
            u24.Completed:Wait();

            if not (Highlight and Highlight.Parent) then
                return;
            end;

            u25:Play();
            u25.Completed:Wait();
            u26 = u26 + 1;

            if u27 == 0 or u26 < u27 then
                task.spawn(doPulse);

                return;
            end;

            Debris:AddItem(Highlight, 0.1);
        end;

        task.spawn(doPulse);

        return Highlight;
    end,

    flashHighlight = function(p28: userdata, p29, p30, p31: number?, p32: number?, p33: any, p34: number?) -- Line: 115
        -- upvalues: TweenService (copy), Debris (copy)
        local Highlight = Instance.new("Highlight");
        Highlight.Adornee = p28;
        Highlight.DepthMode = p33 or Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = p29 or Color3.new(1, 1, 1);
        Highlight.OutlineColor = p30 or Color3.new(1, 1, 1);
        Highlight.FillTransparency = p34;
        Highlight.OutlineTransparency = p34;
        Highlight.Parent = p28;
        local v35 = p32 or 0.1;
        local u36 = p31 or 1;
        local TweenInfo_new_ret = TweenInfo.new(v35 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local TweenInfo_new_ret2 = TweenInfo.new(v35 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local u37 = TweenService:Create(Highlight, TweenInfo_new_ret, {
            FillTransparency = p34,
            OutlineTransparency = p34
        });
        local u38 = TweenService:Create(Highlight, TweenInfo_new_ret2, {
            FillTransparency = 1,
            OutlineTransparency = 1
        });
        local os_clock_ret = os.clock();

        local function doFlash() -- Line: 148
            -- upvalues: Highlight (copy), os_clock_ret (copy), u36 (copy), Debris (ref), u37 (copy), u38 (copy), doFlash (copy)
            if not (Highlight and Highlight.Parent) then
                return;
            end;

            if u36 <= os.clock() - os_clock_ret then
                Debris:AddItem(Highlight, 0.1);

                return;
            end;

            u37:Play();
            u37.Completed:Wait();

            if not (Highlight and Highlight.Parent) then
                return;
            end;

            u38:Play();
            u38.Completed:Wait();
            task.spawn(doFlash);
        end;

        task.spawn(doFlash);
        Debris:AddItem(Highlight, u36 + 0.5);

        return Highlight;
    end
};