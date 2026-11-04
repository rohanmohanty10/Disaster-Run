 

 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
game:GetService("RunService");
game:GetService("Debris");
local workspace_Effects = workspace.Effects;
local v1 = {};

function PropertyConvert(p2, p3, p4)
    local v5 = nil;

    if p3 == "CFrame" then
        return p2.CFrame * CFrame.new(unpack(string.split(p4, ", ")));
    end;

    if p3 == "boolean" then
        return p4 == "true";
    end;

    if p3 == "Color3" then
        return Color3.new(unpack(string.split(p4, ", ")));
    end;

    if p3 == "Vector3" then
        return Vector3.new(unpack(string.split(p4, ", ")));
    end;

    if p3 == "number" then
        v5 = tonumber(p4);
    end;

    return v5;
end;

function v1.StartMeshEmitter(p6: userdata, p7: userdata, p8, p9: number, p10: table) -- Line: 38
    -- upvalues: workspace_Effects (copy), HttpService (copy), TweenService (copy)
    local u11 = (p10 or {}).SizeMulti or 1;

    if not (p6 and p6:IsA("BasePart")) then
        return warn(">> Invalid Root for MeshEmitter. must be a BasePart.");
    end;

    local v12 = p8 or CFrame.new(0, 0, 0);
    local v13 = p7:Clone();

    for _, descendant in ipairs(v13:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    v13:PivotTo(p6.CFrame * v12);
    task.delay(p9 or 10, v13.Destroy, v13);
    local PrimaryPart = v13.PrimaryPart;
    v13.Parent = workspace_Effects;

    for _, descendant in pairs(v13:GetDescendants()) do
        local Attribute = descendant:GetAttribute("MeshEmitter");

        if Attribute then
            local v14 = HttpService:JSONDecode(Attribute);
            local u15 = descendant;

            for _, v in pairs(v14) do
                local v16 = v;

                for i, v2 in pairs(v) do
                    local Direction = v2.Direction;
                    local Style = v2.Style;
                    local Property = v2.Property;
                    local Time = v2.Time;
                    local Value = v2.Value;
                    local v17 = v16[i + 1];

                    if v17 ~= nil then
                        local _ = v17.Direction;
                        local _ = v17.Style;
                        local _ = v17.Property;
                        local Time2 = v17.Time;
                        local Value2 = v17.Value;

                        local function Getval(p18) -- Line: 98
                            -- upvalues: u15 (copy), Property (copy), PrimaryPart (copy), u11 (copy)
                            local v19 = typeof(u15[Property]);
                            local v20 = PropertyConvert(PrimaryPart, v19, p18);

                            if (Property == "Size" or Property == "Scale") and v19 == "Vector3" then
                                v20 = Vector3.new(v20.X * u11, v20.Y * u11, v20.Z * u11);
                            end;

                            return v20;
                        end;

                        local v21 = Style == "Circ" and "Circular" or ((Style == "Expo" or Style == "Sextic") and "Exponential" or Style);

                        if v21 == "Constant" then
                            if Time > 0 then
                                task.delay(Time, function() -- Line: 119
                                    -- upvalues: u15 (copy), Property (copy), Value (copy), PrimaryPart (copy), u11 (copy)
                                    local v22 = typeof(u15[Property]);
                                    local v23 = PropertyConvert(PrimaryPart, v22, Value);

                                    if (Property == "Size" or Property == "Scale") and v22 == "Vector3" then
                                        v23 = Vector3.new(v23.X * u11, v23.Y * u11, v23.Z * u11);
                                    end;

                                    u15[Property] = v23;
                                end);
                            else
                                local v24 = typeof(u15[Property]);
                                local v25 = PropertyConvert(PrimaryPart, v24, Value);

                                if (Property == "Size" or Property == "Scale") and v24 == "Vector3" then
                                    v25 = Vector3.new(v25.X * u11, v25.Y * u11, v25.Z * u11);
                                end;

                                u15[Property] = v25;
                            end;

                            task.delay(Time2, function() -- Line: 125
                                -- upvalues: u15 (copy), Property (copy), Value2 (copy), PrimaryPart (copy), u11 (copy)
                                local v26 = typeof(u15[Property]);
                                local v27 = PropertyConvert(PrimaryPart, v26, Value2);

                                if (Property == "Size" or Property == "Scale") and v26 == "Vector3" then
                                    v27 = Vector3.new(v27.X * u11, v27.Y * u11, v27.Z * u11);
                                end;

                                u15[Property] = v27;
                            end);
                        else
                            local v28 = Enum.EasingStyle:FromName(v21);

                            if v28 == nil then
                                v28 = Enum.EasingStyle.Linear;
                                warn("MeshEmitter does not support", v21, "yet. has been redirected to Linear");
                            end;

                            local TweenInfo_new_ret = TweenInfo.new(Time2 - Time, v28, Enum.EasingDirection[Direction]);

                            if Time > 0 then
                                task.delay(Time, function() -- Line: 138
                                    -- upvalues: u15 (copy), Property (copy), Value (copy), PrimaryPart (copy), u11 (copy), TweenService (ref), TweenInfo_new_ret (copy), Value2 (copy)
                                    local v29 = typeof(u15[Property]);
                                    local v30 = PropertyConvert(PrimaryPart, v29, Value);

                                    if (Property == "Size" or Property == "Scale") and v29 == "Vector3" then
                                        v30 = Vector3.new(v30.X * u11, v30.Y * u11, v30.Z * u11);
                                    end;

                                    u15[Property] = v30;
                                    local v31 = {};
                                    local v32 = typeof(u15[Property]);
                                    local v33 = PropertyConvert(PrimaryPart, v32, Value2);

                                    if (Property == "Size" or Property == "Scale") and v32 == "Vector3" then
                                        v33 = Vector3.new(v33.X * u11, v33.Y * u11, v33.Z * u11);
                                    end;

                                    v31[Property] = v33;
                                    TweenService:Create(u15, TweenInfo_new_ret, v31):Play();
                                end);
                            else
                                local v34 = typeof(u15[Property]);
                                local v35 = PropertyConvert(PrimaryPart, v34, Value);

                                if (Property == "Size" or Property == "Scale") and v34 == "Vector3" then
                                    v35 = Vector3.new(v35.X * u11, v35.Y * u11, v35.Z * u11);
                                end;

                                u15[Property] = v35;
                                local v36 = {};
                                local v37 = typeof(u15[Property]);
                                local v38 = PropertyConvert(PrimaryPart, v37, Value2);

                                if (Property == "Size" or Property == "Scale") and v37 == "Vector3" then
                                    v38 = Vector3.new(v38.X * u11, v38.Y * u11, v38.Z * u11);
                                end;

                                v36[Property] = v38;
                                TweenService:Create(u15, TweenInfo_new_ret, v36):Play();
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v13;
end;

return v1;