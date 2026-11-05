  

 

local RunService = game:GetService("RunService");
local u1 = Random.new();

local function GetAttr(p2, p3, p4) -- Line: 4
    local v5 = p2:GetAttribute(p3);

    if v5 == nil or typeof(v5) ~= typeof(p4) then
        return p4;
    end;

    return v5;
end;

local function GetRangeAttr(p6, p7, p8) -- Line: 12
    local v9 = p6:GetAttribute(p7);

    if typeof(v9) == "NumberRange" then
        return v9;
    end;

    return p8;
end;

local function IsMeshVFX(p10) -- Line: 20
    if not p10:IsA("Model") then
        return false;
    end;

    local Start = p10:FindFirstChild("Start");
    local End = p10:FindFirstChild("End");
    local v11;

    if Start == nil or End == nil then
        v11 = false;
    else
        v11 = Start:IsA("BasePart") and End:IsA("BasePart");
    end;

    return v11;
end;

local function InsideMeshVFX(p12, p13) -- Line: 27
    -- upvalues: IsMeshVFX (copy)
    local Parent = p12.Parent;

    while Parent do
        if IsMeshVFX(Parent) then
            return true;
        end;

        if Parent == p13 then
            return false;
        end;

        Parent = Parent.Parent;
    end;

    return false;
end;

local function Ease(p14) -- Line: 37
    return 1 - (1 - p14) ^ 3;
end;

local function ScaleTpSequence(p15, p16) -- Line: 41
    if p16 == 1 then
        return p15;
    end;

    local v17 = table.create(#p15.Keypoints);

    for i, v in p15.Keypoints do
        local Value = v.Value;
        local v18;

        if p16 > 1 then
            v18 = Value + (1 - Value) * (p16 - 1);
        else
            v18 = Value * p16;
        end;

        v17[i] = NumberSequenceKeypoint.new(v.Time, math.clamp(v18, 0, 1), v.Envelope);
    end;

    return NumberSequence.new(v17);
end;

local u19 = nil;

local function EmitMesh(u20) -- Line: 58
    -- upvalues: u1 (copy), IsMeshVFX (copy), u19 (ref), RunService (copy)
    local Start = u20:FindFirstChild("Start");
    local End = u20:FindFirstChild("End");

    if not (Start and End) then
        return 0;
    end;

    local v21 = u20:GetAttribute("Duration");
    local v22 = (v21 == nil or typeof(v21) ~= "number") and 1 or v21;
    local v23 = NumberRange.new(v22, v22);
    local v24 = u20:GetAttribute("EffectDuration");

    if typeof(v24) == "NumberRange" then
        v23 = v24;
    end;

    local v25 = u1:NextNumber(v23.Min, v23.Max);
    local u26 = math.max(v25, 0.0001);
    local v27 = u20:GetAttribute("EmitDelay");
    local u28 = (v27 == nil or typeof(v27) ~= "number") and 0 or v27;
    local u29 = Start:FindFirstChildOfClass("Decal") and 1 or 0;
    local u30 = u20:GetAttribute("Mesh_StartTransparency");

    if u30 == nil or typeof(u30) ~= typeof(u29) then
        u30 = u29;
    end;

    local v31 = u20:GetAttribute("Part_Transparency_Start");

    if v31 ~= nil and typeof(v31) == typeof(u30) then
        u30 = v31;
    end;

    local v32 = u20:GetAttribute("Mesh_EndTransparency");

    if v32 ~= nil and typeof(v32) == typeof(u29) then
        u29 = v32;
    end;

    local v33 = u20:GetAttribute("Part_Transparency_End");

    if v33 ~= nil and typeof(v33) == typeof(u29) then
        u29 = v33;
    end;

    local v34 = u20:GetAttribute("Decal_StartTransparency");
    local u35 = (v34 == nil or typeof(v34) ~= "number") and 0 or v34;
    local v36 = u20:GetAttribute("Decal_EndTransparency");
    local u37 = (v36 == nil or typeof(v36) ~= "number") and 1 or v36;
    local v38 = u20:GetAttribute("Speed_Start");
    local u39 = (v38 == nil or typeof(v38) ~= "number") and 1 or v38;
    local v40 = u20:GetAttribute("Speed_End");
    local u41 = (v40 == nil or typeof(v40) ~= "number") and 1 or v40;
    local v42 = u20:GetAttribute("Speed_Duration");
    local v43 = (v42 == nil or typeof(v42) ~= "number") and 0.1 or v42;
    local u44 = math.max(v43, 0.0001);
    local v45 = u20:GetAttribute("SpreadAngle");
    local u46 = (v45 == nil or typeof(v45) ~= typeof(Vector3.new(0, 0, 0))) and Vector3.new(0, 0, 0) or v45;
    local u47 = u20:GetAttribute("RotAroundOrigin");

    if u47 == nil or typeof(u47) ~= "boolean" then
        u47 = false;
    end;

    local u48 = u20:GetAttribute("SyncPosition");

    if u48 == nil or typeof(u48) ~= "boolean" then
        u48 = false;
    end;

    local v49 = u20:GetAttribute("MinInitRot");
    local u50 = (v49 == nil or typeof(v49) ~= typeof(Vector3.new(0, 0, 0))) and Vector3.new(0, 0, 0) or v49;
    local v51 = u20:GetAttribute("MaxInitRot");
    local u52 = (v51 == nil or typeof(v51) ~= typeof(Vector3.new(0, 0, 0))) and Vector3.new(0, 0, 0) or v51;
    local u53 = NumberRange.new(0, 0);
    local v54 = u20:GetAttribute("Part_RotSpeed_Start");

    if typeof(v54) == "NumberRange" then
        u53 = v54;
    end;

    local v55 = NumberRange.new(0, 0);
    local u56 = u20:GetAttribute("Part_RotSpeed_End");

    if typeof(u56) ~= "NumberRange" then
        u56 = v55;
    end;

    task.spawn(function() -- Line: 86
        -- upvalues: u28 (copy), Start (copy), End (copy), u1 (ref), u50 (copy), u52 (copy), u46 (copy), u53 (copy), u56 (copy), u20 (copy), u30 (copy), IsMeshVFX (ref), u19 (ref), u35 (copy), u37 (copy), u39 (copy), RunService (ref), u41 (copy), u44 (copy), u26 (copy), u48 (copy), u47 (copy), u29 (copy)
        if u28 > 0 then
            task.wait(u28);
        end;

        if not (Start.Parent and End.Parent) then
            return;
        end;

        local v57 = u1:NextNumber(u50.X, u52.X);
        local v58 = u1:NextNumber(u50.Y, u52.Y);
        local v59 = Vector3.new(v57, v58, u1:NextNumber(u50.Z, u52.Z)) * 0.017453292519943295;
        local v60 = math.sign(v59.X);
        local v61 = math.sign(v59.Y);
        local v62 = math.sign(v59.Z);
        local u63 = Vector3.new(v60, v61, v62);
        local fromOrientation = CFrame.fromOrientation;
        local v64 = u1:NextNumber(-u46.X, u46.X);
        local v65 = math.rad(v64);
        local v66 = u1:NextNumber(-u46.Y, u46.Y);
        local u67 = fromOrientation(v65, math.rad(v66), 0);
        local u68 = u1:NextNumber(u53.Min, u53.Max);
        local u69 = u1:NextNumber(u56.Min, u56.Max);
        local u70 = u20:FindFirstAncestorOfClass("Attachment") or Start;
        local u71 = u70:IsA("Attachment") and u70.WorldCFrame or u70.CFrame;
        local u72 = Start.CFrame:ToObjectSpace(End.CFrame);
        local v73, u74 = u72:ToAxisAngle();
        local u75 = v73.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or v73;
        local Size = Start.Size;
        local Size2 = End.Size;
        local v76 = Start:GetDescendants();
        local u77 = Start:Clone();
        u77.Anchored = true;
        u77.CanCollide = false;
        u77.CanQuery = false;
        u77.CanTouch = false;
        u77.Locked = true;
        u77.Archivable = false;
        u77.Transparency = u30;
        u77.Size = Size;
        u77.Parent = workspace:FindFirstChild("Effects") or workspace;
        local v78 = u77:GetDescendants();
        local v79 = {
            [Start] = u77
        };

        for i, v in v76 do
            v79[v] = v78[i];
        end;

        for _, v in v78 do
            if v:IsA("Beam") or v:IsA("Trail") then
                local Attachment0 = v.Attachment0;
                local Attachment1 = v.Attachment1;

                if Attachment0 and v79[Attachment0] then
                    v.Attachment0 = v79[Attachment0];
                end;

                if Attachment1 and v79[Attachment1] then
                    v.Attachment1 = v79[Attachment1];
                end;
            end;
        end;

        for _, v in v78 do
            local Parent = v.Parent;
            local v80;

            while true do
                if not Parent then
                    v80 = false;
                    break;
                end;

                if IsMeshVFX(Parent) then
                    v80 = true;
                    break;
                end;

                if Parent == u77 then
                    v80 = false;
                    break;
                end;

                Parent = Parent.Parent;
            end;

            if not v80 then
                u19(v);
            end;
        end;

        local u81 = u77:FindFirstChildOfClass("SpecialMesh");
        local v82 = Start:FindFirstChildOfClass("SpecialMesh");
        local v83 = End:FindFirstChildOfClass("SpecialMesh");
        local u84 = nil;
        local u85 = nil;

        if u81 then
            if v82 and v83 then
                u84 = v82.Scale;
                u85 = v83.Scale;
                u81.Scale = u84;
            else
                u81:Destroy();
                u81 = nil;
            end;
        end;

        local u86 = {};

        for _, child in Start:GetChildren() do
            if child:IsA("Decal") then
                local v87 = End:FindFirstChild(child.Name);

                if v87 and v87:IsA("Decal") then
                    local v88 = u77:FindFirstChild(child.Name);

                    if v88 and v88:IsA("Decal") then
                        local v89 = u35;
                        local v90 = child:GetAttribute("Transparency_Start");

                        if v90 ~= nil and typeof(v90) == typeof(v89) then
                            v89 = v90;
                        end;

                        local v91 = u37;
                        local v92 = child:GetAttribute("Transparency_End");

                        if v92 ~= nil and typeof(v92) == typeof(v91) then
                            v91 = v92;
                        end;

                        v88.Transparency = v89;
                        v88.Color3 = child.Color3;
                        table.insert(u86, {
                            Obj = v88,
                            StartColor = child.Color3,
                            EndColor = v87.Color3,
                            StartTp = v89,
                            EndTp = v91
                        });
                    end;
                end;
            end;
        end;

        local u93 = 0;
        local u94 = 0;
        local u95 = u39;
        local u96 = CFrame.fromOrientation(v59.X, v59.Y, v59.Z);
        local u97 = nil;
        u97 = RunService.RenderStepped:Connect(function(p98) -- Line: 185
            -- upvalues: u77 (copy), u97 (ref), u39 (ref), u41 (ref), u94 (ref), u44 (ref), u95 (ref), u93 (ref), u26 (ref), u68 (copy), u69 (copy), u63 (copy), u96 (ref), u71 (copy), u48 (ref), u70 (copy), u72 (copy), u75 (ref), u74 (copy), u47 (ref), u67 (copy), Size (copy), Size2 (copy), u30 (ref), u29 (ref), u81 (ref), u84 (ref), u85 (ref), u86 (copy)
            if not u77.Parent then
                u97:Disconnect();

                return;
            end;

            if u39 ~= u41 and u94 < u44 then
                u94 = math.min(u94 + p98, u44);
                u95 = u39 + (u41 - u39) * (1 - (1 - u94 / u44) ^ 3);
            end;

            u93 = math.min(u93 + p98 * u95, u26);
            local v99 = u93 / u26;
            local v100 = 1 - (1 - v99) ^ 3;
            local v101 = u63 * (u68 + (u69 - u68) * v100) * p98;
            u96 = u96 * CFrame.fromOrientation(v101.X, v101.Y, v101.Z);
            local v102 = u71;

            if u48 and u70.Parent then
                v102 = u70:IsA("Attachment") and u70.WorldCFrame or u70.CFrame;
            end;

            local v103 = CFrame.new(u72.Position * v100) * CFrame.fromAxisAngle(u75, u74 * v100);
            u77.CFrame = (u47 and v102 * u67 * u96 * v103 or v102 * u67 * v103 * u96) * u96;
            u77.Size = Size:Lerp(Size2, v100);
            u77.Transparency = u30 + (u29 - u30) * v100;

            if u81 then
                u81.Scale = u84:Lerp(u85, v100);
            end;

            for _, v in u86 do
                v.Obj.Transparency = v.StartTp + (v.EndTp - v.StartTp) * v100;
                v.Obj.Color3 = v.StartColor:Lerp(v.EndColor, v100);
            end;

            if v99 >= 1 then
                u97:Disconnect();
                u77:Destroy();
            end;
        end);
    end);
    local v104 = math.min(u39, u41);

    return u28 + u26 / math.max(v104, 0.0001);
end;

local function EmitBeam(u105) -- Line: 236
    -- upvalues: u1 (copy), ScaleTpSequence (copy), RunService (copy)
    local v106 = u105:GetAttribute("Duration");
    local v107 = (v106 == nil or typeof(v106) ~= "number") and 1 or v106;
    local v108 = NumberRange.new(v107, v107);
    local v109 = u105:GetAttribute("EffectDuration");

    if typeof(v109) == "NumberRange" then
        v108 = v109;
    end;

    local v110 = u1:NextNumber(v108.Min, v108.Max);
    local u111 = math.max(v110, 0.0001);
    local v112 = u105:GetAttribute("EmitDelay");
    local u113 = (v112 == nil or typeof(v112) ~= "number") and 0 or v112;
    local v114 = u105:GetAttribute("EndTransparencyScale");
    local u115 = (v114 == nil or typeof(v114) ~= "number") and 1 or v114;
    local v116 = u105:GetAttribute("Transparency_Scale_Start");
    local u117 = (v116 == nil or typeof(v116) ~= "number") and 1 or v116;
    local v118 = u105:GetAttribute("Transparency_Scale_End");

    if v118 ~= nil and typeof(v118) == typeof(u115) then
        u115 = v118;
    end;

    local Width0 = u105.Width0;
    local v119 = u105:GetAttribute("Width0_Start");

    if v119 ~= nil and typeof(v119) == typeof(Width0) then
        Width0 = v119;
    end;

    local Width02 = u105.Width0;
    local v120 = u105:GetAttribute("Width0_End");

    if v120 ~= nil and typeof(v120) == typeof(Width02) then
        Width02 = v120;
    end;

    local Width1 = u105.Width1;
    local v121 = u105:GetAttribute("Width1_Start");

    if v121 ~= nil and typeof(v121) == typeof(Width1) then
        Width1 = v121;
    end;

    local Width12 = u105.Width1;
    local v122 = u105:GetAttribute("Width1_End");

    if v122 ~= nil and typeof(v122) == typeof(Width12) then
        Width12 = v122;
    end;

    local v123 = u105:GetAttribute("Speed_Start");
    local u124 = (v123 == nil or typeof(v123) ~= "number") and 1 or v123;
    local v125 = u105:GetAttribute("Speed_End");
    local u126 = (v125 == nil or typeof(v125) ~= "number") and 1 or v125;
    local v127 = u105:GetAttribute("Speed_Duration");
    local v128 = (v127 == nil or typeof(v127) ~= "number") and 0.1 or v127;
    local u129 = math.max(v128, 0.0001);
    local Transparency = u105.Transparency;
    local TextureSpeed = u105.TextureSpeed;
    task.spawn(function() -- Line: 258
        -- upvalues: u113 (copy), u105 (copy), Width0 (copy), Width1 (copy), ScaleTpSequence (ref), Transparency (copy), u117 (copy), u124 (copy), RunService (ref), u126 (copy), u129 (copy), TextureSpeed (copy), u111 (copy), Width02 (copy), Width12 (copy), u115 (copy)
        if u113 > 0 then
            task.wait(u113);
        end;

        if not u105.Parent then
            return;
        end;

        u105.Width0 = Width0;
        u105.Width1 = Width1;
        u105.Transparency = ScaleTpSequence(Transparency, u117);
        u105.Enabled = true;
        local u130 = 0;
        local u131 = 0;
        local u132 = u124;
        local u133 = nil;
        u133 = RunService.RenderStepped:Connect(function(p134) -- Line: 272
            -- upvalues: u105 (ref), u133 (ref), u124 (ref), u126 (ref), u131 (ref), u129 (ref), u132 (ref), TextureSpeed (ref), u130 (ref), u111 (ref), Width0 (ref), Width02 (ref), Width1 (ref), Width12 (ref), ScaleTpSequence (ref), Transparency (ref), u117 (ref), u115 (ref)
            if not u105.Parent then
                u133:Disconnect();

                return;
            end;

            if u124 ~= u126 and u131 < u129 then
                u131 = math.min(u131 + p134, u129);
                u132 = u124 + (u126 - u124) * (1 - (1 - u131 / u129) ^ 3);
                u105.TextureSpeed = TextureSpeed * u132;
            end;

            u130 = math.min(u130 + p134 * u132, u111);
            local v135 = u130 / u111;
            local v136 = 1 - (1 - v135) ^ 3;
            u105.Width0 = Width0 + (Width02 - Width0) * v136;
            u105.Width1 = Width1 + (Width12 - Width1) * v136;
            u105.Transparency = ScaleTpSequence(Transparency, u117 + (u115 - u117) * v136);

            if v135 >= 1 then
                u133:Disconnect();

                if u105.Parent then
                    u105.Enabled = false;
                end;
            end;
        end);
    end);
    local v137 = math.min(u124, u126);

    return u113 + u111 / math.max(v137, 0.0001);
end;

local function EmitTrail(u138) -- Line: 303
    -- upvalues: u1 (copy)
    local v139 = u138:GetAttribute("Duration");
    local v140 = (v139 == nil or typeof(v139) ~= "number") and 1 or v139;
    local v141 = NumberRange.new(v140, v140);
    local v142 = u138:GetAttribute("EffectDuration");

    if typeof(v142) == "NumberRange" then
        v141 = v142;
    end;

    local v143 = u1:NextNumber(v141.Min, v141.Max);
    local u144 = math.max(v143, 0.0001);
    local v145 = u138:GetAttribute("EmitDelay");
    local u146 = (v145 == nil or typeof(v145) ~= "number") and 0 or v145;
    task.spawn(function() -- Line: 309
        -- upvalues: u146 (copy), u138 (copy), u144 (copy)
        if u146 > 0 then
            task.wait(u146);
        end;

        if not u138.Parent then
            return;
        end;

        u138.Enabled = true;
        task.wait(u144);

        if u138.Parent then
            u138.Enabled = false;
        end;
    end);

    return u146 + u144 + u138.Lifetime;
end;

u19 = function(p147) -- Line: 320
    -- upvalues: EmitBeam (copy), EmitTrail (copy), IsMeshVFX (copy), EmitMesh (copy)
    if p147:IsA("Beam") then
        return EmitBeam(p147);
    end;

    if p147:IsA("Trail") then
        return EmitTrail(p147);
    end;

    return not IsMeshVFX(p147) and 0 or EmitMesh(p147);
end;

return function(u148, p149) -- Line: 327
    -- upvalues: IsMeshVFX (copy), u19 (ref)
    if not u148 then
        return;
    end;

    local u150 = 0;

    local function SafeEmit(p151) -- Line: 334
        -- upvalues: u150 (ref), IsMeshVFX (ref), u19 (ref)
        if u150 >= 40 then
            return 0;
        end;

        if not (p151:IsA("Beam") or (p151:IsA("Trail") or IsMeshVFX(p151))) then
            return 0;
        end;

        u150 = u150 + 1;

        return u19(p151);
    end;

    local v152 = math.max(0, SafeEmit(u148));

    for _, descendant in u148:GetDescendants() do
        local Parent = descendant.Parent;
        local v153;

        while true do
            if not Parent then
                v153 = false;
                break;
            end;

            if IsMeshVFX(Parent) then
                v153 = true;
                break;
            end;

            if Parent == u148 then
                v153 = false;
                break;
            end;

            Parent = Parent.Parent;
        end;

        if not v153 then
            v152 = math.max(v152, SafeEmit(descendant));

            if u150 >= 40 then
                break;
            end;
        end;
    end;

    if typeof(p149) == "number" then
        v152 = p149;
    end;

    if v152 > 0 then
        task.delay(v152, function() -- Line: 365
            -- upvalues: u148 (copy)
            if u148.Parent then
                u148:Destroy();
            end;
        end);
    end;
end;