  

 

return function(p1) -- Line: 1
    local TweenService = game:GetService("TweenService");
    local Parent = script.Parent;
    local Trove = require(p1.KnitPath.Trove);
    local RegionAmbience = require(Parent.Assets.RegionAmbience);

    function p1.ShowRegionBanner(p2, u3) -- Line: 7
        -- upvalues: Trove (copy), Parent (copy), RegionAmbience (copy), TweenService (copy)
        local u4 = Trove.new();
        local u5 = Parent.Assets.Banner:Clone();
        u5.Visible = true;
        u5.Parent = Parent;
        u4:Add(u5);
        task.spawn(function() -- Line: 14
            -- upvalues: RegionAmbience (ref), u3 (copy), u4 (copy), TweenService (ref), u5 (copy)
            RegionAmbience:ChangeTo(u3.RegionName);
            local v6 = u4:Add(TweenService:Create(u5, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0, 0)
            }));
            v6:Play();
            v6.Completed:Wait();
            u4:Add(TweenService:Create(u5.LeftChevron, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.367, 0.077)
            })):Play();
            u4:Add(TweenService:Create(u5.RightChevron, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.582, 0.077)
            })):Play();
            u4:Add(TweenService:Create(u5.LeftBlocker, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(0, 0)
            })):Play();
            local v7 = u4:Add(TweenService:Create(u5.RightBlocker, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(0, 0)
            }));
            v7:Play();
            u4:Add(TweenService:Create(u5.LeftBlocker.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                Transparency = 1
            })):Play();
            u4:Add(TweenService:Create(u5.RightBlocker.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                Transparency = 1
            })):Play();
            local Size = u5.RegionBanner.MiddleSplitter.Size;
            u5.RegionBanner.Size = UDim2.fromScale(0, 0);
            u5.RegionBanner.MiddleSplitter.Size = UDim2.new(0, 0, 0, 0);

            for i, v in u3 do
                local v8 = u5.RegionBanner:FindFirstChild(i);

                if v8 then
                    v8.TextTransparency = 1;

                    if i == "RegionLevelRecommendation" then
                        v8.Text = `Recommended Level: {v}`;
                    elseif i == "RegionDescription" then
                        v8.Text = `"{v}"`;
                    else
                        v8.Text = v;
                    end;
                end;
            end;

            v7.Completed:Wait();
            local v9 = u4:Add(TweenService:Create(u5.RegionBanner, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(0.162, 0.065)
            }));
            v9:Play();
            v9.Completed:Wait();
            u4:Add(TweenService:Create(u5.RegionBanner.MiddleSplitter, TweenInfo.new(0.45, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = Size
            })):Play();

            for i, _ in u3 do
                local u10 = u5.RegionBanner:FindFirstChild(i);

                if u10 then
                    local Scale = u10.Position.Y.Scale;
                    local Scale2 = u10.Position.X.Scale;
                    u10.Position = UDim2.fromScale(Scale2, Scale + 0.05);
                    local v11 = math.clamp(u10.Position.Y.Scale, 0, 1) / 2;
                    task.delay(v11, function() -- Line: 101
                        -- upvalues: u4 (ref), TweenService (ref), u10 (copy), Scale2 (copy), Scale (copy)
                        u4:Add(TweenService:Create(u10, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            TextTransparency = 0,
                            MaxVisibleGraphemes = utf8.len(u10.Text),
                            Position = UDim2.fromScale(Scale2, Scale)
                        })):Play();
                    end);
                end;
            end;

            task.wait(2.5);
            local v12 = u4:Add(TweenService:Create(u5, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.fromScale(0, -0.2)
            }));
            v12:Play();
            v12.Completed:Wait();
            u4:Destroy();
        end);
    end;
end;