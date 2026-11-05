 

 

if #game:GetService("ServerStorage"):GetChildren() <= 0 then
    local v1 = Color3.new(1, 1, 1);
    local v2 = NumberSequence.new(10);
    local v3 = NumberRange.new(0.8);
    local v4 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 5.33, 2.75), NumberSequenceKeypoint.new(1, 5.33, 2.75) });
    local v5 = NumberRange.new(0.8);
    local v6 = NumberRange.new(0, 360);
    local v7 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4, 3), NumberSequenceKeypoint.new(1, 0) });
    local v8 = NumberRange.new(0.1, 0.15);
    local v9 = NumberRange.new(0, 360);
    local v10 = Vector2.new(10, 10);
    local u11 = {
        None = 0,
        Whitelist = 1,
        Blacklist = 2,
        Function = 3
    };
    local l__Players__1 = game:GetService("Players");
    local l__TweenService__2 = game:GetService("TweenService");
    local l__RunService__3 = game:GetService("RunService");
    local u12 = Instance.new("NumberValue");
    u12.Value = 1;
    local l__None__4 = u11.None;
    local l__new__5 = Vector3.new;
    local u13 = NumberSequenceKeypoint.new(0, 1, 0);
    local u14 = NumberSequenceKeypoint.new(1, 1, 0);
    local u15 = {};
    local u16 = 0;
    local u17 = 0;
    local u18 = Vector3.new(0, -1, 0);
    local u19 = nil;
    local u20 = true;
    local u21 = {};
    local u22 = 1;
    local u23 = 1;
    local u24 = 0;
    local u25 = nil;
    local u26 = nil;
    for _, v27 in pairs({
        Vector3.new(0.14142136, 0, 0.14142136),
        Vector3.new(-0.14142136, 0, 0.14142136),
        Vector3.new(-0.14142136, 0, -0.14142136),
        Vector3.new(0.14142136, 0, -0.14142136),
        Vector3.new(0.4, 0, 0),
        Vector3.new(0.28284273, 0, 0.28284273),
        Vector3.new(0.000000000000000024492937, 0, 0.4),
        Vector3.new(-0.28284273, 0, 0.28284273),
        Vector3.new(-0.4, 0, 0.000000000000000048985874),
        Vector3.new(-0.28284273, 0, -0.28284273),
        Vector3.new(-0.000000000000000073478805, 0, -0.4),
        Vector3.new(0.28284273, 0, -0.28284273),
        Vector3.new(0.6, 0, 0),
        Vector3.new(0.4854102, 0, 0.35267115),
        Vector3.new(0.1854102, 0, 0.57063395),
        Vector3.new(-0.1854102, 0, 0.57063395),
        Vector3.new(-0.4854102, 0, 0.35267115),
        Vector3.new(-0.6, 0, 0.00000000000000007347881),
        Vector3.new(-0.4854102, 0, -0.35267115),
        Vector3.new(-0.1854102, 0, -0.57063395),
        Vector3.new(0.1854102, 0, -0.57063395),
        Vector3.new(0.4854102, 0, -0.35267115),
        Vector3.new(0.77274066, 0, 0.20705524),
        Vector3.new(0.56568545, 0, 0.56568545),
        Vector3.new(0.20705524, 0, 0.77274066),
        Vector3.new(-0.20705524, 0, 0.77274066),
        Vector3.new(-0.56568545, 0, 0.56568545),
        Vector3.new(-0.77274066, 0, 0.20705524),
        Vector3.new(-0.77274066, 0, -0.20705524),
        Vector3.new(-0.56568545, 0, -0.56568545),
        Vector3.new(-0.20705524, 0, -0.77274066),
        Vector3.new(0.20705524, 0, -0.77274066),
        Vector3.new(0.56568545, 0, -0.56568545),
        Vector3.new(0.77274066, 0, -0.20705524)
    }) do
        table.insert(u15, v27 * 35);
    end;
    table.sort(u15, function(p28, p29) --[[ Line: 165 ]]
        return p28.magnitude < p29.magnitude;
    end);
    local u30 = Instance.new("SoundGroup");
    u30.Name = "__RainSoundGroup";
    u30.Volume = 0.2;
    u30.Archivable = false;
    local u31 = Instance.new("Sound");
    u31.Name = "RainSound";
    u31.Volume = u16;
    u31.SoundId = "rbxassetid://1516791621";
    u31.Looped = true;
    u31.SoundGroup = u30;
    u31.Parent = u30;
    u31.Archivable = false;
    local u32 = Instance.new("Part");
    u32.Transparency = 1;
    u32.Anchored = true;
    u32.CanCollide = false;
    u32.Locked = false;
    u32.Archivable = false;
    u32.TopSurface = Enum.SurfaceType.Smooth;
    u32.BottomSurface = Enum.SurfaceType.Smooth;
    u32.Name = "__RainEmitter";
    u32.Size = Vector3.new(0.05, 0.05, 0.05);
    u32.Archivable = false;
    local v33 = Instance.new("ParticleEmitter");
    v33.Name = "RainStraight";
    v33.LightEmission = 0.05;
    v33.LightInfluence = 0.9;
    v33.Size = v2;
    v33.Texture = "rbxassetid://1822883048";
    v33.LockedToPart = true;
    v33.Enabled = false;
    v33.Lifetime = v3;
    v33.Rate = 600;
    v33.Speed = NumberRange.new(60);
    v33.EmissionDirection = Enum.NormalId.Bottom;
    v33.Parent = u32;
    local v34 = Instance.new("ParticleEmitter");
    v34.Name = "RainTopDown";
    v34.LightEmission = 0.05;
    v34.LightInfluence = 0.9;
    v34.Size = v4;
    v34.Texture = "rbxassetid://1822856633";
    v34.LockedToPart = true;
    v34.Enabled = false;
    v34.Rotation = v6;
    v34.Lifetime = v5;
    v34.Rate = 600;
    v34.Speed = NumberRange.new(60);
    v34.EmissionDirection = Enum.NormalId.Bottom;
    v34.Parent = u32;
    local u35 = {};
    local u36 = {};
    for _ = 1, 20 do
        local v37 = Instance.new("Attachment");
        v37.Name = "__RainSplashAttachment";
        local v38 = Instance.new("ParticleEmitter");
        v38.LightEmission = 0.05;
        v38.LightInfluence = 0.9;
        v38.Size = v7;
        v38.Texture = "rbxassetid://1822856633";
        v38.Rotation = v9;
        v38.Lifetime = v8;
        v38.Transparency = NumberSequence.new({
            u13,
            NumberSequenceKeypoint.new(0.25, 0.6, 0),
            NumberSequenceKeypoint.new(0.75, 0.6, 0),
            u14
        });
        v38.Enabled = false;
        v38.Rate = 0;
        v38.Speed = NumberRange.new(0);
        v38.Name = "RainSplash";
        v38.Parent = v37;
        v37.Archivable = false;
        table.insert(u36, v37);
        local v39 = Instance.new("Attachment");
        v39.Name = "__RainOccludedAttachment";
        local v40 = u32.RainStraight:Clone();
        v40.Speed = NumberRange.new(70, 100);
        v40.SpreadAngle = v10;
        v40.LockedToPart = false;
        v40.Enabled = false;
        v40.Parent = v39;
        local v41 = u32.RainTopDown:Clone();
        v41.Speed = NumberRange.new(70, 100);
        v41.SpreadAngle = v10;
        v41.LockedToPart = false;
        v41.Enabled = false;
        v41.Parent = v39;
        v39.Archivable = false;
        table.insert(u35, v39);
    end;
    local u42 = { u32 };
    local u57 = {
        [u11.None] = function(p43, p44) --[[ Line: 289 ]]
            -- upvalues: u32 (ref), l__Players__1 (copy), u42 (copy)
            local v45 = workspace;
            local v46;
            if p44 then
                v46 = {};
                local v47 = u32;
                local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
                if l__LocalPlayer__6 then
                    l__LocalPlayer__6 = l__Players__1.LocalPlayer.Character;
                end;
                v46[1], v46[2] = v47, l__LocalPlayer__6;
                if v46 then
                    return v45:FindPartOnRayWithIgnoreList(p43, v46);
                end;
            end;
            v46 = u42;
            return v45:FindPartOnRayWithIgnoreList(p43, v46);
        end,
        [u11.Blacklist] = function(p48) --[[ Line: 292 ]]
            -- upvalues: u25 (ref)
            return workspace:FindPartOnRayWithIgnoreList(p48, u25);
        end,
        [u11.Whitelist] = function(p49) --[[ Line: 295 ]]
            -- upvalues: u25 (ref)
            return workspace:FindPartOnRayWithWhitelist(p49, u25);
        end,
        [u11.Function] = function(p50) --[[ Line: 298 ]]
            -- upvalues: u42 (copy), u26 (ref)
            local v51 = p50.Origin + p50.Direction;
            while p50.Direction.magnitude > 0.001 do
                local v52, v53, v54, v55 = workspace:FindPartOnRayWithIgnoreList(p50, u42);
                if not v52 or u26(v52) then
                    return v52, v53, v54, v55;
                end;
                local v56 = v53 + p50.Direction.Unit * 0.001;
                p50 = Ray.new(v56, v51 - v56);
            end;
        end
    };
    local u58 = u57[l__None__4];
    local function u94() --[[ Line: 313 ]]
        -- upvalues: u21 (ref), l__RunService__3 (copy), u58 (ref), u18 (ref), u19 (ref), u16 (ref), u20 (ref), l__TweenService__2 (copy), u31 (copy), u32 (ref), l__new__5 (copy), u13 (copy), u22 (ref), u14 (copy), u23 (ref), u35 (ref), u15 (copy), u17 (ref), u36 (ref), u24 (ref)
        local u59 = Random.new();
        local u60 = true;
        local u61 = 6;
        table.insert(u21, l__RunService__3.RenderStepped:connect(function() --[[ Line: 321 ]]
            -- upvalues: u58 (ref), u18 (ref), u19 (ref), u16 (ref), u20 (ref), l__TweenService__2 (ref), u31 (ref), u61 (ref), u32 (ref), l__new__5 (ref), u60 (ref)
            local v62, _ = u58(Ray.new(workspace.CurrentCamera.CFrame.p, -u18 * 1000), true);
            if u19 and workspace.CurrentCamera.CFrame.p.y > u19 or v62 then
                u32.RainStraight.Enabled = false;
                u32.RainTopDown.Enabled = false;
                u60 = true;
            else
                if u16 < 1 and not u20 then
                    u16 = 1;
                    l__TweenService__2:Create(u31, TweenInfo.new(0.5), {
                        Volume = 1
                    }):Play();
                end;
                u61 = 6;
                local v63 = workspace.CurrentCamera.CFrame.lookVector:Dot(u18);
                local v64 = math.abs(v63);
                local l__p__7 = workspace.CurrentCamera.CFrame.p;
                local v65 = workspace.CurrentCamera.CFrame.lookVector:Cross(-u18);
                local v66 = v65.magnitude > 0.001 and v65.unit or -u18;
                local l__unit__8 = u18:Cross(v66).unit;
                u32.Size = l__new__5(40, 40, (1 - v64) * 60 + 40);
                u32.CFrame = CFrame.new(l__p__7.x, l__p__7.y, l__p__7.z, v66.x, -u18.x, l__unit__8.x, v66.y, -u18.y, l__unit__8.y, v66.z, -u18.z, l__unit__8.z) + (1 - v64) * workspace.CurrentCamera.CFrame.lookVector * u32.Size.Z / 3 - v64 * u18 * 20;
                u32.RainStraight.Enabled = true;
                u32.RainTopDown.Enabled = true;
                u60 = false;
            end;
        end));
        local v67 = l__RunService__3:IsRunning() and l__RunService__3.Stepped or l__RunService__3.RenderStepped;
        table.insert(u21, v67:connect(function() --[[ Line: 380 ]]
            -- upvalues: u61 (ref), u18 (ref), u13 (ref), u22 (ref), u14 (ref), u23 (ref), u60 (ref), u35 (ref), u20 (ref), u19 (ref), u15 (ref), u58 (ref), u16 (ref), l__TweenService__2 (ref), u31 (ref), u32 (ref), u17 (ref), u36 (ref), u59 (copy), l__new__5 (ref), u24 (ref)
            u61 = u61 + 1;
            if u61 >= 6 then
                local v68 = workspace.CurrentCamera.CFrame.lookVector:Dot(u18);
                local v69 = math.abs(v68);
                local v70 = NumberSequence.new({
                    u13,
                    NumberSequenceKeypoint.new(0.25, (1 - v69) * u22 + v69, 0),
                    NumberSequenceKeypoint.new(0.75, (1 - v69) * u22 + v69, 0),
                    u14
                });
                local v71 = NumberSequence.new({
                    u13,
                    NumberSequenceKeypoint.new(0.25, v69 * u23 + (1 - v69), 0),
                    NumberSequenceKeypoint.new(0.75, v69 * u23 + (1 - v69), 0),
                    u14
                });
                local v72 = workspace.Camera.CFrame:inverse() * (workspace.Camera.CFrame.p - u18);
                local l__new__9 = NumberRange.new;
                local v73 = math.atan2(-v72.x, v72.y);
                local v74 = l__new__9((math.deg(v73)));
                if u60 then
                    for _, v75 in pairs(u35) do
                        v75.RainStraight.Transparency = v70;
                        v75.RainStraight.Rotation = v74;
                        v75.RainTopDown.Transparency = v71;
                    end;
                    if not u20 then
                        local v76;
                        if u19 and workspace.CurrentCamera.CFrame.p.y > u19 then
                            v76 = 0;
                        else
                            local v77 = -u18 * 1000;
                            local v78 = 35;
                            for v79 = 1, #u15 do
                                if not u58(Ray.new(workspace.CurrentCamera.CFrame * u15[v79], v77), true) then
                                    v78 = u15[v79].magnitude;
                                    break;
                                end;
                            end;
                            v76 = 1 - v78 / 35;
                        end;
                        if math.abs(v76 - u16) > 0.01 then
                            u16 = v76;
                            l__TweenService__2:Create(u31, TweenInfo.new(1), {
                                Volume = u16
                            }):Play();
                        end;
                    end;
                else
                    u32.RainStraight.Transparency = v70;
                    u32.RainStraight.Rotation = v74;
                    u32.RainTopDown.Transparency = v71;
                end;
                u61 = 0;
            end;
            local l__p__10 = workspace.CurrentCamera.CFrame.p;
            local v80 = workspace.CurrentCamera.CFrame.lookVector:Cross(-u18);
            local v81 = v80.magnitude > 0.001 and v80.unit or -u18;
            local l__unit__11 = u18:Cross(v81).unit;
            local v82 = CFrame.new(l__p__10.x, l__p__10.y, l__p__10.z, v81.x, -u18.x, l__unit__11.x, v81.y, -u18.y, l__unit__11.y, v81.z, -u18.z, l__unit__11.z);
            local v83 = u18 * 550;
            for v84 = 1, u17 do
                local v85 = u36[v84];
                local v86 = u35[v84];
                local v87 = u59:NextNumber(-100, 100);
                local v88 = u59:NextNumber(-100, 100);
                local v89, v90, v91 = u58(Ray.new(v82 * l__new__5(v87, 500, v88), v83));
                if v89 then
                    v85.Position = v90 + v91 * 0.5;
                    v85.RainSplash:Emit(1);
                    if u60 then
                        local v92 = v90 - u18 * 50;
                        if u19 and (u19 < v92.Y and u18.Y < 0) then
                            v92 = v92 + u18 * (u19 - v92.Y) / u18.Y;
                        end;
                        v86.CFrame = v82 - v82.p + v92;
                        v86.RainStraight:Emit(u24);
                        v86.RainTopDown:Emit(u24);
                    end;
                elseif u60 then
                    local v93 = v82 * l__new__5(v87, u59:NextNumber(20, 100), v88);
                    if u19 and (u19 < v93.Y and u18.Y < 0) then
                        v93 = v93 + u18 * (u19 - v93.Y) / u18.Y;
                    end;
                    v86.CFrame = v82 - v82.p + v93;
                    v86.RainStraight:Emit(u24);
                    v86.RainTopDown:Emit(u24);
                end;
            end;
        end));
    end;
    local function u96() --[[ Line: 525 ]]
        -- upvalues: u21 (ref)
        if #u21 > 0 then
            for _, v95 in pairs(u21) do
                v95:disconnect();
            end;
            u21 = {};
        end;
    end;
    local function u100(p97) --[[ Line: 535 ]]
        -- upvalues: u16 (ref), l__TweenService__2 (copy), u31 (copy)
        u16 = 0;
        local u98 = l__TweenService__2:Create(u31, p97, {
            Volume = 0
        });
        u98.Completed:connect(function(p99) --[[ Line: 540 ]]
            -- upvalues: u31 (ref), u98 (copy)
            if p99 == Enum.PlasgckState.Completed then
                u31:Stop();
            end;
            u98:Destroy();
        end);
        u98:Play();
    end;
    local function v105(p101) --[[ Line: 577 ]]
        -- upvalues: u32 (ref), u36 (ref), u35 (ref)
        local v102 = ColorSequence.new(p101);
        u32.RainStraight.Color = v102;
        u32.RainTopDown.Color = v102;
        for _, v103 in pairs(u36) do
            v103.RainSplash.Color = v102;
        end;
        for _, v104 in pairs(u35) do
            v104.RainStraight.Color = v102;
            v104.RainTopDown.Color = v102;
        end;
    end;
    local u106 = Instance.new("Color3Value");
    if v1 then
        u106.Value = v1;
    end;
    u106.Changed:connect(v105);
    v105(u106.Value);
    local function v112(p107) --[[ Line: 594 ]]
        -- upvalues: u12 (copy), u22 (ref), u23 (ref), u13 (copy), u14 (copy), u36 (ref)
        local v108 = (1 - p107) * (1 - u12.Value);
        local v109 = 1 - v108;
        u22 = 0.7 * v108 + v109;
        u23 = 0.85 * v108 + v109;
        local v110 = NumberSequence.new({
            u13,
            NumberSequenceKeypoint.new(0.25, v108 * 0.6 + v109, 0),
            NumberSequenceKeypoint.new(0.75, v108 * 0.6 + v109, 0),
            u14
        });
        for _, v111 in pairs(u36) do
            v111.RainSplash.Transparency = v110;
        end;
    end;
    local u113 = Instance.new("NumberValue");
    u113.Value = 0;
    u113.Changed:connect(v112);
    v112(u113.Value);
    u12.Changed:connect(v112);
    local u114 = Instance.new("NumberValue");
    u114.Value = 1;
    u114.Changed:connect(function(p115) --[[ Line: 617 ]]
        -- upvalues: u32 (ref)
        u32.RainStraight.Speed = NumberRange.new(p115 * 60);
        u32.RainTopDown.Speed = NumberRange.new(p115 * 60);
    end);
    local l__Value__12 = u114.Value;
    u32.RainStraight.Speed = NumberRange.new(l__Value__12 * 60);
    u32.RainTopDown.Speed = NumberRange.new(l__Value__12 * 60);
    local u116 = Instance.new("NumberValue");
    u116.Value = 1;
    u116.Changed:connect(function(p117) --[[ Line: 624 ]]
        -- upvalues: u32 (ref), u24 (ref), u17 (ref)
        u32.RainStraight.Rate = 600 * p117;
        u32.RainTopDown.Rate = 600 * p117;
        u24 = math.ceil(2 * p117);
        u17 = 20 * p117;
    end);
    local l__Value__13 = u116.Value;
    u32.RainStraight.Rate = 600 * l__Value__13;
    u32.RainTopDown.Rate = 600 * l__Value__13;
    local _ = math.ceil(2 * l__Value__13);
    local _ = 20 * l__Value__13;
    local function v121(p118) --[[ Line: 634 ]]
        -- upvalues: u32 (ref), u35 (ref), u36 (ref)
        u32.RainStraight.LightEmission = p118;
        u32.RainTopDown.LightEmission = p118;
        for _, v119 in pairs(u35) do
            v119.RainStraight.LightEmission = p118;
            v119.RainTopDown.LightEmission = p118;
        end;
        for _, v120 in pairs(u36) do
            v120.RainSplash.LightEmission = p118;
        end;
    end;
    local u122 = Instance.new("NumberValue");
    u122.Value = 0.05;
    u122.Changed:connect(v121);
    v121(u122.Value);
    local function v126(p123) --[[ Line: 649 ]]
        -- upvalues: u32 (ref), u35 (ref), u36 (ref)
        u32.RainStraight.LightInfluence = p123;
        u32.RainTopDown.LightInfluence = p123;
        for _, v124 in pairs(u35) do
            v124.RainStraight.LightInfluence = p123;
            v124.RainTopDown.LightInfluence = p123;
        end;
        for _, v125 in pairs(u36) do
            v125.RainSplash.LightInfluence = p123;
        end;
    end;
    local u127 = Instance.new("NumberValue");
    u127.Value = 0.9;
    u127.Changed:connect(v126);
    v126(u127.Value);
    local u128 = Instance.new("Vector3Value");
    u128.Value = Vector3.new(0, -1, 0);
    u128.Changed:connect(function(p129) --[[ Line: 664 ]]
        -- upvalues: u18 (ref)
        if p129.magnitude > 0.001 then
            u18 = p129.unit;
        end;
    end);
    local l__Value__14 = u128.Value;
    if l__Value__14.magnitude > 0.001 then
        local _ = l__Value__14.unit;
    end;
    local v137 = {
        CollisionMode = u11,
        ReturnDisabled = function(_) --[[ Name: ReturnDisabled, Line 677 ]]
            -- upvalues: u20 (ref)
            return u20;
        end,
        Enable = function(_, p130) --[[ Name: Enable, Line 681 ]]
            -- upvalues: u96 (copy), u32 (ref), u36 (ref), u35 (ref), l__RunService__3 (copy), u30 (copy), u94 (copy), l__TweenService__2 (copy), u12 (copy), u31 (copy), u20 (ref)
            if p130 ~= nil and typeof(p130) ~= "TweenInfo" then
                error("bad argument #1 to \'Enable\' (TweenInfo expected, got " .. typeof(p130) .. ")", 2);
            end;
            u96();
            u32.RainStraight.Enabled = true;
            u32.RainTopDown.Enabled = true;
            u32.Parent = workspace.CurrentCamera;
            for v131 = 1, 20 do
                u36[v131].Parent = workspace.Terrain;
                u35[v131].Parent = workspace.Terrain;
            end;
            if l__RunService__3:IsRunning() then
                u30.Parent = game:GetService("SoundService");
            end;
            u94();
            if p130 then
                l__TweenService__2:Create(u12, p130, {
                    Value = 0
                }):Play();
            else
                u12.Value = 0;
            end;
            if not u31.Playing then
                u31:Play();
                u31.TimePosition = math.random() * u31.TimeLength;
            end;
            u20 = false;
        end,
        Disable = function(_, p132) --[[ Name: Disable, Line 719 ]]
            -- upvalues: l__TweenService__2 (copy), u12 (copy), u96 (copy), u32 (ref), u20 (ref), u100 (copy)
            if p132 ~= nil and typeof(p132) ~= "TweenInfo" then
                error("bad argument #1 to \'Disable\' (TweenInfo expected, got " .. typeof(p132) .. ")", 2);
            end;
            if p132 then
                local u133 = l__TweenService__2:Create(u12, p132, {
                    Value = 1
                });
                u133.Completed:connect(function(p134) --[[ Line: 727 ]]
                    -- upvalues: u96 (ref), u32 (ref), u20 (ref), u100 (ref), u133 (copy)
                    if p134 == Enum.PlasgckState.Completed then
                        u96();
                        u32.RainStraight.Enabled = false;
                        u32.RainTopDown.Enabled = false;
                        u32.Size = Vector3.new(0.05, 0.05, 0.05);
                        if not u20 then
                            u100(TweenInfo.new(1));
                        end;
                    end;
                    u133:Destroy();
                end);
                u133:Play();
                u100(p132);
            else
                u12.Value = 1;
                u96();
                u32.RainStraight.Enabled = false;
                u32.RainTopDown.Enabled = false;
                u32.Size = Vector3.new(0.05, 0.05, 0.05);
                if not u20 then
                    u100(TweenInfo.new(1));
                end;
            end;
            u20 = true;
        end,
        SetColor = function(_, p135, p136) --[[ Name: SetColor, Line 746 ]]
            -- upvalues: l__TweenService__2 (copy), u106 (copy)
            if typeof(p135) == "Color3" then
                if p136 ~= nil and typeof(p136) ~= "TweenInfo" then
                    error("bad argument #2 to \'SetColor\' (TweenInfo expected, got " .. typeof(p136) .. ")", 2);
                end;
            else
                error("bad argument #1 to \'SetColor\' (Color3 expected, got " .. typeof(p135) .. ")", 2);
            end;
            if p136 then
                l__TweenService__2:Create(u106, p136, {
                    Value = p135
                }):Play();
            else
                u106.Value = p135;
            end;
        end
    };
    local u138 = "SetTransparency";
    function v137.SetTransparency(_, p139, p140) --[[ Line: 764 ]]
        -- upvalues: u138 (copy), l__TweenService__2 (copy), u113 (copy)
        if typeof(p139) == "number" then
            if p140 ~= nil and typeof(p140) ~= "TweenInfo" then
                error("bad argument #2 to \'" .. u138 .. "\' (TweenInfo expected, got " .. typeof(p140) .. ")", 2);
            end;
        else
            error("bad argument #1 to \'" .. u138 .. "\' (number expected, got " .. typeof(p139) .. ")", 2);
        end;
        local v141 = math.clamp(p139, 0, 1);
        if p140 then
            l__TweenService__2:Create(u113, p140, {
                Value = v141
            }):Play();
        else
            u113.Value = v141;
        end;
    end;
    local u142 = "SetSpeedRatio";
    function v137.SetSpeedRatio(_, p143, p144) --[[ Line: 764 ]]
        -- upvalues: u142 (copy), l__TweenService__2 (copy), u114 (copy)
        if typeof(p143) == "number" then
            if p144 ~= nil and typeof(p144) ~= "TweenInfo" then
                error("bad argument #2 to \'" .. u142 .. "\' (TweenInfo expected, got " .. typeof(p144) .. ")", 2);
            end;
        else
            error("bad argument #1 to \'" .. u142 .. "\' (number expected, got " .. typeof(p143) .. ")", 2);
        end;
        local v145 = math.clamp(p143, 0, 1);
        if p144 then
            l__TweenService__2:Create(u114, p144, {
                Value = v145
            }):Play();
        else
            u114.Value = v145;
        end;
    end;
    local u146 = "SetIntensityRatio";
    function v137.SetIntensityRatio(_, p147, p148) --[[ Line: 764 ]]
        -- upvalues: u146 (copy), l__TweenService__2 (copy), u116 (copy)
        if typeof(p147) == "number" then
            if p148 ~= nil and typeof(p148) ~= "TweenInfo" then
                error("bad argument #2 to \'" .. u146 .. "\' (TweenInfo expected, got " .. typeof(p148) .. ")", 2);
            end;
        else
            error("bad argument #1 to \'" .. u146 .. "\' (number expected, got " .. typeof(p147) .. ")", 2);
        end;
        local v149 = math.clamp(p147, 0, 1);
        if p148 then
            l__TweenService__2:Create(u116, p148, {
                Value = v149
            }):Play();
        else
            u116.Value = v149;
        end;
    end;
    local u150 = "SetLightEmission";
    function v137.SetLightEmission(_, p151, p152) --[[ Line: 764 ]]
        -- upvalues: u150 (copy), l__TweenService__2 (copy), u122 (copy)
        if typeof(p151) == "number" then
            if p152 ~= nil and typeof(p152) ~= "TweenInfo" then
                error("bad argument #2 to \'" .. u150 .. "\' (TweenInfo expected, got " .. typeof(p152) .. ")", 2);
            end;
        else
            error("bad argument #1 to \'" .. u150 .. "\' (number expected, got " .. typeof(p151) .. ")", 2);
        end;
        local v153 = math.clamp(p151, 0, 1);
        if p152 then
            l__TweenService__2:Create(u122, p152, {
                Value = v153
            }):Play();
        else
            u122.Value = v153;
        end;
    end;
    local u154 = "SetLightInfluence";
    function v137.SetLightInfluence(_, p155, p156) --[[ Line: 764 ]]
        -- upvalues: u154 (copy), l__TweenService__2 (copy), u127 (copy)
        if typeof(p155) == "number" then
            if p156 ~= nil and typeof(p156) ~= "TweenInfo" then
                error("bad argument #2 to \'" .. u154 .. "\' (TweenInfo expected, got " .. typeof(p156) .. ")", 2);
            end;
        else
            error("bad argument #1 to \'" .. u154 .. "\' (number expected, got " .. typeof(p155) .. ")", 2);
        end;
        local v157 = math.clamp(p155, 0, 1);
        if p156 then
            l__TweenService__2:Create(u127, p156, {
                Value = v157
            }):Play();
        else
            u127.Value = v157;
        end;
    end;
    function v137.SetVolume(_, p158, p159) --[[ Line: 789 ]]
        -- upvalues: l__TweenService__2 (copy), u30 (copy)
        if typeof(p158) == "number" then
            if p159 ~= nil and typeof(p159) ~= "TweenInfo" then
                error("bad argument #2 to \'SetVolume\' (TweenInfo expected, got " .. typeof(p159) .. ")", 2);
            end;
        else
            error("bad argument #1 to \'SetVolume\' (number expected, got " .. typeof(p158) .. ")", 2);
        end;
        if p159 then
            l__TweenService__2:Create(u30, p159, {
                Volume = p158
            }):Play();
        else
            u30.Volume = p158;
        end;
    end;
    function v137.SetDirection(_, p160, p161) --[[ Line: 805 ]]
        -- upvalues: l__TweenService__2 (copy), u128 (copy)
        if typeof(p160) == "Vector3" then
            if p161 ~= nil and typeof(p161) ~= "TweenInfo" then
                error("bad argument #2 to \'SetDirection\' (TweenInfo expected, got " .. typeof(p161) .. ")", 2);
            end;
        else
            error("bad argument #1 to \'SetDirection\' (Vector3 expected, got " .. typeof(p160) .. ")", 2);
        end;
        if p160.unit.magnitude <= 0 then
            warn("Attempt to set rain direction to a zero-length vector, falling back on default direction = (" .. tostring(Vector3.new(0, -1, 0)) .. ")");
            p160 = Vector3.new(0, -1, 0);
        end;
        if p161 then
            l__TweenService__2:Create(u128, p161, {
                Value = p160
            }):Play();
        else
            u128.Value = p160;
        end;
    end;
    function v137.SetCeiling(_, p162) --[[ Line: 826 ]]
        -- upvalues: u19 (ref)
        if p162 ~= nil and typeof(p162) ~= "number" then
            error("bad argument #1 to \'SetCeiling\' (number expected, got " .. typeof(p162) .. ")", 2);
        end;
        u19 = p162;
    end;
    function v137.SetStraightTexture(_, p163) --[[ Line: 836 ]]
        -- upvalues: u32 (ref), u35 (ref)
        if typeof(p163) ~= "string" then
            error("bad argument #1 to \'SetStraightTexture\' (string expected, got " .. typeof(p163) .. ")", 2);
        end;
        u32.RainStraight.Texture = p163;
        for _, v164 in pairs(u35) do
            v164.RainStraight.Texture = p163;
        end;
    end;
    function v137.SetTopDownTexture(_, p165) --[[ Line: 850 ]]
        -- upvalues: u32 (ref), u35 (ref)
        if typeof(p165) ~= "string" then
            error("bad argument #1 to \'SetStraightTexture\' (string expected, got " .. typeof(p165) .. ")", 2);
        end;
        u32.RainTopDown.Texture = p165;
        for _, v166 in pairs(u35) do
            v166.RainTopDown.Texture = p165;
        end;
    end;
    function v137.SetSplashTexture(_, p167) --[[ Line: 864 ]]
        -- upvalues: u36 (ref)
        if typeof(p167) ~= "string" then
            error("bad argument #1 to \'SetStraightTexture\' (string expected, got " .. typeof(p167) .. ")", 2);
        end;
        for _, v168 in pairs(u36) do
            v168.RainSplash.Texture = p167;
        end;
    end;
    function v137.SetSoundId(_, p169) --[[ Line: 876 ]]
        -- upvalues: u31 (copy)
        if typeof(p169) ~= "string" then
            error("bad argument #1 to \'SetSoundId\' (string expected, got " .. typeof(p169) .. ")", 2);
        end;
        u31.SoundId = p169;
    end;
    function v137.SetCollisionMode(_, p170, p171) --[[ Line: 886 ]]
        -- upvalues: u11 (copy), u25 (ref), u26 (ref), u32 (ref), l__None__4 (ref), u58 (ref), u57 (copy)
        if p170 == u11.None then
            u25 = nil;
            u26 = nil;
        elseif p170 == u11.Blacklist then
            if typeof(p171) == "Instance" then
                u25 = { p171, u32 };
            elseif typeof(p171) == "table" then
                for v172 = 1, #p171 do
                    if typeof(p171[v172]) ~= "Instance" then
                        error("bad argument #2 to \'SetCollisionMode\' (blacklist contained a " .. typeof(p171[v172]) .. " on index " .. tostring(v172) .. " which is not an Instance)", 2);
                    end;
                end;
                u25 = { u32 };
                for v173 = 1, #p171 do
                    table.insert(u25, p171[v173]);
                end;
            else
                error("bad argument #2 to \'SetCollisionMode (Instance or array of Instance expected, got " .. typeof(p171) .. ")\'", 2);
            end;
            u26 = nil;
        elseif p170 == u11.Whitelist then
            if typeof(p171) == "Instance" then
                u25 = { p171 };
            elseif typeof(p171) == "table" then
                for v174 = 1, #p171 do
                    if typeof(p171[v174]) ~= "Instance" then
                        error("bad argument #2 to \'SetCollisionMode\' (whitelist contained a " .. typeof(p171[v174]) .. " on index " .. tostring(v174) .. " which is not an Instance)", 2);
                    end;
                end;
                u25 = {};
                for v175 = 1, #p171 do
                    table.insert(u25, p171[v175]);
                end;
            else
                error("bad argument #2 to \'SetCollisionMode (Instance or array of Instance expected, got " .. typeof(p171) .. ")\'", 2);
            end;
            u26 = nil;
        elseif p170 == u11.Function then
            if typeof(p171) ~= "function" then
                error("bad argument #2 to \'SetCollisionMode\' (function expected, got " .. typeof(p171) .. ")", 2);
            end;
            u25 = nil;
            u26 = p171;
        else
            error("bad argument #1 to \'SetCollisionMode (Rain.CollisionMode expected, got " .. typeof(p171) .. ")\'", 2);
        end;
        l__None__4 = p170;
        u58 = u57[p170];
    end;
    return v137;
end;