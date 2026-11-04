 

 

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local l_workspace = workspace;
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

function v1.StartMeshEmitter(u6: userdata, p7: userdata, p8, p9: number, p10: table) -- Line: 39
    -- upvalues: Debris (copy), RunService (copy), l_workspace (copy), HttpService (copy), TweenService (copy), Players (copy)
    local u11 = (p10 or {}).SizeMulti or 1;

    if not (u6 and u6:IsA("BasePart")) then
        return warn(">> Invalid Root for MeshEmitter. must be a BasePart.");
    end;

    local u12 = p8 or CFrame.new(0, 0, 0);
    local u13 = p7:Clone();
    local u14 = os.clock() + (p9 or 10);
    task.spawn(function() -- Line: 52
        -- upvalues: u14 (copy), u6 (copy), Debris (ref), u13 (copy), u12 (ref), RunService (ref)
        while u14 > os.clock() and u6:IsDescendantOf(game) do
            u13:PivotTo(u6.CFrame * u12);
            RunService.RenderStepped:Wait();
        end;

        Debris:AddItem(u13, 0);
    end);
    local PrimaryPart = u13.PrimaryPart;
    u13.Parent = l_workspace;

    for _, descendant in pairs(u13:GetDescendants()) do
        local Attribute = descendant:GetAttribute("MeshEmitter");

        if Attribute then
            local v15 = HttpService:JSONDecode(Attribute);
            local u16 = descendant;

            for _, v in pairs(v15) do
                local v17 = v;

                for i, v2 in pairs(v) do
                    local Direction = v2.Direction;
                    local Style = v2.Style;
                    local Property = v2.Property;
                    local Time = v2.Time;
                    local Value = v2.Value;
                    local v18 = v17[i + 1];

                    if v18 ~= nil then
                        local _ = v18.Direction;
                        local _ = v18.Style;
                        local _ = v18.Property;
                        local Time2 = v18.Time;
                        local Value2 = v18.Value;

                        local function Getval(p19) -- Line: 91
                            -- upvalues: u16 (copy), Property (copy), PrimaryPart (copy), u11 (copy)
                            local v20 = typeof(u16[Property]);
                            local v21 = PropertyConvert(PrimaryPart, v20, p19);

                            if (Property == "Size" or Property == "Scale") and v20 == "Vector3" then
                                v21 = Vector3.new(v21.X * u11, v21.Y * u11, v21.Z * u11);
                            end;

                            return v21;
                        end;

                        local v22 = Style == "Circ" and "Circular" or ((Style == "Expo" or Style == "Sextic") and "Exponential" or Style);

                        if v22 == "Constant" then
                            if Time > 0 then
                                task.delay(Time, function() -- Line: 112
                                    -- upvalues: u16 (copy), Property (copy), Value (copy), PrimaryPart (copy), u11 (copy)
                                    local v23 = typeof(u16[Property]);
                                    local v24 = PropertyConvert(PrimaryPart, v23, Value);

                                    if (Property == "Size" or Property == "Scale") and v23 == "Vector3" then
                                        v24 = Vector3.new(v24.X * u11, v24.Y * u11, v24.Z * u11);
                                    end;

                                    u16[Property] = v24;
                                end);
                            else
                                local v25 = typeof(u16[Property]);
                                local v26 = PropertyConvert(PrimaryPart, v25, Value);

                                if (Property == "Size" or Property == "Scale") and v25 == "Vector3" then
                                    v26 = Vector3.new(v26.X * u11, v26.Y * u11, v26.Z * u11);
                                end;

                                u16[Property] = v26;
                            end;

                            task.delay(Time2, function() -- Line: 118
                                -- upvalues: u16 (copy), Property (copy), Value2 (copy), PrimaryPart (copy), u11 (copy)
                                local v27 = typeof(u16[Property]);
                                local v28 = PropertyConvert(PrimaryPart, v27, Value2);

                                if (Property == "Size" or Property == "Scale") and v27 == "Vector3" then
                                    v28 = Vector3.new(v28.X * u11, v28.Y * u11, v28.Z * u11);
                                end;

                                u16[Property] = v28;
                            end);
                        else
                            local v29 = Enum.EasingStyle:FromName(v22);

                            if v29 == nil then
                                v29 = Enum.EasingStyle.Linear;
                                warn("MeshEmitter does not support", v22, "yet. has been redirected to Linear");
                            end;

                            local TweenInfo_new_ret = TweenInfo.new(Time2 - Time, v29, Enum.EasingDirection[Direction]);

                            if Time > 0 then
                                task.delay(Time, function() -- Line: 131
                                    -- upvalues: u16 (copy), Property (copy), Value (copy), PrimaryPart (copy), u11 (copy), TweenService (ref), TweenInfo_new_ret (copy), Value2 (copy)
                                    local v30 = typeof(u16[Property]);
                                    local v31 = PropertyConvert(PrimaryPart, v30, Value);

                                    if (Property == "Size" or Property == "Scale") and v30 == "Vector3" then
                                        v31 = Vector3.new(v31.X * u11, v31.Y * u11, v31.Z * u11);
                                    end;

                                    u16[Property] = v31;
                                    local v32 = {};
                                    local v33 = typeof(u16[Property]);
                                    local v34 = PropertyConvert(PrimaryPart, v33, Value2);

                                    if (Property == "Size" or Property == "Scale") and v33 == "Vector3" then
                                        v34 = Vector3.new(v34.X * u11, v34.Y * u11, v34.Z * u11);
                                    end;

                                    v32[Property] = v34;
                                    TweenService:Create(u16, TweenInfo_new_ret, v32):Play();
                                end);
                            else
                                local v35 = typeof(u16[Property]);
                                local v36 = PropertyConvert(PrimaryPart, v35, Value);

                                if (Property == "Size" or Property == "Scale") and v35 == "Vector3" then
                                    v36 = Vector3.new(v36.X * u11, v36.Y * u11, v36.Z * u11);
                                end;

                                u16[Property] = v36;
                                local v37 = {};
                                local v38 = typeof(u16[Property]);
                                local v39 = PropertyConvert(PrimaryPart, v38, Value2);

                                if (Property == "Size" or Property == "Scale") and v38 == "Vector3" then
                                    v39 = Vector3.new(v39.X * u11, v39.Y * u11, v39.Z * u11);
                                end;

                                v37[Property] = v39;
                                TweenService:Create(u16, TweenInfo_new_ret, v37):Play();
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    for _, child in pairs(u13:GetChildren()) do
        local Attribute = child:GetAttribute("GroupType");

        if Attribute == "CameraEffect" then
            child.Parent = workspace.CurrentCamera;
            u13.AncestryChanged:Once(function() -- Line: 153
                -- upvalues: Debris (ref), child (copy)
                Debris:AddItem(child, 0);
            end);
        elseif Attribute == "Vignette" and Players.LocalPlayer then
            child.Parent = Players.LocalPlayer and (Players.LocalPlayer:FindFirstChild("PlayerGui") and Players.LocalPlayer.PlayerGui) or game:GetService("StarterGui");
            u13.AncestryChanged:Once(function() -- Line: 159
                -- upvalues: Debris (ref), child (copy)
                Debris:AddItem(child, 0);
            end);
        end;
    end;

    return u13;
end;

return v1;