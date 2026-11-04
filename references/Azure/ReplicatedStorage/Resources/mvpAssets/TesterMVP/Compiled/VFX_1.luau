 
 

local TweenService = game:GetService("TweenService");
local v17 = {
    Emit = function(p1: table, p2: userdata) -- Line: 3, Name: Emit
        for _, descendant in p2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                task.spawn(function() -- Line: 6
                    -- upvalues: descendant (copy)
                    local Attribute = descendant:GetAttribute("EmitDelay");
                    local Attribute2 = descendant:GetAttribute("EmitCount");
                    local Attribute3 = descendant:GetAttribute("EmitEnabled");
                    local Attribute4 = descendant:GetAttribute("EmitEnabledDuration");

                    if Attribute3 and (Attribute and (Attribute4 and not Attribute2)) then
                        task.spawn(function() -- Line: 13
                            -- upvalues: Attribute (copy), descendant (ref), Attribute4 (copy)
                            task.wait(Attribute);
                            descendant.Enabled = true;
                            task.wait(Attribute4);
                            descendant.Enabled = false;
                        end);
                    elseif Attribute3 and not (Attribute or (not Attribute4 or Attribute2)) then
                        task.spawn(function() -- Line: 20
                            -- upvalues: descendant (ref), Attribute4 (copy)
                            descendant.Enabled = true;
                            task.wait(Attribute4);
                            descendant.Enabled = false;
                        end);
                    end;

                    if Attribute and (Attribute2 and not Attribute3) then
                        task.spawn(function() -- Line: 28
                            -- upvalues: Attribute (copy), descendant (ref), Attribute2 (copy)
                            task.wait(Attribute);
                            descendant:Emit(Attribute2);
                        end);

                        return;
                    end;

                    if Attribute and not (Attribute2 or Attribute3) then
                        task.spawn(function() -- Line: 33
                            -- upvalues: Attribute (copy), descendant (ref)
                            task.wait(Attribute);
                            descendant:Emit();
                        end);

                        return;
                    end;

                    if not (Attribute or (not Attribute2 or Attribute3)) then
                        task.spawn(function() -- Line: 38
                            -- upvalues: descendant (ref), Attribute2 (copy)
                            descendant:Emit(Attribute2);
                        end);
                    end;
                end);
            end;
        end;
    end,

    ToggleEffects = function(p3: table, p4: any, p5: boolean, u6: number?) -- Line: 49, Name: ToggleEffects
        for _, descendant in p4:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = p5;

                if descendant.Enabled and u6 then
                    task.spawn(function() -- Line: 54
                        -- upvalues: u6 (copy), descendant (copy)
                        task.wait(u6);
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;
    end,

    ScaleParticles = function(p7: table, p8: any, u9: number) -- Line: 63, Name: ScaleParticles
        for _, descendant in pairs(p8:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Speed = NumberRange.new(descendant.Speed.Min * u9, descendant.Speed.Max * u9);
                local u10 = {};
                task.spawn(function() -- Line: 71
                    -- upvalues: descendant (copy), u10 (copy), u9 (copy)
                    for _, v in ipairs(descendant.Size.Keypoints) do
                        table.insert(u10, NumberSequenceKeypoint.new(v.Time, v.Value * u9, v.Envelope * u9));
                    end;

                    descendant.Size = NumberSequence.new(u10);
                end);
            end;
        end;
    end,

    ScaleBeams = function(p11: table, p12: any, p13: number) -- Line: 81, Name: ScaleBeams
        for _, descendant in pairs(p12:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Width0 = descendant.Width0 * p13;
                descendant.Width1 = descendant.Width1 * p13;
            end;
        end;
    end,

    PositionBeams = function(p14: table, p15: any, p16: number) -- Line: 90, Name: PositionBeams
        for _, descendant in pairs(p15:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.CFrame ~= CFrame.new() then
                descendant.CFrame = CFrame.new((Vector3.new(descendant.CFrame.X * p16, descendant.CFrame.Y * p16, descendant.CFrame.Z * p16)));
            end;
        end;
    end
};

local function CalculatePosition(p18, p19) -- Line: 99
    return CFrame.new(p18.Position):ToObjectSpace(CFrame.new(p19.Position)).Position;
end;

function v17.LocateSurface(p20: table, p21: userdata, p22: number, p23: userdata) -- Line: 104
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterDescendantsInstances = p23 or { workspace.Map };
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    local v24 = workspace:Raycast(p21.Position, p21.CFrame.UpVector * (p22 or -10), RaycastParams_new_ret);

    return v24 and v24.Position or print("Unable to find ground position because no ground or exceeds range");
end;

Random.new(3.141592653589793);

function v17.MeshTween(p25, p26) -- Line: 161
    -- upvalues: TweenService (copy)
    local table_unpack_ret, v27, v28, v29, v30 = table.unpack(p26);

    return TweenService:Create(table_unpack_ret, TweenInfo.new(v27, Enum.EasingStyle[v28], Enum.EasingDirection[v29]), v30);
end;

local function CreateSequence(p31, p32) -- Line: 165
    local v33 = {};

    for _, v in ipairs(p31.Keypoints) do
        table.insert(v33, NumberSequenceKeypoint.new(v.Time, v.Value + (1 - v.Value) * p32));
    end;

    return NumberSequence.new(v33);
end;

function v17.TweenNumberSequence(p34: table, u35: any, u36: number, u37: string) -- Line: 177
    -- upvalues: CreateSequence (copy)
    local u38 = tick();
    local u39 = u35[u37];
    local u40 = nil;
    u40 = game["Run Service"].Heartbeat:Connect(function() -- Line: 182
        -- upvalues: u38 (copy), u36 (copy), u35 (copy), u37 (copy), CreateSequence (ref), u39 (copy), u40 (ref)
        local v41 = (tick() - u38) / u36;
        local math_clamp_ret = math.clamp(v41, 0, 1);
        u35[u37] = CreateSequence(u39, math_clamp_ret);

        if math_clamp_ret >= 1 then
            u40:Disconnect();
        end;
    end);
end;

return v17;