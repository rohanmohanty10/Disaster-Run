  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    local Parent = script.Parent;
    local u2 = false;
    local u3 = nil;

    function p1.StartPotionProgress(p4, p5, p6, p7) -- Line: 8
        -- upvalues: u2 (ref), Parent (copy), u3 (ref), TweenService (ref)
        u2 = true;
        Parent.Visible = true;
        Parent.BarDisplay.Text = `{string.upper(p7 or "Drinking")} [{(p6 or "Potion"):upper()}]`;
        Parent.Percent.Size = UDim2.fromScale(0, 1);
        u3 = TweenService:Create(Parent.Percent, TweenInfo.new(p5 or 3, Enum.EasingStyle.Linear), {
            Size = UDim2.fromScale(1, 1)
        });
        u3:Play();
        u3.Completed:Wait();

        if u2 then
            u2 = false;
            Parent.Visible = false;
        end;
    end;

    function p1.EndPotionProgress(p8) -- Line: 31
        -- upvalues: Parent (copy), u2 (ref), u3 (ref)
        Parent.Visible = false;
        u2 = false;

        if u3 then
            u3:Pause();
        end;
    end;
end;