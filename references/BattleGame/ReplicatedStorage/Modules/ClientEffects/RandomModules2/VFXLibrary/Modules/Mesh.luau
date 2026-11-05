 

local u1 = {};
u1.__index = u1;
local l__TweenService__1 = game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local l__Debris__3 = game:GetService("Debris");
require(script.Types);
local function u7(u2, u3, p4) --[[ Line: 33 ]]
    -- upvalues: l__RunService__2 (copy)
    local u6 = l__RunService__2.Heartbeat:Connect(function(_) --[[ Line: 36 ]]
        -- upvalues: u2 (copy), u3 (copy)
        local v5 = u2;
        v5.CFrame = v5.CFrame * CFrame.Angles(0, math.rad(u3), 0);
    end);
    task.delay(p4, function() --[[ Line: 39 ]]
        -- upvalues: u6 (copy)
        u6:Disconnect();
    end);
end;
local function u11(p8) --[[ Line: 52 ]]
    local v9 = {};
    if (p8:IsA("Part") and p8:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh") == "SpecialMesh" then
        local v10 = p8:FindFirstChildOfClass("SpecialMesh");
        if not v10 then
            return {};
        end;
        v9.Scale = v10.Scale;
    else
        v9.Size = p8.Size;
    end;
    v9.Position = p8.CFrame.Position;
    return v9;
end;
function u1.new(p12) --[[ Line: 67 ]]
    -- upvalues: u11 (copy), u1 (copy)
    local v13 = {
        Model = p12,
        Type = p12.Start:IsA("Part") and p12.Start:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh",
        Properities = u11(p12.Start),
        EndProperities = u11(p12.End),
        Settings = p12:GetAttributes()
    };
    return setmetatable(v13, u1);
end;
function u1.SetFlipbook(p14, p15) --[[ Line: 78 ]]
    p14.__Flipbook = require(p15);
end;
function u1.RandomizeSize(p16, p17, p18) --[[ Line: 82 ]]
    if p16.Type == "SpecialMesh" then
        local l__EndProperities__4 = p16.EndProperities;
        local v19 = math.random(p17.X, p18.X);
        local v20 = math.random(p17.Y, p18.Y);
        l__EndProperities__4.Scale = Vector3.new(v19, v20, math.random(p17.Z, p18.Z));
    else
        local l__EndProperities__5 = p16.EndProperities;
        local v21 = math.random(p17.X, p18.X);
        local v22 = math.random(p17.Y, p18.Y);
        l__EndProperities__5.Size = Vector3.new(v21, v22, math.random(p17.Z, p18.Z));
    end;
end;
function u1.PlayFlipbook(u23, u24) --[[ Line: 90 ]]
    -- upvalues: l__RunService__2 (copy)
    local l____Flipbook__6 = u23.__Flipbook;
    if l____Flipbook__6 then
        local u25 = 1;
        local u26 = 0;
        local u27 = nil;
        u27 = l__RunService__2.Heartbeat:Connect(function(p28) --[[ Line: 96 ]]
            -- upvalues: u26 (ref), u23 (copy), u25 (ref), l____Flipbook__6 (copy), u27 (ref), u24 (copy)
            u26 = u26 + p28;
            if u26 >= 1 / (u23.Settings.FlipbookRate or 0.016666666666666666) then
                u25 = u25 + 1;
                if u25 > #l____Flipbook__6 then
                    u27:Disconnect();
                    return;
                end;
                if u23.Type == "SpecialMesh" then
                    local v29 = u24:FindFirstChildOfClass("Decal");
                    if not v29 then
                        return;
                    end;
                    v29.Texture = l____Flipbook__6[u25];
                else
                    u24.TextureId = l____Flipbook__6[u25];
                end;
                u26 = 0;
            end;
        end);
    end;
end;
function u1.Emit(u30, p31) --[[ Line: 115 ]]
    -- upvalues: l__Debris__3 (copy), u7 (copy), l__TweenService__1 (copy)
    local l__Lifetime__7 = u30.Settings.Lifetime;
    local v32 = Enum.EasingStyle[u30.Settings.EasingStyle];
    local v33 = Enum.EasingDirection[u30.Settings.EasingDirection];
    local v34 = u30.Settings.Transparency or 1;
    local v35 = u30.Settings.StartTransparency or 1;
    local l__RotationX__8 = u30.Settings.RotationX;
    local v36 = not l__RotationX__8 and 0 or math.random(l__RotationX__8.Min, l__RotationX__8.Max);
    local l__RotationY__9 = u30.Settings.RotationY;
    local v37 = not l__RotationY__9 and 0 or math.random(l__RotationY__9.Min, l__RotationY__9.Max);
    local l__RotationZ__10 = u30.Settings.RotationZ;
    local v38 = not l__RotationZ__10 and 0 or math.random(l__RotationZ__10.Min, l__RotationZ__10.Max);
    local v39 = TweenInfo.new(l__Lifetime__7, v32, v33);
    local u40 = u30.Model.Start:Clone();
    u30:PlayFlipbook(u40);
    u40.CFrame = (typeof(p31) == "CFrame" and p31 and p31 or p31.CFrame) * CFrame.Angles(math.rad(v36), math.rad(v37), (math.rad(v38)));
    u40.Parent = workspace.World.Visuals;
    l__Debris__3:AddItem(u40, l__Lifetime__7);
    local v41 = u30.Model.Start.CFrame:ToObjectSpace(u30.Model.End.CFrame);
    u30.EndProperities.Position = nil;
    if u30.Settings.RotationSpeed then
        u7(u40, u30.Settings.RotationSpeed, l__Lifetime__7);
    end;
    if u30.Type == "SpecialMesh" then
        local u42 = u40:FindFirstChildOfClass("SpecialMesh");
        local v43 = u40:FindFirstChildOfClass("Decal");
        if u42 then
            local v44 = l__TweenService__1:Create(u42, v39, u30.EndProperities);
            local v45 = l__TweenService__1:Create(u40, v39, {
                CFrame = u40.CFrame * v41
            });
            v44:Play();
            v45:Play();
            v44.Completed:Once(function() --[[ Line: 154 ]]
                -- upvalues: u42 (copy), u30 (copy), u40 (copy)
                u42.Scale = u30.Properities.Scale or Vector3.new(1, 1, 1);
                u40.Transparency = 1;
            end);
        end;
        if v43 then
            v43.Transparency = v35;
            l__TweenService__1:Create(v43, TweenInfo.new(l__Lifetime__7, Enum.EasingStyle[u30.Settings.TransparencyEasingStyle], Enum.EasingDirection[u30.Settings.TransparencyEasingDirection]), {
                Transparency = v34,
                Color3 = u30.Model.End:FindFirstChildOfClass("Decal").Color3
            }):Play();
        end;
    else
        u40.Transparency = v35;
        TweenInfo.new(l__Lifetime__7, Enum.EasingStyle[u30.Settings.TransparencyEasingStyle], Enum.EasingDirection[u30.Settings.TransparencyEasingDirection]);
        if u30.Settings.Movement then
            u30.EndProperities.CFrame = u40.CFrame * v41;
        end;
        u30.EndProperities.Transparency = v34;
        local v46 = l__TweenService__1:Create(u40, v39, u30.EndProperities);
        v46:Play();
        v46.Completed:Once(function() --[[ Line: 177 ]]
            -- upvalues: u40 (copy), u30 (copy)
            u40.Size = u30.Properities.Size or Vector3.new(1, 1, 1);
            u40.Transparency = 1;
        end);
    end;
end;
function u1.EmitRate(u47, u48, p49, u50) --[[ Line: 184 ]]
    -- upvalues: l__RunService__2 (copy)
    local u51 = 0;
    local u53 = l__RunService__2.Heartbeat:Connect(function(p52) --[[ Line: 186 ]]
        -- upvalues: u51 (ref), u48 (copy), u47 (copy), u50 (copy)
        u51 = u51 + p52;
        if u51 > u48 / 60 then
            u51 = 0;
            u47:Emit(u50);
        end;
    end);
    task.delay(p49, function() --[[ Line: 193 ]]
        -- upvalues: u53 (copy)
        u53:Disconnect();
    end);
end;
function u1.emit(p54, p55) --[[ Line: 199 ]]
    -- upvalues: u1 (copy)
    local v56 = p54:GetAttribute("Offset");
    if typeof(p55) == "CFrame" then
        p55 = p55 * CFrame.new(v56 or Vector3.new()) or p55;
    end;
    local v57 = u1.new(p54);
    v57:Emit(p55);
    return v57;
end;
function u1.enable(p58, p59) --[[ Line: 207 ]]
    -- upvalues: u1 (copy)
    local v60 = p58:GetAttribute("Offset");
    if typeof(p59) == "CFrame" then
        p59 = p59 * CFrame.new(v60 or Vector3.new()) or p59;
    end;
    local v61 = u1.new(p58);
    v61:Emit(p59);
    return v61;
end;
return u1;