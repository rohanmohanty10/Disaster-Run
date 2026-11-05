  

 

local TweenService = game:GetService("TweenService");

return function(u1, u2, u3) -- Line: 2
    -- upvalues: TweenService (copy)
    local glitch = u1.PlayerGui.Extra.ScreenImages.Glitch.glitch;
    u1.PlayerGui.Extra.ScreenImages.Glitch.Visible = true;
    local v4 = TweenService:Create(glitch, TweenInfo.new(u2), {
        ImageTransparency = 0
    });
    v4:Play();
    v4.Completed:connect(function() -- Line: 9
        -- upvalues: u3 (copy), TweenService (ref), glitch (copy), u2 (copy), u1 (copy)
        if not u3 then
            glitch.ImageTransparency = 1;
            u1.PlayerGui.Extra.ScreenImages.Glitch.Visible = false;

            return;
        end;

        local v5 = TweenService:Create(glitch, TweenInfo.new(u2), {
            ImageTransparency = 1
        });
        v5:Play();
        v5.Completed:connect(function() -- Line: 14
            -- upvalues: u1 (ref)
            u1.PlayerGui.Extra.ScreenImages.Glitch.Visible = true;
        end);
    end);
end;