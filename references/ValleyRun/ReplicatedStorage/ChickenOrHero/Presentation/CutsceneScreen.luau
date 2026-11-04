 

 

local u1 = {};

local function overlay() -- Line: 8
    local ScreenPresentation = game:GetService("ReplicatedFirst"):FindFirstChild("ScreenPresentation");

    if ScreenPresentation then
        ScreenPresentation = ScreenPresentation:FindFirstChild("ScreenOverlay");
    end;

    if ScreenPresentation and ScreenPresentation:IsA("ScreenGui") then
        return ScreenPresentation;
    end;

    return nil;
end;

function u1.apply(p2) -- Line: 13
    local ScreenPresentation = game:GetService("ReplicatedFirst"):FindFirstChild("ScreenPresentation");

    if ScreenPresentation then
        ScreenPresentation = ScreenPresentation:FindFirstChild("ScreenOverlay");
    end;

    if not (ScreenPresentation and ScreenPresentation:IsA("ScreenGui")) then
        ScreenPresentation = nil;
    end;

    p2.IgnoreGuiInset = not ScreenPresentation and true or ScreenPresentation.IgnoreGuiInset;
    local v3;

    if ScreenPresentation then
        v3 = ScreenPresentation.ScreenInsets;
    else
        v3 = Enum.ScreenInsets.None;
    end;

    p2.ScreenInsets = v3;
    local v4;

    if ScreenPresentation then
        v4 = ScreenPresentation.ClipToDeviceSafeArea;
    else
        v4 = false;
    end;

    p2.ClipToDeviceSafeArea = v4;
    local v5;

    if ScreenPresentation then
        v5 = ScreenPresentation.SafeAreaCompatibility;
    else
        v5 = Enum.SafeAreaCompatibility.None;
    end;

    p2.SafeAreaCompatibility = v5;

    return p2;
end;

function u1.new(p6, p7) -- Line: 22
    -- upvalues: u1 (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = p6;
    ScreenGui.DisplayOrder = p7 or 0;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

    return u1.apply(ScreenGui);
end;

return table.freeze(u1);