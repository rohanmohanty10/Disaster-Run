 

 

local UserInputService = game:GetService("UserInputService");

return {
    bind = function(u1, u2) -- Line: 6, Name: bind
        local u4 = u1.InputBegan:Connect(function(p3) -- Line: 7
            -- upvalues: u1 (copy), u2 (copy)
            if p3.UserInputType == Enum.UserInputType.Touch and (u1.Visible and u1.Interactable) then
                u2(true);
            end;
        end);
        local u6 = u1.Activated:Connect(function(p5) -- Line: 10
            -- upvalues: u1 (copy), u2 (copy)
            if (not p5 or p5.UserInputType ~= Enum.UserInputType.Touch) and (u1.Visible and u1.Interactable) then
                u2(false);
            end;
        end);

        return {
            Disconnect = function() -- Line: 13, Name: Disconnect
                -- upvalues: u4 (copy), u6 (copy)
                u4:Disconnect();
                u6:Disconnect();
            end
        };
    end,

    update = function(p7, p8, p9, p10) -- Line: 15, Name: update
        -- upvalues: UserInputService (copy)
        p7.Visible = UserInputService.TouchEnabled and p8;

        if not p7.Visible then
            return;
        end;

        local Label = p7.Label;

        if p9 > 0.02 then
            p10 = ("%.1f"):format(p9) or p10;
        end;

        Label.Text = p10;
        p7.BackgroundTransparency = p9 > 0.02 and 0.45 or 0.12;
        p7.Label.TextTransparency = p9 > 0.02 and 0.25 or 0;
    end
};