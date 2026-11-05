  

 

local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy), Lighting (copy)
    local ImageLabel = script.Parent.ImageLabel;
    local u2 = "Day";
    script.Parent.MouseButton1Down:Connect(function() -- Line: 8
        -- upvalues: u2 (ref), ImageLabel (copy), TweenService (ref), Lighting (ref)
        if u2 == "Day" then
            u2 = "Night";
        else
            u2 = "Day";
        end;

        if u2 == "Night" then
            ImageLabel.Image = "rbxassetid://13157200989";
            TweenService:Create(Lighting, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ClockTime = 0,
                Brightness = 0
            }):Play();

            return;
        end;

        ImageLabel.Image = "rbxassetid://13157164326";
        TweenService:Create(Lighting, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ClockTime = 12,
            Brightness = 2
        }):Play();
    end);
end;