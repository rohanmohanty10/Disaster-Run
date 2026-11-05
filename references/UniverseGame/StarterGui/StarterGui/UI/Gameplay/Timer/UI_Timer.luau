  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local TweenService = game:GetService("TweenService");

    function p1.ShowTimer(p2, u3, u4) -- Line: 5
        -- upvalues: TweenService (copy), Parent (copy)
        local function Disappear(p5) -- Line: 6
            -- upvalues: TweenService (ref), Parent (ref)
            if p5 then
                TweenService:Create(Parent, TweenInfo.new(0.85, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    TextTransparency = 1,
                    MaxVisibleGraphemes = utf8.len(Parent.Text),
                    Position = UDim2.fromScale(0.5, 0.16)
                }):Play();
                task.wait(0.85);
            end;

            Parent.Visible = false;
            Parent:SetAttribute("Timer", nil);
        end;

        if Parent.Visible and Parent:GetAttribute("Timer") then
            Disappear(u3 == false);
        end;

        if u3 == false then
            return;
        end;

        local function formatTime(p6) -- Line: 26
            local v7 = math.floor(p6 / 60);

            return string.format("%i:%02i", v7, p6 % 60);
        end;

        local u8 = math.random(1, 1000000);
        Parent:SetAttribute("ID", u8);
        Parent:SetAttribute("Timer", u3);
        Parent.Visible = true;
        Parent.TextTransparency = 1;
        Parent.Position = UDim2.fromScale(0.5, 0.16);
        local v9 = math.floor(u3 / 60);
        Parent.Text = `{u4 or "TIME REMAINING:"} {string.format("%i:%02i", v9, u3 % 60)}`;
        Parent.MaxVisibleGraphemes = -1;
        TweenService:Create(Parent, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0,
            MaxVisibleGraphemes = utf8.len(Parent.Text),
            Position = UDim2.fromScale(0.5, 0.186)
        }):Play();
        task.spawn(function() -- Line: 47
            -- upvalues: u3 (copy), Parent (ref), u4 (copy), u8 (copy), Disappear (copy)
            local v10 = u3;

            repeat
                v10 = v10 - task.wait(1);
                local v11 = math.floor(v10 / 60);
                Parent.Text = `{u4 or "TIME REMAINING:"} {string.format("%i:%02i", v11, v10 % 60)}`;
            until not Parent:IsDescendantOf(game) or (Parent:GetAttribute("ID") ~= u8 or (not Parent:GetAttribute("Timer") or Parent:GetAttribute("Timer") <= 0));

            Disappear(true);
        end);
    end;
end;