 
-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__Debris__2 = game:GetService("Debris");
local function u5(p1, p2, p3) --[[ Line: 5 ]]
    if typeof(p1) == "EnumItem" then
        return p1;
    end;
    if typeof(p1) == "string" then
        for _, v4 in ipairs(p2:GetEnumItems()) do
            if v4.Name:lower() == p1:lower() then
                return v4;
            end;
        end;
    end;
    return p3;
end;
return {
    Spawn = function(p6, p7, p8) --[[ Name: Spawn, Line 17 ]]
        -- upvalues: u5 (copy), l__TweenService__1 (copy), l__Debris__2 (copy)
        local v9 = p6:Clone();
        v9.Parent = workspace:FindFirstChild("VFX") or workspace;
        local v10 = p7 and p7.Offset or CFrame.new();
        local v11 = p8 or v9:IsA("BasePart") and v9.CFrame or (v9.PrimaryPart and v9.PrimaryPart.CFrame or CFrame.new());
        local v12 = p7 and (tonumber(p7.Duration) or 1) or 1;
        local v13 = u5;
        local v14;
        if p7 then
            v14 = p7.Easing or p7.EasingStyle;
        else
            v14 = p7;
        end;
        local v15 = v13(v14, Enum.EasingStyle, Enum.EasingStyle.Sine);
        local v16 = u5;
        local v17;
        if p7 then
            v17 = p7.EasingDirection;
        else
            v17 = p7;
        end;
        local v18 = v16(v17, Enum.EasingDirection, Enum.EasingDirection.Out);
        local v19 = TweenInfo.new(v12, v15, v18);
        local v20 = p7 and (p7.BeamProperties or (p7.Properties or {})) or {};
        if v9:IsA("BasePart") then
            v9.CFrame = v11;
        elseif v9.PrimaryPart then
            v9:SetPrimaryPartCFrame(v11);
        end;
        if v10 ~= CFrame.new() then
            local l__Position__3 = (v11 * v10).Position;
            local v21 = v9:IsA("BasePart") and v9 and v9 or v9.PrimaryPart;
            if v21 then
                l__TweenService__1:Create(v21, v19, {
                    Position = l__Position__3
                }):Play();
            end;
        end;
        for _, u22 in ipairs(v9:GetDescendants()) do
            if u22:IsA("Beam") then
                local u23 = {
                    Width0 = u22.Width0,
                    Width1 = u22.Width1,
                    TextureSpeed = u22.TextureSpeed,
                    Brightness = u22.Brightness,
                    LightEmission = u22.LightEmission
                };
                u22.Enabled = true;
                local v24 = l__TweenService__1:Create(u22, v19, v20);
                v24:Play();
                v24.Completed:Once(function() --[[ Line: 55 ]]
                    -- upvalues: u22 (copy), u23 (copy)
                    u22.Enabled = false;
                    for v25, v26 in pairs(u23) do
                        u22[v25] = v26;
                    end;
                end);
            end;
        end;
        l__Debris__2:AddItem(v9, p7 and tonumber(p7.Lifespan) or v12 + 1);
        return {
            Instance = v9
        };
    end
};