 

local u1 = {};
u1.__index = u1;
local l__TweenService__1 = game:GetService("TweenService");
local l__RunService__2 = game:GetService("RunService");
local l__Debris__3 = game:GetService("Debris");
require(script.Types);
local function u7(u2, u3, p4) --[[ Line: 34 ]]
    -- upvalues: l__RunService__2 (copy)
    local u6 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 35 ]]
        -- upvalues: u2 (copy), u3 (copy)
        local v5 = u2;
        v5.CFrame = v5.CFrame * CFrame.Angles(0, math.rad(u3), 0);
    end);
    task.delay(p4, function() --[[ Line: 38 ]]
        -- upvalues: u6 (copy)
        u6:Disconnect();
    end);
end;
local function u11(p8) --[[ Line: 48 ]]
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
function u1.new(p12) --[[ Line: 63 ]]
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
function u1.SetFlipbook(p14, p15) --[[ Line: 74 ]]
    p14.__Flipbook = require(p15);
end;
function u1.RandomizeSize(p16, p17, p18) --[[ Line: 78 ]]
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
function u1.PlayFlipbook(u23, u24) --[[ Line: 94 ]]
    -- upvalues: l__RunService__2 (copy)
    local l____Flipbook__6 = u23.__Flipbook;
    if l____Flipbook__6 then
        local u25 = 1;
        local u26 = 0;
        local u27 = nil;
        local u28 = 1 / (u23.Settings and (u23.Settings.FlipbookRate or 60) or 60);
        local _ = l__RunService__2.Heartbeat:Connect(function(p29) --[[ Line: 105 ]]
            -- upvalues: u26 (ref), u28 (copy), u25 (ref), l____Flipbook__6 (copy), u27 (ref), u23 (copy), u24 (copy)
            u26 = u26 + p29;
            if u28 <= u26 then
                u25 = u25 + 1;
                if u25 > #l____Flipbook__6 then
                    u27:Disconnect();
                    return;
                end;
                if u23.Type == "SpecialMesh" then
                    local v30 = u24:FindFirstChildOfClass("Decal");
                    if not v30 then
                        return;
                    end;
                    v30.Texture = l____Flipbook__6[u25];
                else
                    u24.TextureId = l____Flipbook__6[u25];
                end;
                u26 = 0;
            end;
        end);
    end;
end;
function u1.Emit(u31, p32) --[[ Line: 138 ]]
    -- upvalues: l__Debris__3 (copy), u7 (copy), l__TweenService__1 (copy)
    local l__Lifetime__7 = u31.Settings.Lifetime;
    local v33 = Enum.EasingStyle[u31.Settings.EasingStyle];
    local v34 = Enum.EasingDirection[u31.Settings.EasingDirection];
    local v35 = u31.Settings.Transparency or 1;
    local v36 = u31.Settings.StartTransparency or 1;
    local l__RotationX__8 = u31.Settings.RotationX;
    local v37 = not l__RotationX__8 and 0 or math.random(l__RotationX__8.Min, l__RotationX__8.Max);
    local l__RotationY__9 = u31.Settings.RotationY;
    local v38 = not l__RotationY__9 and 0 or math.random(l__RotationY__9.Min, l__RotationY__9.Max);
    local l__RotationZ__10 = u31.Settings.RotationZ;
    local v39 = not l__RotationZ__10 and 0 or math.random(l__RotationZ__10.Min, l__RotationZ__10.Max);
    local v40 = TweenInfo.new(l__Lifetime__7, v33, v34);
    local u41 = u31.Model.Start:Clone();
    u31:PlayFlipbook(u41);
    local l__Model__11 = u31.Model;
    local v42 = typeof(p32) == "CFrame" and p32 and p32 or p32.CFrame;
    if l__Model__11 then
        local v43 = l__Model__11:GetAttribute("Offset");
        if typeof(v43) == "Vector3" then
            v42 = v42 * CFrame.new(v43);
        end;
    end;
    u41.CFrame = v42 * CFrame.Angles(math.rad(v37), math.rad(v38), (math.rad(v39)));
    u41.Parent = workspace.World.Visuals or workspace;
    l__Debris__3:AddItem(u41, l__Lifetime__7);
    local v44 = u31.Model.Start.CFrame:ToObjectSpace(u31.Model.End.CFrame);
    u31.EndProperities.Position = nil;
    if u31.Settings.RotationSpeed then
        u7(u41, u31.Settings.RotationSpeed, l__Lifetime__7);
    end;
    if u31.Type == "SpecialMesh" then
        local u45 = u41:FindFirstChildOfClass("SpecialMesh");
        local v46 = u41:FindFirstChildOfClass("Decal");
        if u45 then
            local v47 = l__TweenService__1:Create(u45, v40, u31.EndProperities);
            local v48 = l__TweenService__1:Create(u41, v40, {
                CFrame = u41.CFrame * v44
            });
            v47:Play();
            v48:Play();
            v47.Completed:Once(function() --[[ Line: 175 ]]
                -- upvalues: u45 (copy), u31 (copy), u41 (copy)
                u45.Scale = u31.Properities.Scale or Vector3.new(1, 1, 1);
                u41.Transparency = 1;
            end);
        end;
        if v46 then
            v46.Transparency = v36;
            local v49 = TweenInfo.new(l__Lifetime__7, Enum.EasingStyle[u31.Settings.TransparencyEasingStyle], Enum.EasingDirection[u31.Settings.TransparencyEasingDirection]);
            local v50 = u31.Model.End:FindFirstChildOfClass("Decal");
            local v51 = {
                Transparency = v35
            };
            if v50 then
                v51.Color3 = v50.Color3;
            end;
            l__TweenService__1:Create(v46, v49, v51):Play();
        end;
    else
        u41.Transparency = v36;
        TweenInfo.new(l__Lifetime__7, Enum.EasingStyle[u31.Settings.TransparencyEasingStyle], Enum.EasingDirection[u31.Settings.TransparencyEasingDirection]);
        if u31.Settings.Movement then
            u31.EndProperities.CFrame = u41.CFrame * v44;
        end;
        u31.EndProperities.Transparency = v35;
        local v52 = l__TweenService__1:Create(u41, v40, u31.EndProperities);
        v52:Play();
        v52.Completed:Once(function() --[[ Line: 206 ]]
            -- upvalues: u41 (copy), u31 (copy)
            u41.Size = u31.Properities.Size or Vector3.new(1, 1, 1);
            u41.Transparency = 1;
        end);
    end;
end;
function u1.EmitRate(u53, p54, p55, u56) --[[ Line: 213 ]]
    -- upvalues: l__RunService__2 (copy)
    local u57 = p54 > 0 and 1 / p54 or (1 / 0);
    local u58 = 0;
    local u60 = l__RunService__2.Heartbeat:Connect(function(p59) --[[ Line: 216 ]]
        -- upvalues: u58 (ref), u57 (copy), u53 (copy), u56 (copy)
        u58 = u58 + p59;
        if u57 <= u58 then
            u58 = 0;
            u53:Emit(u56);
        end;
    end);
    task.delay(p55, function() --[[ Line: 223 ]]
        -- upvalues: u60 (copy)
        u60:Disconnect();
    end);
end;
function u1.EmitAt(p61, p62) --[[ Line: 229 ]]
    -- upvalues: u1 (copy)
    local v63 = u1.new(p62);
    local v64 = typeof(p61) == "CFrame" and p61 and p61 or p61.CFrame;
    if p62 then
        local v65 = p62:GetAttribute("Offset");
        if typeof(v65) == "Vector3" then
            v64 = v64 * CFrame.new(v65);
        end;
    end;
    v63:Emit(v64);
end;
function u1.EnableAt(p66, p67, p68, p69) --[[ Line: 234 ]]
    -- upvalues: u1 (copy)
    local v70 = u1.new(p68);
    local v71 = typeof(p69) == "CFrame" and p69 and p69 or p69.CFrame;
    if p68 then
        local v72 = p68:GetAttribute("Offset");
        if typeof(v72) == "Vector3" then
            v71 = v71 * CFrame.new(v72);
        end;
    end;
    v70:EmitRate(p66, p67, v71);
end;
return u1;