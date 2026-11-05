  

 

local LocalPlayer = game.Players.LocalPlayer;
local TweenService = game:GetService("TweenService");

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait();
end;

local Parent = script.Parent;
local u1 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false);
LocalPlayer:WaitForChild("Values"):WaitForChild("BarProgress").Changed:Connect(function(p2) -- Line: 9
    -- upvalues: Parent (copy), TweenService (copy), u1 (copy)
    if p2 ~= 0 and p2 ~= 1000 then
        Parent.BackgroundColor3 = Color3.fromRGB(147, 120, 255);
        TweenService:Create(Parent, u1, {
            Size = UDim2.new(p2 / 1000, 0, 0.9, 0)
        }):Play();

        return;
    end;

    if p2 ~= 0 then
        if p2 == 1000 then
            local v3 = TweenService:Create(Parent, u1, {
                Size = UDim2.new(0.98, 0, 0.9, 0)
            });
            Parent.BackgroundColor3 = Color3.new(1, 0.54902, 0.0313725);
            v3:Play();
        end;

        return;
    end;

    Parent.BackgroundColor3 = Color3.fromRGB(147, 120, 255);
    TweenService:Create(Parent, TweenInfo.new(Parent.Size.X.Scale * 10, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 0, 0.9, 0)
    }):Play();
end);