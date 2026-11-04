 

 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");

return function(p1: userdata, p2, p3: number?, p4: number?, p5: number?, p6: number?) -- Line: 4
    -- upvalues: TweenService (copy), Debris (copy)
    local v7 = p3 or 1;
    local PointLight = Instance.new("PointLight");
    PointLight.Enabled = true;
    PointLight.Color = p2 or Color3.fromRGB(105, 195, 255);
    PointLight.Range = p4 or 10;
    PointLight.Brightness = p6 or 2;
    PointLight.Parent = p1;
    TweenService:Create(PointLight, TweenInfo.new(v7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Brightness = 0,
        Range = p5 or (p4 or 10) * 1.5
    }):Play();
    Debris:AddItem(PointLight, v7);

    return PointLight;
end;