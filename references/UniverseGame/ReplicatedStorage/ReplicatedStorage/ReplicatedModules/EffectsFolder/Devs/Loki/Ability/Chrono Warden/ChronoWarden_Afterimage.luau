  

 

local Petal = _G.Petal;
local Players = game:GetService("Players");
game:GetService("CollectionService");
local _ = Players.LocalPlayer;
local u1 = Petal("New");
local u2 = Petal("Util");
local _ = u2.Tween;
local _ = Instance.new;
local _ = Vector3.new;
local _ = CFrame.new;
local _ = CFrame.Angles;

local function TitleCase(p3) -- Line: 13
    return p3:gsub("(%l)(%w*)", function(p4, p5) -- Line: 14
        return string.upper(p4) .. p5;
    end);
end;

return function(u6, u7) -- Line: 17
    -- upvalues: u2 (copy), TitleCase (copy), u1 (copy)
    local u8 = script.Duplicate:Clone();
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(128, 196, 255);
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = u8;
    local PrimaryPart = u8.PrimaryPart;
    local HumanoidRootPart = u6.HumanoidRootPart;
    local Lifetime = u7.Lifetime;
    local TransitionTime = u7.TransitionTime;
    local Offset = u7.Offset;
    local u9 = u7.SetCF or nil;
    local u10 = u7.DoesAnimate == nil and true or u7.DoesAnimate;
    local u11 = u7.AnimationInterpolation or 0.95;
    local v12 = u7.CheckVelocity or false;
    local Halo = u6:FindFirstChild("Halo");
    local u13;

    if Halo then
        u13 = Halo.Inner.Color;
    else
        u13 = nil;
    end;

    if v12 and HumanoidRootPart.Velocity.Magnitude < v12 then
        return;
    end;

    PrimaryPart.CFrame = u9 or HumanoidRootPart.CFrame;
    task.spawn(function() -- Line: 47
        -- upvalues: u13 (ref), u8 (copy), u2 (ref), u6 (copy), TitleCase (ref), HumanoidRootPart (copy), PrimaryPart (copy), u10 (copy), u1 (ref), Lifetime (copy), u11 (copy), TransitionTime (copy)
        if u13 then
            u8.Highlight.FillColor = u13;
        end;

        u2.Tween(u8.Highlight, 0.25, "Quad", "InOut", {
            FillTransparency = 0.725,
            OutlineTransparency = 0
        });

        for _, child in u8:GetChildren() do
            if child:IsA("BasePart") and child.Name ~= "invis" then
                local v14 = u6:FindFirstChild(TitleCase(child.Name));

                if v14 then
                    if u13 then
                        child.Color = u13;
                    end;

                    local v15 = v14.CFrame:ToObjectSpace(HumanoidRootPart.CFrame):Inverse();
                    child.Size = child.Size * 1.025;
                    child.CFrame = PrimaryPart.CFrame * v15;

                    if not u10 then
                        if child.Name ~= "root" then
                            child.Anchored = false;
                        end;

                        u1("Weld")({
                            C0 = v15,
                            Part0 = PrimaryPart,
                            Part1 = child,
                            Parent = PrimaryPart,
                            Name = child.Name
                        });
                    end;
                end;
            end;
        end;

        if u10 then
            local v16 = os.clock() + Lifetime;

            repeat
                for _, child in u8:GetChildren() do
                    if child:IsA("BasePart") and child.Name ~= "invis" then
                        local v17 = u6:FindFirstChild(TitleCase(child.Name));

                        if v17 then
                            child.CFrame = child.CFrame:Lerp(PrimaryPart.CFrame * v17.CFrame:ToObjectSpace(HumanoidRootPart.CFrame):Inverse(), u11);
                        end;
                    end;
                end;

                task.wait();
            until os.clock() > v16 + TransitionTime * 2.5;
        else
            task.wait(Lifetime + TransitionTime * 2.5);
        end;

        u8:Destroy();
    end);
    task.spawn(function() -- Line: 101
        -- upvalues: u7 (copy), u2 (ref), PrimaryPart (copy), TransitionTime (copy), u9 (copy), HumanoidRootPart (copy), Offset (copy), Lifetime (copy), u8 (copy)
        if not u7.TwoWay then
            local Tween = u2.Tween;
            local v18 = {};
            local v19;

            if u9 then
                v19 = u9 * Offset;
            else
                v19 = HumanoidRootPart.CFrame * Offset;
            end;

            v18.CFrame = v19;
            Tween(PrimaryPart, TransitionTime * 2, "Quad", "InOut", v18);
            task.wait(Lifetime + TransitionTime);
            u2.Tween(u8.Highlight, TransitionTime, "Quad", "InOut", {
                FillTransparency = 1,
                OutlineTransparency = 1
            });

            return;
        end;

        local Tween = u2.Tween;
        local v20 = {};
        local v21;

        if u9 then
            v21 = u9;
        else
            v21 = HumanoidRootPart.CFrame * Offset;
        end;

        v20.CFrame = v21;
        Tween(PrimaryPart, TransitionTime, "Quad", "InOut", v20);
        task.wait(Lifetime + TransitionTime);
        local Tween2 = u2.Tween;
        local v22 = {};
        local v23;

        if u9 then
            v23 = u9;
        else
            v23 = HumanoidRootPart.CFrame;
        end;

        v22.CFrame = v23;
        Tween2(PrimaryPart, TransitionTime, "Quad", "InOut", v22);
        u2.Tween(u8.Highlight, TransitionTime, "Quad", "InOut", {
            FillTransparency = 1,
            OutlineTransparency = 1
        });
    end);
    u8.Parent = workspace.Effects;
end;