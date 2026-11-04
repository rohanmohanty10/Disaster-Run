 
 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");

return function(p1: userdata, u2: any, p3: any) -- Line: 5
    -- upvalues: TweenService (copy), RunService (copy), Debris (copy)
    local u4 = p1:Clone();
    u4.Parent = workspace.Effects;
    local v5 = p3 or u4.CFrame;

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
            local u6 = {
                Width0 = descendant.Width0,
                Width1 = descendant.Width1,
                TextureSpeed = descendant.TextureSpeed,
                Brightness = descendant.Brightness,
                LightEmission = descendant.LightEmission
            };
            local v7 = TweenService:Create(descendant, TweenInfo.new(u2.Duration, Enum.EasingStyle[u2.Easing], Enum.EasingDirection[u2.EasingDirection]), u2.Properties);
            v7:Play();
            v7.Completed:Once(function() -- Line: 33
                -- upvalues: descendant (copy), u6 (copy)
                descendant.Enabled = false;

                for i, v in u6 do
                    descendant[i] = v;
                end;
            end);
        end;
    end;

    TweenService:Create(u4, TweenInfo.new(u2.Duration, Enum.EasingStyle[u2.Easing], Enum.EasingDirection[u2.EasingDirection]), {
        Position = (v5 * u2.Offset).Position
    }):Play();
    local u8 = 0;
    local u9 = nil;
    u9 = RunService.Heartbeat:Connect(function(p10) -- Line: 52
        -- upvalues: u4 (copy), u2 (copy), u8 (ref), u9 (ref)
        local v11 = u4;
        v11.CFrame = v11.CFrame * CFrame.Angles(0, 0, (math.rad(u2.RotationSpeed)));
        u8 = u8 + p10;

        if u8 > 5 and u9 then
            u9:Disconnect();
        end;
    end);
    Debris:AddItem(u4, 5);

    return u4;
end;