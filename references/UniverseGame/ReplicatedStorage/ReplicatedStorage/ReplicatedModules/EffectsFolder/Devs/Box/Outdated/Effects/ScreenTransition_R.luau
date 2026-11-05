  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local TweenService = game:GetService("TweenService");

return function(p2) -- Line: 7
    -- upvalues: LocalPlayer (copy), u1 (copy), TweenService (copy)
    local v3 = p2 or {};
    local State = v3.State;
    local v4 = v3.Color or Color3.fromRGB(255, 255, 255);
    local v5 = v3.Time or 0.5;
    local v6 = TweenInfo.new(v5, Enum.EasingStyle.Cubic);

    if LocalPlayer.PlayerGui:FindFirstChild("ScreenTransition") then
        local ScreenTransition = LocalPlayer.PlayerGui:FindFirstChild("ScreenTransition");
        local BlackScreen = ScreenTransition.BlackScreen;

        if State then
            TweenService:Create(BlackScreen, v6, {
                BackgroundTransparency = 0
            }):Play();
        else
            TweenService:Create(BlackScreen, v6, {
                BackgroundTransparency = 1
            }):Play();
        end;

        task.delay(v5, ScreenTransition.Destroy, ScreenTransition);

        return;
    end;

    local v7 = u1.BlackScreen:Clone();
    v7.Name = "ScreenTransition";
    v7.Parent = LocalPlayer:FindFirstChild("PlayerGui");
    local BlackScreen = v7.BlackScreen;
    BlackScreen.BackgroundColor3 = v4;

    if State then
        TweenService:Create(BlackScreen, v6, {
            BackgroundTransparency = 0
        }):Play();

        return;
    end;

    TweenService:Create(BlackScreen, v6, {
        BackgroundTransparency = 1
    }):Play();
end;