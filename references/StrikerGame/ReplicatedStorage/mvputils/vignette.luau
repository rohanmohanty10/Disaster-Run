 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");

local function getPlayerGui() -- Line: 4
    -- upvalues: Players (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        return LocalPlayer:WaitForChild("PlayerGui");
    end;

    return nil;
end;

local function getVignetteGui() -- Line: 10
    -- upvalues: Players (copy)
    local LocalPlayer = Players.LocalPlayer;
    local v1;

    if LocalPlayer then
        v1 = LocalPlayer:WaitForChild("PlayerGui");
    else
        v1 = nil;
    end;

    if v1 then
        local Vignette = v1:FindFirstChild("Vignette");

        if not Vignette then
            Vignette = Instance.new("ScreenGui");
            Vignette.Name = "Vignette";
            Vignette.IgnoreGuiInset = true;
            Vignette.ResetOnSpawn = false;
            Vignette.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
            Vignette.Parent = v1;
        end;

        return Vignette;
    end;
end;

local function createVignetteImage() -- Line: 27
    -- upvalues: Players (copy)
    local LocalPlayer = Players.LocalPlayer;
    local v2;

    if LocalPlayer then
        v2 = LocalPlayer:WaitForChild("PlayerGui");
    else
        v2 = nil;
    end;

    local v3;

    if v2 then
        v3 = v2:FindFirstChild("Vignette");

        if not v3 then
            v3 = Instance.new("ScreenGui");
            v3.Name = "Vignette";
            v3.IgnoreGuiInset = true;
            v3.ResetOnSpawn = false;
            v3.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
            v3.Parent = v2;
        end;
    else
        v3 = nil;
    end;

    if v3 then
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "VignetteEffect";
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0);
        ImageLabel.Size = UDim2.new(1.5, 0, 1.5, 0);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = "rbxassetid://71848020138572";
        ImageLabel.ImageColor3 = Color3.new(0, 0, 0);
        ImageLabel.ImageTransparency = 1;
        ImageLabel.ZIndex = 10;
        ImageLabel.Parent = v3;

        return ImageLabel;
    end;
end;

return {
    Vignette = function(p4, p5: number, p6: number, p7: number, p8: number, p9: vector?, p10: number?) -- Line: 48, Name: Vignette
        -- upvalues: createVignetteImage (copy), TweenService (copy)
        if p9 and (p10 and p10 < (workspace.CurrentCamera.CFrame.Position - p9).Magnitude) then
            return;
        end;

        local v11 = p4 or Color3.new(0, 0, 0);
        local v12 = p5 or 0.3;
        local u13 = p7 or 0.3;
        local u14 = createVignetteImage();
        u14.ImageColor3 = v11;
        u14.ImageTransparency = 1;
        TweenService:Create(u14, TweenInfo.new(v12, Enum.EasingStyle.Quad), {
            ImageTransparency = p8 or 0.5
        }):Play();
        task.delay(v12 + (p6 or 1), function() -- Line: 69
            -- upvalues: TweenService (ref), u14 (copy), u13 (ref)
            local v15 = TweenService:Create(u14, TweenInfo.new(u13, Enum.EasingStyle.Quad), {
                ImageTransparency = 1
            });
            v15:Play();
            v15.Completed:Wait();
            u14:Destroy();
        end);
    end
};