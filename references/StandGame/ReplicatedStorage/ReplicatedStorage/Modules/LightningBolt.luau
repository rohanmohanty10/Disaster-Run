 

 

if #game:GetService("ServerStorage"):GetChildren() <= 0 then
    local l__clock__1 = os.clock;
    function DiscretePulse(p1, p2, p3, p4, p5, p6, p7)
        local v8 = p3 / (2 * p4) - math.abs((p1 - p5 * p2 + 0.5 * p3) / p4);
        return math.clamp(v8, p6, p7);
    end;
    function NoiseBetween(p9, p10, p11, p12, p13)
        return p12 + (p13 - p12) * (math.noise(p9, p10, p11) + 0.5);
    end;
    function CubicBezier(p14, p15, p16, p17, p18)
        return p14 * (1 - p18) ^ 3 + p15 * 3 * p18 * (1 - p18) ^ 2 + p16 * 3 * (1 - p18) * p18 ^ 2 + p17 * p18 ^ 3;
    end;
    local u19 = Instance.new("Part");
    u19.TopSurface = 0;
    u19.BottomSurface = 0;
    u19.Anchored = true;
    u19.CanCollide = false;
    u19.Shape = "Cylinder";
    u19.Name = "BoltPart";
    u19.Material = Enum.Material.Neon;
    u19.Color = Color3.new(1, 1, 1);
    u19.Transparency = 1;
    Random.new();
    local u20 = CFrame.lookAt(Vector3.new(), Vector3.new(1, 0, 0)):inverse();
    local u21 = {};
    local u22 = {};
    u22.__index = u22;
    function u22.new(p23, p24, p25) --[[ Line: 54 ]]
        -- upvalues: u22 (copy), u19 (copy), u20 (copy), l__clock__1 (copy), u21 (copy)
        local v26 = setmetatable({}, u22);
        v26.Enabled = true;
        v26.Attachment0 = p23;
        v26.Attachment1 = p24;
        v26.CurveSize0 = 0;
        v26.CurveSize1 = 0;
        v26.MinRadius = 0;
        v26.MaxRadius = 2.4;
        v26.Frequency = 1;
        v26.AnimationSpeed = 7;
        v26.Thickness = 1;
        v26.MinThicknessMultiplier = 0.2;
        v26.MaxThicknessMultiplier = 1;
        v26.MinTransparency = 0;
        v26.MaxTransparency = 1;
        v26.PulseSpeed = 2;
        v26.PulseLength = 1000000;
        v26.FadeLength = 0.2;
        v26.ContractFrom = 0.5;
        v26.Color = Color3.new(1, 1, 1);
        v26.ColorOffsetSpeed = 3;
        v26.Parts = {};
        local l__CurrentCamera__2 = workspace.CurrentCamera;
        local l__WorldPosition__3 = p23.WorldPosition;
        local v27 = p23.WorldPosition + p23.WorldAxis * v26.CurveSize0;
        local v28 = p24.WorldPosition - p24.WorldAxis * v26.CurveSize1;
        local l__WorldPosition__4 = p24.WorldPosition;
        local v29 = p25 or 30;
        local v30 = l__WorldPosition__3;
        local v31 = v30;
        local v32 = v30;
        v30 = v31;
        v32 = v31;
        for v33 = 1, v29 do
            local v34 = CubicBezier(l__WorldPosition__3, v27, v28, l__WorldPosition__4, v33 / v29);
            local v35;
            if v33 == v29 then
                v35 = v34;
            else
                v35 = CFrame.lookAt(v30, v34).Position or v34;
            end;
            local v36 = u19:Clone();
            v36.Size = Vector3.new((v35 - v31).Magnitude, 0, 0);
            v36.CFrame = CFrame.lookAt(0.5 * (v31 + v35), v35) * u20;
            v36.Parent = l__CurrentCamera__2;
            v36.Locked = true;
            v36.CastShadow = false;
            v26.Parts[v33] = v36;
            v30 = v34;
            v31 = v35;
        end;
        v26.PartsHidden = false;
        v26.DisabledTransparency = 1;
        v26.StartT = l__clock__1();
        v26.RanNum = math.random() * 100;
        v26.RefIndex = #u21 + 1;
        u21[v26.RefIndex] = v26;
        return v26;
    end;
    function u22.Destroy(p37) --[[ Line: 119 ]]
        -- upvalues: u21 (copy)
        u21[p37.RefIndex] = nil;
        for v38 = 1, #p37.Parts do
            p37.Parts[v38]:Destroy();
            if v38 % 100 == 0 then
                wait();
            end;
        end;
    end;
    game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 133 ]]
        -- upvalues: u21 (copy), l__clock__1 (copy), u20 (copy)
        for _, v39 in pairs(u21) do
            if v39.Enabled == true then
                v39.PartsHidden = false;
                local v40 = 1 - v39.MaxTransparency;
                local v41 = 1 - v39.MinTransparency;
                local l__MinRadius__5 = v39.MinRadius;
                local l__MaxRadius__6 = v39.MaxRadius;
                local l__Thickness__7 = v39.Thickness;
                local l__Parts__8 = v39.Parts;
                local v42 = #l__Parts__8;
                local l__RanNum__9 = v39.RanNum;
                local l__StartT__10 = v39.StartT;
                local l__AnimationSpeed__11 = v39.AnimationSpeed;
                local l__Frequency__12 = v39.Frequency;
                local l__MinThicknessMultiplier__13 = v39.MinThicknessMultiplier;
                local l__MaxThicknessMultiplier__14 = v39.MaxThicknessMultiplier;
                local l__Attachment0__15 = v39.Attachment0;
                local l__Attachment1__16 = v39.Attachment1;
                local l__CurveSize0__17 = v39.CurveSize0;
                local l__CurveSize1__18 = v39.CurveSize1;
                local l__WorldPosition__19 = l__Attachment0__15.WorldPosition;
                local v43 = l__Attachment0__15.WorldPosition + l__Attachment0__15.WorldAxis * l__CurveSize0__17;
                local v44 = l__Attachment1__16.WorldPosition - l__Attachment1__16.WorldAxis * l__CurveSize1__18;
                local l__WorldPosition__20 = l__Attachment1__16.WorldPosition;
                local v45 = l__clock__1() - l__StartT__10;
                local l__PulseLength__21 = v39.PulseLength;
                local l__PulseSpeed__22 = v39.PulseSpeed;
                local l__FadeLength__23 = v39.FadeLength;
                local l__Color__24 = v39.Color;
                local l__ColorOffsetSpeed__25 = v39.ColorOffsetSpeed;
                local v46 = 1 - v39.ContractFrom;
                if v45 < (l__PulseLength__21 + 1) / l__PulseSpeed__22 then
                    local v47 = l__WorldPosition__19;
                    local v48 = v47;
                    local v49 = v47;
                    v47 = v48;
                    v49 = v48;
                    for v50 = 1, v42 do
                        local v51 = l__Parts__8[v50];
                        local v52 = v50 / v42;
                        local v53 = DiscretePulse(v52, l__PulseSpeed__22, l__PulseLength__21, l__FadeLength__23, v45, v40, v41);
                        local v54 = CubicBezier(l__WorldPosition__19, v43, v44, l__WorldPosition__20, v52);
                        local v55 = -v45;
                        local v56 = l__AnimationSpeed__11 * v55 + l__Frequency__12 * 10 * v52 - 0.2 + l__RanNum__9 * 4;
                        local v57 = 5 * (l__AnimationSpeed__11 * 0.01 * v55 / 10 + l__Frequency__12 * v52) + l__RanNum__9 * 4;
                        local v58 = NoiseBetween(5 * v56, 1.5, 1 * v57, 0, 0.6283185307179586) + NoiseBetween(0.5 * v56, 1.5, 0.1 * v57, 0, 5.654866776461628);
                        local v59 = NoiseBetween(3.4, v57, v56, l__MinRadius__5, l__MaxRadius__6) * math.exp((v52 - 0.5) ^ 10 * -5000);
                        local v60 = NoiseBetween(2.3, v57, v56, l__MinThicknessMultiplier__13, l__MaxThicknessMultiplier__14);
                        local v61;
                        if v50 == v42 then
                            v61 = v54;
                        else
                            local v62 = CFrame.new(v47, v54) * CFrame.Angles(0, 0, v58);
                            local l__Angles__26 = CFrame.Angles;
                            local v63 = NoiseBetween(v57, v56, 2.7, 6.123233995736766e-17, 1);
                            local v64 = math.clamp(v63, -1, 1);
                            v61 = (v62 * l__Angles__26(math.acos(v64), 0, 0) * CFrame.new(0, 0, -v59)).Position or v54;
                        end;
                        if v46 < v53 then
                            v51.Size = Vector3.new((v61 - v48).Magnitude, l__Thickness__7 * v60 * v53, l__Thickness__7 * v60 * v53);
                            v51.CFrame = CFrame.lookAt(0.5 * (v48 + v61), v61) * u20;
                            v51.Transparency = 1 - v53;
                        elseif v46 - 1 / (v42 * l__FadeLength__23) < v53 then
                            local v65 = (1 - (v53 - (v46 - 1 / (v42 * l__FadeLength__23))) * v42 * l__FadeLength__23) * (v52 < v45 * l__PulseSpeed__22 - 0.5 * l__PulseLength__21 and 1 or -1);
                            local v66 = (1 - math.abs(v65)) * (v61 - v48).Magnitude;
                            v51.Size = Vector3.new(v66, l__Thickness__7 * v60 * v53, l__Thickness__7 * v60 * v53);
                            v51.CFrame = CFrame.lookAt(v48 + (v61 - v48) * (math.max(0, v65) + (1 - math.abs(v65)) * 0.5), v61) * u20;
                            v51.Transparency = 1 - v53;
                        else
                            v51.Transparency = 1;
                        end;
                        if typeof(l__Color__24) == "Color3" then
                            v51.Color = l__Color__24;
                        else
                            local v67 = (l__RanNum__9 + v52 - v45 * l__ColorOffsetSpeed__25) % 1;
                            local l__Keypoints__27 = l__Color__24.Keypoints;
                            for v68 = 1, #l__Keypoints__27 - 1 do
                                if l__Keypoints__27[v68].Time < v67 and v67 < l__Keypoints__27[v68 + 1].Time then
                                    v51.Color = l__Keypoints__27[v68].Value:lerp(l__Keypoints__27[v68 + 1].Value, (v67 - l__Keypoints__27[v68].Time) / (l__Keypoints__27[v68 + 1].Time - l__Keypoints__27[v68].Time));
                                    break;
                                end;
                            end;
                        end;
                        v47 = v54;
                        v48 = v61;
                    end;
                else
                    v39:Destroy();
                end;
            elseif v39.PartsHidden == false then
                v39.PartsHidden = true;
                local l__DisabledTransparency__28 = v39.DisabledTransparency;
                for v69 = 1, #v39.Parts do
                    v39.Parts[v69].Transparency = l__DisabledTransparency__28;
                end;
            end;
        end;
    end);
    return u22;
end;