  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);

return function(p1) -- Line: 21
    -- upvalues: TableUtil (copy), TweenService (copy), LocalPlayer (copy)
    local v2 = TableUtil.Reconcile(p1 or {}, {
        LifeTime = 0.3,
        Transparency = 0.5,
        TweenIn = { 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
        TweenOut = { 0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut },
        Size = UDim2.fromScale(1, 1),
        Color = Color3.new(1)
    });
    local v3 = script.Vignette:Clone();
    v3.Image.ImageColor3 = v2.Color;
    v3.Image.ImageTransparency = 1;
    v3.Image.Size = v2.Size;
    v3.Image.Visible = true;
    TweenService:Create(v3.Image, TweenInfo.new(unpack(v2.TweenIn)), {
        ImageTransparency = v2.Transparency
    }):Play();
    v3.Parent = LocalPlayer.PlayerGui;
    task.wait(v2.LifeTime);
    local Image = v3.Image;
    local v4 = TweenInfo.new(unpack(v2.TweenOut));
    local v5 = {
        ImageTransparency = 1
    };
    local v6;

    if v2.Color2 then
        v6 = v2.Color2;
    else
        v6 = nil;
    end;

    v5.ImageColor3 = v6;
    TweenService:Create(Image, v4, v5):Play();
    task.delay(v2.TweenOut[1] + 0.1, v3.Destroy, v3);
    table.clear(v2);
    table.freeze({});
end;