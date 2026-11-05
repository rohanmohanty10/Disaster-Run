  

 

local LocalPlayer = game.Players.LocalPlayer;
local TweenService = game:GetService("TweenService");

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait();
end;

local Parent = script.Parent;
local Frame1 = Parent.Frame1;
local Frame2 = Parent.Frame2;
local u1 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false);
LocalPlayer:WaitForChild("Values"):WaitForChild("BarProgress").Changed:Connect(function(u2) -- Line: 11
    -- upvalues: TweenService (copy), Parent (copy), Frame2 (copy), u1 (copy), Frame1 (copy)
    local v3 = u2 * 0.36;
    TweenService:Create(Parent, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, true), {
        Position = UDim2.new(Parent.Position.X.Scale * Random.new():NextNumber(-0.1, 0.1), 0, Parent.Position.Y.Scale, 0)
    }):Play();

    if v3 > 0 and v3 <= 180 then
        TweenService:Create(Frame2.ImageLabel.UIGradient, u1, {
            Rotation = v3
        }):Play();

        return;
    end;

    if v3 <= 180 or v3 > 360 then
        if v3 == 0 then
            local v4 = TweenService:Create(Frame1.ImageLabel.UIGradient, TweenInfo.new(u2 / 500, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Rotation = 180
            });
            v4:Play();
            v4.Completed:Connect(function() -- Line: 27
                -- upvalues: TweenService (ref), Frame2 (ref), u2 (copy)
                TweenService:Create(Frame2.ImageLabel.UIGradient, TweenInfo.new(u2 / 500, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Rotation = 0
                }):Play();
            end);
        end;

        return;
    end;

    TweenService:Create(Frame2.ImageLabel.UIGradient, u1, {
        Rotation = 180
    }):Play();
    TweenService:Create(Frame1.ImageLabel.UIGradient, u1, {
        Rotation = v3
    }):Play();
end);