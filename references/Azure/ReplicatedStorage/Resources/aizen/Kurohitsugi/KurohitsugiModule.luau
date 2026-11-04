 

 

return function(p1) -- Line: 1
    local TweenService = game:GetService("TweenService");
    local l_script = script;
    local script_VfxUtility = require(script.VfxUtility);
    local workspace_Effects = workspace.Effects;
    local Sine = Enum.EasingStyle.Sine;
    local Quad = Enum.EasingStyle.Quad;
    local Quad2 = Enum.EasingStyle.Quad;
    local TweenInfo_new_ret = TweenInfo.new(0.1, Enum.EasingStyle.Quart);
    local CFrame_new_ret = CFrame.new(0, 94, 0);
    local _ = Enum.EasingStyle.Quart;
    local u2 = false;
    local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Sine);
    local TweenInfo_new_ret3 = TweenInfo.new(0.2, Enum.EasingStyle.Linear);
    local TweenInfo_new_ret4 = TweenInfo.new(2.7, Enum.EasingStyle.Quad);
    local u3 = l_script.BoxReference:Clone();
    u3.Parent = workspace_Effects;
    u3:ScaleTo(2.35);
    u3:PivotTo(p1 * CFrame.new(0, u3:GetExtentsSize().Y / 2, 0));
    task.delay(10, function() -- Line: 21
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
    local GlowBorder = u3.GlowBorder;
    local Highlight = Instance.new("Highlight");
    Highlight.Name = "KuroHighlight";
    Highlight.Enabled = false;
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    Highlight.FillColor = Color3.fromRGB(120, 0, 255);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.fromRGB(200, 140, 255);
    Highlight.OutlineTransparency = 1;
    Highlight.Adornee = u3;
    Highlight.Parent = u3;
    task.delay(1.6500000000000001, function() -- Line: 38
        -- upvalues: GlowBorder (copy), Highlight (copy), TweenService (copy), script_VfxUtility (copy), u3 (copy), TweenInfo_new_ret2 (copy), CFrame_new_ret (copy), l_script (copy), workspace_Effects (copy), TweenInfo_new_ret (copy), u2 (ref)
        GlowBorder.Transparency = 0;
        GlowBorder.Color = Color3.fromRGB(155, 84, 255);
        Highlight.Enabled = true;
        TweenService:Create(Highlight, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
            OutlineTransparency = 0
        }):Play();
        script_VfxUtility.EmitParticles(u3.GlowBorder);
        TweenService:Create(GlowBorder, TweenInfo_new_ret2, {
            Color = Color3.fromRGB(100, 54, 163)
        }):Play();
        local u4 = false;

        for i = 1, (CFrame_new_ret and 1 or 0) + 7 do
            local u5 = l_script.KuroSword:Clone();
            u5.Parent = workspace_Effects;
            local v6 = CFrame.new(u3:GetPivot().Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            local CFrame_Angles = CFrame.Angles;
            local math_random_ret = math.random(-90, 90);
            local math_rad_ret = math.rad(math_random_ret);
            local math_random_ret2 = math.random(-90, 90);
            local math_rad_ret2 = math.rad(math_random_ret2);
            local math_random_ret3 = math.random(-90, 90);
            u5.CFrame = v6 * CFrame_Angles(math_rad_ret, math_rad_ret2, (math.rad(math_random_ret3))) * CFrame.new(0, 0, -math.random(30, 60) * 2.35);
            local v7;

            if u4 or not CFrame_new_ret then
                v7 = 1;
            else
                u5.CFrame = u3:GetPivot() * CFrame_new_ret;
                v7 = 1.5;
                u4 = true;
            end;

            u5.Size = u5.Size * (v7 * 2.35);
            local v8 = CFrame.new(u5.Position, u3:GetPivot().Position) * CFrame.Angles(1.5707963267948966, 0, 0);
            local CFrame_Angles2 = CFrame.Angles;
            local v9 = CFrame_new_ret and 90 or math.random(-180, 180);
            local u10 = l_script.KuroImpact:Clone();
            u5.CFrame = v8 * CFrame_Angles2(0, math.rad(v9), 0);
            u5.Transparency = 1;
            TweenService:Create(u5, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
                Transparency = 0
            }):Play();
            script_VfxUtility.ResizeParticle(u5, v7 * 2.35);
            script_VfxUtility.EmitParticles(u5);
            local TrailAtt = u5.TrailAtt;
            TrailAtt.Position = TrailAtt.Position * (v7 * 2.35);
            local TrailAtt1 = u5.TrailAtt1;
            TrailAtt1.Position = TrailAtt1.Position * (v7 * 2.35);
            u5.Trail.Enabled = true;
            task.delay(0.3, function() -- Line: 98
                -- upvalues: u5 (copy), u3 (ref), TweenService (ref), CFrame_new_ret (ref), u4 (ref), TweenInfo_new_ret (ref), u10 (copy), workspace_Effects (ref), script_VfxUtility (ref), u2 (ref)
                local u11 = u5.CFrame * CFrame.new(0, -58.75, 0);
                local RaycastParams_new_ret = RaycastParams.new();
                RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
                RaycastParams_new_ret.FilterDescendantsInstances = { u3 };
                local v12 = workspace:Raycast(u5.Position, CFrame.new(u5.Position, u3:GetPivot().Position).LookVector.Unit * 100 * 2.35, RaycastParams_new_ret);

                if v12 then
                    u11 = CFrame.new(v12.Position);
                end;

                local Magnitude = (u5.Position - u11.Position).Magnitude;
                local v13 = {};
                local v14 = CFrame.new(u5.Position, u3:GetPivot().Position) * CFrame.new(0, 0, -(Magnitude - u5.Size.Y * 0.2)) * CFrame.Angles(1.5707963267948966, 0, 0);
                local CFrame_Angles3 = CFrame.Angles;
                local v15 = CFrame_new_ret and u4 and 90 or math.random(-180, 180);
                v13.CFrame = v14 * CFrame_Angles3(0, math.rad(v15), 0);
                TweenService:Create(u5, TweenInfo_new_ret, v13):Play();
                task.delay(TweenInfo_new_ret.Time, function() -- Line: 119
                    -- upvalues: u10 (ref), u11 (ref), workspace_Effects (ref), script_VfxUtility (ref), u2 (ref), u5 (ref), TweenService (ref)
                    u10.CFrame = u11;
                    u10.Parent = workspace_Effects;
                    script_VfxUtility.ResizeParticle(u10, 2.35);
                    script_VfxUtility.EmitParticles(u10);
                    task.delay(5, function() -- Line: 125
                        -- upvalues: u10 (ref)
                        u10:Destroy();
                    end);
                    local v16 = os.clock() + 1.65 + 10;

                    repeat
                        task.wait();
                    until v16 < os.clock() or u2;

                    u5.Trail.Enabled = false;
                    local TweenInfo_new_ret5 = TweenInfo.new(math.random(100, 150) / 1000, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
                    TweenService:Create(u5, TweenInfo_new_ret5, {
                        Transparency = 1,
                        Size = Vector3.new(0, 0, 0),
                        Position = (CFrame.new(u5.Position) * CFrame.new(0, math.random(5, 20) * 2.35, 0)).Position
                    }):Play();
                    task.delay(TweenInfo_new_ret5.Time, function() -- Line: 144
                        -- upvalues: u5 (ref)
                        u5:Destroy();
                    end);
                end);
            end);
            task.wait(0.07857142857142858);
            local _ = i;
        end;
    end);
    task.delay(3.85, function() -- Line: 153
        -- upvalues: u2 (ref), TweenService (copy), Highlight (copy), GlowBorder (copy), TweenInfo_new_ret3 (copy), u3 (copy), script_VfxUtility (copy)
        u2 = true;
        TweenService:Create(Highlight, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
            OutlineTransparency = 1
        }):Play();
        task.delay(0.2, function() -- Line: 158
            -- upvalues: Highlight (ref)
            Highlight:Destroy();
        end);
        TweenService:Create(GlowBorder, TweenInfo_new_ret3, {
            Transparency = 1
        }):Play();
        TweenService:Create(u3.PlatformRoof, TweenInfo_new_ret3, {
            Size = Vector3.new(0, 0, 0)
        }):Play();
        TweenService:Create(u3.PlatformFloor, TweenInfo_new_ret3, {
            Size = Vector3.new(0, 0, 0)
        }):Play();
        script_VfxUtility.ResizeParticle(u3.GlowBorder, 1.3);
        script_VfxUtility.EmitParticles(u3.GlowBorder.Impact);
    end);

    for _, child in u3:GetChildren() do
        if child:IsA("BasePart") then
            local u17;

            if child.Name == "PlatformFloor" then
                local Size = child.Size;
                child.Size = Vector3.new(0, 0, 0);
                child.Transparency = 0;
                TweenService:Create(child, TweenInfo.new(0.25, Quad2), {
                    Size = Size
                }):Play();
                script_VfxUtility.EmitParticles(child);
                u17 = child;

                for _, descendant in child:GetDescendants() do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = true;
                        script_VfxUtility.TweenBeams(descendant, descendant.TextureSpeed, 0.5, TweenInfo_new_ret4);
                    end;
                end;
            else
                u17 = child;
            end;

            if u17.Name == "PlatformRoof" then
                local Size = u17.Size;
                u17.Size = Vector3.new(0, 0, 0);
                task.delay(1.6500000000000001, function() -- Line: 198
                    -- upvalues: u17 (copy), TweenService (copy), Quad (copy), Size (copy)
                    u17.Transparency = 0;
                    TweenService:Create(u17, TweenInfo.new(0.55, Quad), {
                        Size = Size
                    }):Play();
                end);
            end;

            if u17.Name == "Walll" then
                u17.Transparency = 1;

                for i = 1, 12 do
                    task.spawn(function() -- Line: 210
                        -- upvalues: u17 (copy), i (copy), Sine (copy), TweenService (copy), u2 (ref)
                        local v18 = u17:Clone();
                        v18.Parent = u17.Parent;
                        v18.Transparency = 0;
                        v18.Size = Vector3.new(u17.Size.X, u17.Size.Y / 20, u17.Size.Z / 12);
                        v18.CFrame = u17.CFrame * CFrame.new(0, -u17.Size.Y - u17.Size.Y / 20, -(u17.Size.Z / 2 + v18.Size.Z / 2)) * CFrame.new(0, 0, v18.Size.Z * i);
                        v18.Name = "WallSegment";
                        TweenService:Create(v18, TweenInfo.new(math.random(1200, 2200) / 1000, Sine, Enum.EasingDirection.Out), {
                            Size = Vector3.new(u17.Size.X, u17.Size.Y, u17.Size.Z / 12),
                            CFrame = v18.CFrame * CFrame.new(0, u17.Size.Y + u17.Size.Y / 20, 0)
                        }):Play();

                        repeat
                            task.wait();
                        until u2;

                        TweenService:Create(v18, TweenInfo.new(math.random(100, 150) / 1000, Sine, Enum.EasingDirection.Out), {
                            Transparency = 1
                        }):Play();
                    end);
                    local _ = i;
                end;
            end;
        end;
    end;
end;