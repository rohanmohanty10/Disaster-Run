  

 

return function(p1) -- Line: 1
    game:GetService("TweenService");
    local Parent = script.Parent;

    function p1.FloatingWideAnnouncement(p2, p3, p4) -- Line: 5
        -- upvalues: Parent (copy)
        local v5 = Parent.Assets:FindFirstChild("FloatingWideAnnouncement"):Clone();
        v5.Name = p3;
        v5.Main.Text = `< {p3:upper()} >`;
        v5.MainShadow.Text = `< {p3:upper()} >`;
        v5.BackgroundTransparency = 1;
        v5.Main.TextTransparency = 1;
        v5.MainShadow.TextTransparency = 1;
    end;
end;