  

 

local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");

return function(p1, p2, u3) -- Line: 4
    -- upvalues: Lighting (copy), TweenService (copy)
    local v4 = p2 or Color3.fromRGB(255, 255, 255);
    local Atmosphere = Lighting.Atmosphere;
    local DefaultBloom = Lighting.DefaultBloom;
    local DefaultSunRays = Lighting.DefaultSunRays;
    local Intensity = DefaultBloom.Intensity;
    local Intensity2 = DefaultSunRays.Intensity;
    local Density = Atmosphere.Density;
    local Haze = Atmosphere.Haze;
    local Glare = Atmosphere.Glare;
    local Color = Atmosphere.Color;
    DefaultBloom.Intensity = 5;
    DefaultSunRays.Intensity = 1;
    Atmosphere.Density = 0.6;
    Atmosphere.Haze = 4;
    Atmosphere.Glare = 1;
    Atmosphere.Color = v4;
    task.delay(p1 or 1, function() -- Line: 27
        -- upvalues: u3 (copy), TweenService (ref), DefaultBloom (copy), Intensity (copy), DefaultSunRays (copy), Intensity2 (copy), Atmosphere (copy), Haze (copy), Glare (copy), Color (copy), Density (copy)
        if u3 then
            TweenService:Create(DefaultBloom, TweenInfo.new(0.1), {
                Intensity = Intensity
            }):Play();
            TweenService:Create(DefaultSunRays, TweenInfo.new(0.1), {
                Intensity = Intensity2
            }):Play();
            TweenService:Create(Atmosphere, TweenInfo.new(0.1), {
                Haze = Haze
            }):Play();
            TweenService:Create(Atmosphere, TweenInfo.new(0.1), {
                Glare = Glare
            }):Play();
            TweenService:Create(Atmosphere, TweenInfo.new(0.1), {
                Color = Color
            }):Play();

            return;
        end;

        DefaultBloom.Intensity = Intensity;
        DefaultSunRays.Intensity = Intensity2;
        Atmosphere.Density = Density;
        Atmosphere.Haze = Haze;
        Atmosphere.Glare = Glare;
        Atmosphere.Color = Color;
    end);
end;