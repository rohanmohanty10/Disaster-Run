  

 

local u1 = Random.new();
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local LightningBolt = require(script.Parent.Lightning.LightningBolt);
require(PathShortcuts.KnitPath.Trove);
local u2 = {
    Color = Color3.fromRGB(255, 0, 0)
};

local function CreateBolt(p3) -- Line: 14
    -- upvalues: u2 (copy), LightningBolt (copy), ParticleHandler (copy)
    local v4 = p3 or {};
    local v5 = v4.Start or Vector3.new(0, 0, 0);
    local v6 = v4.End or Vector3.new(0, 0, 0);
    local v7 = v4.Amount or 12;

    if not v4.Color then
        local _ = u2.Color;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Position = v5;
    Attachment.Archivable = false;
    Attachment.Parent = game.Workspace.Terrain;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Position = v6;
    Attachment2.Archivable = false;
    Attachment2.Parent = game.Workspace.Terrain;
    local u8 = LightningBolt.new(Attachment, Attachment2, v7);
    u8.Color = u2.Color;

    if v4.HSVShift then
        u8.Color = ParticleHandler.HSVShift(u8.Color, v4.HSVShift);
    end;

    u8.CurveSize0 = 0;
    u8.CurveSize1 = 0;
    u8.PulseSpeed = 4;
    u8.FadeLength = 0.1;
    u8.MaxRadius = 12;
    u8.Thickness = 8;
    u8.AnimationSpeed = 2;

    if v4.Info then
        for i, v in pairs(v4.Info) do
            u8[i] = v;
        end;
    end;

    return u8, function(p9, p10) -- Line: 51
        -- upvalues: u8 (copy), Attachment (copy), Attachment2 (copy)
        if getmetatable(u8) then
            u8:DestroyDissipate(p9, p10);
        end;

        Attachment:Destroy();
        Attachment2:Destroy();
    end;
end;

local function GetMultiplier() -- Line: 60
    -- upvalues: u1 (copy)
    return u1:NextInteger(0, 1) == 0 and -1 or 1;
end;

local function RandomAngle() -- Line: 64
    -- upvalues: u1 (copy)
    local v11 = u1:NextNumber(-360, 360);

    return math.rad(v11);
end;

local function GetClosestPoint(p12, p13) -- Line: 68
    local v14 = p12.CFrame:pointToObjectSpace(p13);
    local v15 = p12.Size * 0.5;
    local CFrame2 = p12.CFrame;
    local v16 = math.clamp(v14.x, -v15.x, v15.x);
    local v17 = math.clamp(v14.y, -v15.y, v15.y);
    local v18 = math.clamp(v14.z, -v15.z, v15.z);

    return CFrame2 * Vector3.new(v16, v17, v18);
end;

local function GetClosestResult(p19, p20) -- Line: 78
    -- upvalues: GetClosestPoint (copy)
    local v21 = RaycastParams.new();
    v21.FilterType = Enum.RaycastFilterType.Include;
    v21.FilterDescendantsInstances = { p19 };
    v21.IgnoreWater = true;
    local v22 = p20 + CFrame.lookAt(p19.Position, p20).LookVector * 0.1;
    local v23 = GetClosestPoint(p19, v22);
    local v24 = CFrame.lookAt(v22, v23).LookVector * ((p19.Position - v22).Magnitude + 8);

    return game.Workspace:Raycast(v22, v24, v21);
end;

local u25 = {};

return function(u26, u27) -- Line: 95
    -- upvalues: u25 (copy), u1 (copy), ParticleHandler (copy), CreateBolt (copy)
    if u27 == false then
        if u25[u26] then
            u25[u26] = nil;
        end;
    elseif u27 then
        local u28 = u25[u26];
        local u29;

        if u28 then
            u29 = false;
        else
            u28 = {};
            u25[u26] = u28;
            u29 = true;
        end;

        for i, v in pairs(u27) do
            u28[i] = v;
        end;

        local Torso = u26:FindFirstChild("Torso");
        local u30 = {
            u26:FindFirstChild("Torso"),
            u26:FindFirstChild("Left Arm"),
            u26:FindFirstChild("Right Arm"),
            u26:FindFirstChild("Left Leg"),
            u26:FindFirstChild("Right Leg"),
            u26:FindFirstChild("Head")
        };
        task.spawn(function() -- Line: 122
            -- upvalues: u29 (ref), u26 (copy), u25 (ref), u28 (ref), u1 (ref), Torso (copy), u30 (copy), u27 (copy), ParticleHandler (ref), CreateBolt (ref)
            if not u29 then
                return;
            end;

            while true do
                local v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48, v49, v50, v51, v52, v53, v54, v55, v56, v57, v58;

                while true do
                    repeat
                        if not (u26 and (u26:IsDescendantOf(game) and u25[u26])) then
                            return;
                        end;

                        task.wait(u28.Rate or 0.05);
                        v32 = u28.CoilToCharacter and not u28.CoilToPart and "Character" or ((u28.CoilToCharacter or not u28.CoilToPart) and (u1:NextInteger(1, 3) == 1 and "Character" or "Part") or "Part");
                        v33 = u28.Range or 24;

                        if not Torso then
                            break;
                        end;

                        v31 = u30[u1:NextInteger(1, #u30)];
                    until v31;

                    if v32 == "Character" then
                        v34 = OverlapParams.new();
                        v34.FilterType = Enum.RaycastFilterType.Include;
                        v34.FilterDescendantsInstances = u30;
                        v34.MaxParts = 32;
                        local v59 = table.find(v34.FilterDescendantsInstances, v31);

                        if v59 then
                            table.remove(v34.FilterDescendantsInstances, v59);
                        end;
                    else
                        v34 = OverlapParams.new();
                        v34.FilterType = Enum.RaycastFilterType.Exclude;
                        v34.FilterDescendantsInstances = { workspace.CurrentCamera, unpack(u30) };
                        v34.MaxParts = 64;
                    end;

                    if v32 == "Character" then
                        break;
                    end;

                    local v60 = workspace:GetPartBoundsInBox(v31.CFrame, v31.Size + Vector3.new(v33, v33, v33), v34);

                    if v60 then
                        v35 = {};

                        for _, v in pairs(v60) do
                            if v.Anchored and (v.Transparency < 0.95 and v.Size.Magnitude >= 3) then
                                table.insert(v35, v);
                            end;
                        end;

                        if v35 then
                            v36 = nil;
                            v37 = nil;

                            if v32 == "Character" then
                                if #v35 == 1 then
                                    v36 = v35[1];
                                else
                                    v36 = v35[u1:NextInteger(1, #v35)];
                                end;
                            elseif v32 == "Part" then
                                v38 = RaycastParams.new();
                                v38.FilterType = Enum.RaycastFilterType.Include;
                                v38.FilterDescendantsInstances = v35;
                                v38.IgnoreWater = true;

                                for _ = 1, 24 do
                                    v39 = CFrame.new(Torso.Position);
                                    v40 = CFrame.Angles;
                                    v41 = u1:NextNumber(-360, 360);
                                    v42 = math.rad(v41);
                                    v43 = u1:NextNumber(-360, 360);
                                    v44 = math.rad(v43);
                                    v45 = u1:NextNumber(-360, 360);
                                    v46 = (v39 * v40(v42, v44, (math.rad(v45)))).LookVector;
                                    v47 = workspace:Raycast(Torso.Position, v46 * (v33 + 4), v38);

                                    if v47 then
                                        v36 = v47.Instance;
                                        v37 = v47.Position;
                                        break;
                                    end;
                                end;
                            end;

                            if v36 and (v32 ~= "Part" or v37) then
                                v48 = workspace.CurrentCamera:FindFirstChild("_BlackFlash");

                                if v48 then
                                    v48 = v48:FindFirstChild("Highlight");
                                end;

                                if v48 then
                                    if u27.HSVShift then
                                        v48.OutlineColor = ParticleHandler.HSVShift(v48:GetAttribute("OriginalColor"), u27.HSVShift);
                                    else
                                        v48.OutlineColor = v48:GetAttribute("OriginalColor");
                                    end;
                                end;

                                v49, v50 = CreateBolt({
                                    HSVShift = u27.HSVShift
                                });
                                v51 = v49.Attachment0;
                                v52 = u1:NextNumber(-v31.Size.X, v31.Size.X) / 2;
                                v53 = u1:NextNumber(-v31.Size.Y, v31.Size.Y) / 2;
                                v54 = u1:NextNumber(-v31.Size.Z, v31.Size.Z) / 2;
                                v51.Position = Vector3.new(v52, v53, v54);
                                v49.Attachment0.Parent = v31;

                                if v32 == "Character" then
                                    v55 = v49.Attachment1;
                                    v56 = u1:NextNumber(-v36.Size.X, v36.Size.X) / 2;
                                    v57 = u1:NextNumber(-v36.Size.Y, v36.Size.Y) / 2;
                                    v58 = u1:NextNumber(-v36.Size.Z, v36.Size.Z) / 2;
                                    v55.Position = Vector3.new(v56, v57, v58);
                                    v49.Attachment1.Parent = v36;
                                else
                                    v49.Attachment1.Parent = v36;
                                    v49.Attachment1.WorldPosition = v37;
                                end;

                                v49.Attachment1.WorldCFrame = CFrame.new(v49.Attachment1.WorldPosition) * CFrame.Angles(0, 0, -1.5707963267948966);

                                if v32 == "Character" then
                                    v49.Thickness = 0.3;
                                    v49.MaxRadius = 4;
                                    v49.PulseLength = u1:NextNumber(0.25, 0.75);
                                    v49.AnimationSpeed = 12;
                                else
                                    v49.Thickness = 0.75;
                                    v49.MaxRadius = u1:NextNumber(1.5, 8);
                                    v49.PulseLength = 2;
                                    v49.PulseSpeed = 8;
                                    v49.CurveSize0 = 0;
                                    v49.CurveSize1 = v49.MaxRadius;
                                    v49.Frequency = 0.25;
                                    v49.AnimationSpeed = 8;
                                end;

                                v49.Enabled = true;
                                task.delay(v49.PulseLength + 0.5, v50);
                            end;
                        end;
                    end;
                end;

                v35 = workspace:GetPartBoundsInBox(v31.CFrame, v31.Size + Vector3.new(1, 1, 1), v34);

                if v35 and #v35 ~= 1 then
                    if v35 then
                        v36 = nil;
                        v37 = nil;

                        if v32 == "Character" then
                            if #v35 == 1 then
                                v36 = v35[1];
                            else
                                v36 = v35[u1:NextInteger(1, #v35)];
                            end;
                        elseif v32 == "Part" then
                            v38 = RaycastParams.new();
                            v38.FilterType = Enum.RaycastFilterType.Include;
                            v38.FilterDescendantsInstances = v35;
                            v38.IgnoreWater = true;

                            for _ = 1, 24 do
                                v39 = CFrame.new(Torso.Position);
                                v40 = CFrame.Angles;
                                v41 = u1:NextNumber(-360, 360);
                                v42 = math.rad(v41);
                                v43 = u1:NextNumber(-360, 360);
                                v44 = math.rad(v43);
                                v45 = u1:NextNumber(-360, 360);
                                v46 = (v39 * v40(v42, v44, (math.rad(v45)))).LookVector;
                                v47 = workspace:Raycast(Torso.Position, v46 * (v33 + 4), v38);

                                if v47 then
                                    v36 = v47.Instance;
                                    v37 = v47.Position;
                                    break;
                                end;
                            end;
                        end;

                        if v36 and (v32 ~= "Part" or v37) then
                            v48 = workspace.CurrentCamera:FindFirstChild("_BlackFlash");

                            if v48 then
                                v48 = v48:FindFirstChild("Highlight");
                            end;

                            if v48 then
                                if u27.HSVShift then
                                    v48.OutlineColor = ParticleHandler.HSVShift(v48:GetAttribute("OriginalColor"), u27.HSVShift);
                                else
                                    v48.OutlineColor = v48:GetAttribute("OriginalColor");
                                end;
                            end;

                            v49, v50 = CreateBolt({
                                HSVShift = u27.HSVShift
                            });
                            v51 = v49.Attachment0;
                            v52 = u1:NextNumber(-v31.Size.X, v31.Size.X) / 2;
                            v53 = u1:NextNumber(-v31.Size.Y, v31.Size.Y) / 2;
                            v54 = u1:NextNumber(-v31.Size.Z, v31.Size.Z) / 2;
                            v51.Position = Vector3.new(v52, v53, v54);
                            v49.Attachment0.Parent = v31;

                            if v32 == "Character" then
                                v55 = v49.Attachment1;
                                v56 = u1:NextNumber(-v36.Size.X, v36.Size.X) / 2;
                                v57 = u1:NextNumber(-v36.Size.Y, v36.Size.Y) / 2;
                                v58 = u1:NextNumber(-v36.Size.Z, v36.Size.Z) / 2;
                                v55.Position = Vector3.new(v56, v57, v58);
                                v49.Attachment1.Parent = v36;
                            else
                                v49.Attachment1.Parent = v36;
                                v49.Attachment1.WorldPosition = v37;
                            end;

                            v49.Attachment1.WorldCFrame = CFrame.new(v49.Attachment1.WorldPosition) * CFrame.Angles(0, 0, -1.5707963267948966);

                            if v32 == "Character" then
                                v49.Thickness = 0.3;
                                v49.MaxRadius = 4;
                                v49.PulseLength = u1:NextNumber(0.25, 0.75);
                                v49.AnimationSpeed = 12;
                            else
                                v49.Thickness = 0.75;
                                v49.MaxRadius = u1:NextNumber(1.5, 8);
                                v49.PulseLength = 2;
                                v49.PulseSpeed = 8;
                                v49.CurveSize0 = 0;
                                v49.CurveSize1 = v49.MaxRadius;
                                v49.Frequency = 0.25;
                                v49.AnimationSpeed = 8;
                            end;

                            v49.Enabled = true;
                            task.delay(v49.PulseLength + 0.5, v50);
                        end;
                    end;
                end;
            end;
        end);
    end;
end;