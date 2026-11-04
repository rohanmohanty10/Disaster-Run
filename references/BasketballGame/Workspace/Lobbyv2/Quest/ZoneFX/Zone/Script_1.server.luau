 
 

wait(1);
local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1);
TweenService:Create(script.Parent, TweenInfo_new_ret, {
    Orientation = Vector3.new(0, 360, 0)
}):Play();