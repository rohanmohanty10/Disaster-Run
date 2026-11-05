  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local random = math.random;
local wrap = coroutine.wrap;
local TweenService = game:GetService("TweenService");

local function tweendeb(p2, p3) -- Line: 6
    p2:Play();
    p2.Completed:Wait();

    if p3 then
        p3:Destroy();
    end;

    return true;
end;

return function(p4, p5, p6) -- Line: 13
    -- upvalues: u1 (copy), random (copy), wrap (copy), TweenService (copy)
    local cube = u1.STWR.cube;
    local Color = p6.Color;
    local Amount = p6.Amount;
    local Size = p6.Size;
    local Offset = p6.Offset;
    local Tween = p6.Tween;

    for _, v in ipairs(p5) do
        if v.Values.Block.Value == "None" then
            local CFrame2 = v.PrimaryPart.CFrame;
            local v7 = CFrame.new(p4.Position, CFrame2.Position);
            local Magnitude = (CFrame2.Position - p4.Position).Magnitude;
            local v8 = nil;

            for i = 1, Amount do
                local v9 = Offset == 0 and 0 or (random(-Offset, Offset) or 0);
                local v10 = Offset == 0 and 0 or (random(-Offset, Offset) or 0);
                local u11 = cube:Clone();
                u11.Color = Color;
                u11.Size = u11.Size * Size;
                u11.CFrame = i == 1 and p4 and p4 or v7 * CFrame.new((i == Amount or not v10) and 0 or v10, (i == Amount or not v9) and 0 or v9, -Magnitude / Amount * i);
                u11.Transparency = 0;

                if v8 then
                    v8.CFrame = CFrame.new(v8.Position, u11.Position);
                    v8.Size = Vector3.new(v8.Size.X, v8.Size.Y, (v8.Position - u11.Position).Magnitude);
                    v8.CFrame = v8.CFrame * CFrame.new(0, 0, -v8.Size.Z / 2);
                end;

                u11.Parent = workspace.Effects;
                wrap(function() -- Line: 37
                    -- upvalues: TweenService (ref), u11 (copy), Tween (copy)
                    local v12 = TweenService:Create(u11, TweenInfo.new(unpack(Tween[1])), {
                        Transparency = 0
                    });
                    v12:Play();
                    v12.Completed:Wait();
                    local v13 = TweenService:Create(u11, TweenInfo.new(unpack(Tween[2])), {
                        Transparency = 1
                    });
                    local v14 = u11;
                    v13:Play();
                    v13.Completed:Wait();

                    if v14 then
                        v14:Destroy();
                    end;
                end)();
                v8 = u11;
            end;
        end;
    end;
end;