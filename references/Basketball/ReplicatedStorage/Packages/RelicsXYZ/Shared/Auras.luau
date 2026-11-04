 
 

local v1 = {};
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
require(script.Parent.Trove);
local u2 = {};

local function lerp(p3: any, p4: any, p5: number) -- Line: 67
    return p3 * (1 - p5) + p4 * p5;
end;

local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal("RelicsAuraFx");
local InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal("RelicsAuraFx");

local function onEffectAdded(u6: userdata) -- Line: 74
    -- upvalues: Players (copy), CollectionService (copy), u2 (copy)
    local Attribute = u6:GetAttribute("Class");

    if type(Attribute) ~= "string" then
        return;
    end;

    local v7 = Attribute == "Bass" and "Bass" or (Attribute == "Treble" and "Treble" or (Attribute == "Percussion" and "Percussion" or nil));

    if not v7 then
        return;
    end;

    local v8 = u6:FindFirstAncestorOfClass("Accessory");

    if v8 then
        v8 = v8.Parent;
    end;

    local v9;

    if v8 then
        v9 = v8:WaitForChild("RELICSxyz Boombox", 2);
    else
        v9 = v8;
    end;

    local v10;

    if v9 then
        v10 = v9:FindFirstChildOfClass("AudioPlayer");
    else
        v10 = v9;
    end;

    if v9 then
        v9 = v9:FindFirstChild(v7);
    end;

    local v11 = nil;
    local v12 = nil;
    local v13, v14;

    if Players:GetPlayerFromCharacter(v8) == Players.LocalPlayer then
        v13 = CollectionService:GetTagged("RelicsClientAudioPlayer")[1];
        v14 = CollectionService:GetTagged((`RelicsAudioAnalyzer_{v7}`))[1];

        if v14 then
            if not v14:IsA("AudioAnalyzer") then
                v14 = v11;
            end;
        else
            v14 = v11;
        end;

        if v13 then
            if not v13:IsA("AudioPlayer") then
                v13 = v12;
            end;
        else
            v13 = v12;
        end;
    else
        v13 = v12;
        v14 = v11;
    end;

    if v9 and v9:IsA("AudioAnalyzer") then
        local v15 = nil;

        if u6:IsA("ParticleEmitter") then
            local Size = u6.Size;
            local v16 = tonumber(u6:GetAttribute("EmitCount"));
            local v17 = tonumber(u6:GetAttribute("OriginalRate")) or u6.Rate;
            local v18 = tonumber(u6:GetAttribute("OriginalBrightness")) or u6.Brightness;
            u6.LockedToPart = true;
            v15 = {
                Type = "Particle",
                ServerAnalyzer = v9,
                ClientAnalyzer = v14,
                ServerPlayer = v10,
                ClientPlayer = v13,
                Class = v7,
                Ref = u6,
                Data = {
                    OriginalBrightness = v18,
                    OriginalRate = v17,
                    EmitCount = v16,
                    BaseSize = Size,
                    Size = Size
                }
            };
        elseif u6:IsA("Beam") then
            local Width0 = u6.Width0;
            local Width1 = u6.Width1;
            local v19 = tonumber(u6:GetAttribute("OriginalTextureSpeed")) or u6.TextureSpeed;
            v15 = {
                Type = "Beam",
                ServerAnalyzer = v9,
                ClientAnalyzer = v14,
                ServerPlayer = v10,
                ClientPlayer = v13,
                Class = v7,
                Ref = u6,
                Data = {
                    BaseTextureSpeed = v19,
                    BaseWidth0 = Width0,
                    BaseWidth1 = Width1,
                    Width0 = Width0,
                    Width1 = Width1
                }
            };
        elseif u6:IsA("Trail") then
            local WidthScale = u6.WidthScale;
            v15 = {
                Type = "Trail",
                ServerAnalyzer = v9,
                ClientAnalyzer = v14,
                ServerPlayer = v10,
                ClientPlayer = v13,
                Class = v7,
                Ref = u6,
                Data = {
                    BaseWidthScale = WidthScale,
                    WidthScale = WidthScale
                }
            };
        elseif u6:IsA("Bone") then
            local Attribute2 = u6:GetAttribute("RotSpeed");
            v15 = typeof(Attribute2) == "CFrame" and {
                Type = "Bone",
                ServerAnalyzer = v9,
                ClientAnalyzer = v14,
                ServerPlayer = v10,
                ClientPlayer = v13,
                Class = v7,
                Ref = u6,
                Data = {
                    RotSpeed = Attribute2
                }
            } or v15;
        end;

        if v15 then
            local u20 = u6;

            while u6 ~= v8 do
                local Attribute2 = u6:GetAttribute("ParentPart");
                local Attribute3 = u6:GetAttribute("ParentAttachment");
                local Attribute4 = u6:GetAttribute("ParentSize");

                if type(Attribute2) == "string" and type(Attribute3) == "string" then
                    local u21 = v8:FindFirstChild(Attribute2);
                    local u22;

                    if u21 then
                        u22 = u21:FindFirstChild(Attribute3);
                    else
                        u22 = u21;
                    end;

                    if u21 and (u21:IsA("BasePart") and (u22 and u22:IsA("Attachment"))) then
                        if u6.Parent ~= u22 then
                            u20:SetAttribute("ParentPart", nil);
                            u20:SetAttribute("ParentSize", nil);
                            u20:SetAttribute("ParentAttachment", nil);
                            task.defer(function() -- Line: 244
                                -- upvalues: Attribute4 (copy), u21 (copy), u20 (copy), u6 (ref), u22 (copy)
                                if typeof(Attribute4) == "Vector3" then
                                    local v23 = u21.Size / Attribute4;

                                    if u20:IsA("Attachment") then
                                        local v24 = u20;
                                        v24.Position = v24.Position * v23;
                                    end;

                                    for _, descendant in u20:GetDescendants() do
                                        if descendant:IsA("BasePart") then
                                            descendant.Size = descendant.Size * v23;
                                        elseif descendant:IsA("Attachment") then
                                            descendant.Position = descendant.Position * v23;
                                        end;
                                    end;
                                end;

                                local Parent = u6.Parent;
                                u6.Parent = u22;
                                Parent.Destroying:Once(function() -- Line: 264
                                    -- upvalues: u20 (ref)
                                    u20:Destroy();
                                end);
                            end);
                        end;

                        break;
                    end;
                end;

                u6 = u6.Parent;
            end;

            u2[u20] = v15;
        end;
    end;
end;

function v1.Update(p25: boolean, p26: number) -- Line: 285
    -- upvalues: u2 (copy)
    local v27 = 0;
    local v28 = 0;
    local v29 = 0;

    for _, v in pairs(u2) do
        if v.Enabled or (v.Enabled == nil or p25) then
            local ServerAnalyzer = v.ServerAnalyzer;
            local ClientAnalyzer = v.ClientAnalyzer;
            local ServerPlayer = v.ServerPlayer;
            local ClientPlayer = v.ClientPlayer;
            local v30;

            if ClientAnalyzer then
                v30 = math.max(ServerAnalyzer.PeakLevel, ClientAnalyzer.PeakLevel);
            else
                v30 = ServerAnalyzer.PeakLevel;
            end;

            local v31;

            if ClientPlayer then
                v31 = ServerPlayer.IsPlaying or ClientPlayer.IsPlaying;
            else
                v31 = ServerPlayer.IsPlaying;
            end;

            if not p25 then
                v31 = false;
            end;

            local v32 = not v31 and 0.2 or v30 / 2;
            local v33 = v.Prev or 0;
            local v34 = 0;

            if v.Class == "Bass" then
                v34 = math.max(v27, v32);
                v27 = v34;
            elseif v.Class == "Treble" then
                v34 = math.max(v29, v32);
                v29 = v34;
            elseif v.Class == "Percussion" then
                v34 = math.max(v28, v32);
                v28 = v34;
            end;

            local v35 = v32 + 1;
            rawset(v, "Prev", v32);
            local v36;

            if v.Type == "Particle" then
                local Ref = v.Ref;
                local Data = v.Data;

                if math.abs(v32 - v33) > 0.25 then
                    if p25 then
                        Ref:Emit(Data.EmitCount or 1);
                    end;
                else
                    local OriginalRate = Data.OriginalRate;
                    Ref.Rate = math.min(OriginalRate * v35 / v34, OriginalRate);
                    Ref.Enabled = p25;
                end;

                if p25 then
                    local OriginalBrightness = Data.OriginalBrightness;
                    Ref.Brightness = math.min(OriginalBrightness * v35 / v34 / 4, OriginalBrightness);
                    Ref.TimeScale = v32;
                    local v37 = v.Class == "Bass" and 6 or 10;
                    local Keypoints = Data.BaseSize.Keypoints;
                    local Keypoints2 = Data.Size.Keypoints;
                    v36 = v;

                    for i, v2 in ipairs(Keypoints2) do
                        local math_min_ret = math.min(Keypoints[i].Value * v35, v37);
                        Keypoints2[i] = NumberSequenceKeypoint.new(v2.Time, v2.Value * 0.6599999999999999 + math_min_ret * 0.34);
                    end;

                    Data.Size = NumberSequence.new(Keypoints2);
                    Ref.Size = Data.Size;
                else
                    Ref:Clear();
                    v36 = v;
                end;
            elseif v.Type == "Beam" then
                local Ref = v.Ref;
                local Data = v.Data;
                local Width0 = Data.Width0;
                local math_min_ret = math.min(Data.BaseWidth0 * v35, 10);
                local v38 = p25 and Width0 * 0.6599999999999999 + math_min_ret * 0.34 or 0;
                Ref.Width0 = v38;
                Data.Width0 = v38;
                local Width1 = Data.Width1;
                local math_min_ret2 = math.min(Data.BaseWidth1 * v35, 10);
                local v39 = p25 and Width1 * 0.6599999999999999 + math_min_ret2 * 0.34 or 0;
                Ref.Width1 = v39;
                Data.Width1 = v39;
                Ref.TextureSpeed = math.sign(Data.BaseTextureSpeed) * math.abs(v32 * 2);
                v36 = v;
            elseif v.Type == "Bone" then
                local Ref = v.Ref;
                Ref.CFrame = Ref.CFrame * CFrame.identity:Lerp(v.Data.RotSpeed, p26 * v32);
                v36 = v;
            else
                v36 = v;
            end;

            v36.Enabled = p25;
        end;
    end;
end;

InstanceAddedSignal:Connect(onEffectAdded);
InstanceRemovedSignal:Connect(function(p40: userdata) -- Line: 281, Name: onEffectRemoved
    -- upvalues: u2 (copy)
    u2[p40] = nil;
end);

for _, v in CollectionService:GetTagged("RelicsAuraFx") do
    task.spawn(onEffectAdded, v);
end;

return v1;