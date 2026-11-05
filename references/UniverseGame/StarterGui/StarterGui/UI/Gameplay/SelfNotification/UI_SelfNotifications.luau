  

 

local u1 = nil;

return function(p2) -- Line: 3
    -- upvalues: u1 (ref)
    local Parent = script.Parent;
    local TweenService = game:GetService("TweenService");

    function p2.ShowSelfNotification(p3, p4, p5, p6, p7) -- Line: 7
        -- upvalues: Parent (copy), TweenService (copy), u1 (ref)
        if Parent.Visible and p5 == false then
            TweenService:Create(Parent, TweenInfo.new(0.85, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                TextTransparency = 1,
                MaxVisibleGraphemes = utf8.len(Parent.Text),
                Position = UDim2.fromScale(0.5, 0.16)
            }):Play();
            task.wait(0.85);
            Parent.Visible = false;

            return;
        end;

        if u1 and p7 then
            pcall(task.cancel, u1);
            u1 = nil;
        end;

        if not p7 or p7 and not Parent.Visible then
            Parent.Visible = true;
            Parent.TextTransparency = 1;
            Parent.Position = UDim2.fromScale(0.5, 0.16);
            Parent.MaxVisibleGraphemes = -1;
        end;

        Parent.Text = p4;
        TweenService:Create(Parent, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0,
            MaxVisibleGraphemes = utf8.len(Parent.Text),
            Position = p6 or UDim2.fromScale(0.5, 0.186)
        }):Play();

        if typeof(p5) == "number" and not Parent:GetAttribute("Timer") then
            u1 = task.delay(p5, function() -- Line: 42
                -- upvalues: TweenService (ref), Parent (ref), u1 (ref)
                TweenService:Create(Parent, TweenInfo.new(0.85, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    TextTransparency = 1,
                    MaxVisibleGraphemes = utf8.len(Parent.Text),
                    Position = UDim2.fromScale(0.5, 0.16)
                }):Play();
                task.wait(0.85);
                Parent.Visible = false;
                u1 = nil;
            end);
        end;
    end;
end;