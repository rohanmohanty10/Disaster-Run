  

 

game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = Random.new();

local function ProjectOnPlane(p3, p4) -- Line: 14
    return p3 - p4 * p3:Dot(p4);
end;

local function SamplePlanarDirection(p5, p6, p7, p8, p9) -- Line: 18
    -- upvalues: u2 (copy)
    local v10 = u2:NextNumber(-1, 1);
    local v11 = u2:NextNumber(-1, 1);
    local v12 = p6 * v10 + p7 * v11;
    local v13 = v12 - p5 * v12:Dot(p5);

    if v13.Magnitude >= 0.001 then
        p6 = v13.Unit;
    end;

    local v14 = p6 + p8 * p9;
    local v15 = v14 - p5 * v14:Dot(p5);

    if v15.Magnitude < 0.001 then
        return p6;
    end;

    return v15.Unit;
end;

local function SampleRadius(p16, p17, p18) -- Line: 40
    -- upvalues: u2 (copy)
    local v19 = u2:NextNumber();
    local v20 = ((math.sqrt(p16 * p16 + (p17 * p17 - p16 * p16) * v19) - p16) / math.max(1e-6, p17 - p16)) ^ (p18 or 1);

    return math.lerp(p16, p17, v20);
end;

local u21 = {
    SurfaceNormal = Vector3.new(0, 0, 0),
    ImpactDirection = Vector3.new(0, 0, 0),
    DirectionBias = 1,
    ForwardHeightScale = 2.5,
    ForwardLift = 0,
    AngleJitter = 0.25,
    PlanarNoise = 0.8,
    Count = 10,
    SizeMultiplier = 0.25,
    HeightPower = 3,
    Lifetime = 1,
    RadiusMin = 1,
    RadiusMax = 5,
    RadiusBias = 0.9,
    CastUp = 2,
    CastDown = 10,
    Origin = CFrame.identity
};
local Part = Instance.new("Part");
Part.Anchored = true;
Part.CastShadow = false;
Part.CanCollide = false;
Part.BottomSurface = Enum.SurfaceType.Smooth;
Part.TopSurface = Enum.SurfaceType.Smooth;

return function(p22) -- Line: 83, Name: SpawnDirectionalDebris
    -- upvalues: u21 (copy), u2 (copy), SamplePlanarDirection (copy), u1 (copy), Part (copy), TweenService (copy)
    local u23 = p22.Origin or u21.Origin;
    local v24 = p22.Count or u21.Count;
    local u25 = p22.Lifetime or u21.Lifetime;
    local v26 = p22.SizeMultiplier or u21.SizeMultiplier;
    local v27 = p22.RadiusMin or u21.RadiusMin;
    local v28 = p22.RadiusMax or u21.RadiusMax;
    local v29 = p22.RadiusBias or u21.RadiusBias;
    local v30 = p22.ImpactDirection or u23.LookVector;
    local u31 = p22.SurfaceNormal or u23.UpVector;
    local v32 = p22.CastUp or 10;
    local v33 = p22.CastDown or 35;
    local Unit = u31:Cross(math.abs(u31.Y) < 0.99 and Vector3.new(0, 1, 0) or Vector3.new(1, 0, 0)).Unit;
    local Unit2 = Unit:Cross(u31).Unit;
    local v34 = v30 - u31 * v30:Dot(u31);
    local v35 = v34.Magnitude / math.max(v30.Magnitude, 1e-6);
    local v36 = math.clamp(v35, 0, 1);
    local v37 = v34.Magnitude > 0.001 and v34.Unit or Vector3.new(0, 0, 0);
    local v38 = (p22.DirectionBias or 1.2) * v36;
    local v39 = (p22.ForwardHeightScale or 2) * v36;
    local v40 = (p22.ForwardLift or 1) * v36;
    local v41 = p22.AngleJitter or u21.AngleJitter;
    local v42 = p22.PlanarNoise or u21.PlanarNoise;

    if not p22.ForwardHeightScale then
        local _ = u21.ForwardHeightScale;
    end;

    local v43 = p22.HeightPower or u21.HeightPower;
    local Folder = Instance.new("Folder");
    Folder.Name = "DB";
    Folder.Parent = workspace.Effects;
    task.delay(u25 * 2, Folder.Destroy, Folder);

    for _ = 1, v24 do
        local v44 = u2:NextNumber();
        local v45 = ((math.sqrt(v27 * v27 + (v28 * v28 - v27 * v27) * v44) - v27) / math.max(1e-6, v28 - v27)) ^ (v29 or 1);
        local v46 = math.lerp(v27, v28, v45);
        local v47 = SamplePlanarDirection(u31, Unit, Unit2, v37, v38);
        local v48 = u2:NextNumber(-1, 1) * v41;
        local v49 = u2:NextNumber(-1, 1) * v41;
        local v50 = v47 + (Unit * v48 + Unit2 * v49);
        local Unit3 = (v50 - u31 * v50:Dot(u31)).Unit;
        local v51 = Unit3 * v46 + Unit3 * u2:NextNumber(-v42, v42);
        local u52 = workspace:Raycast(u23.Position + u31 * v32 + v51, -u31 * v33, u1);

        if u52 then
            local v53;

            if v36 > 0 then
                local v54 = Unit3:Dot(v37);
                v53 = math.clamp(v54, -1, 1) or 0;
            else
                v53 = 0;
            end;

            local v55 = math.max(0, v53) ^ v43;
            local v56 = (0.8 + 2.2 * ((v46 - v27) / math.max(1e-6, v28 - v27))) * v26;
            local u57 = Instance.fromExisting(Part);
            u57.Color = u52.Instance.Color;
            u57.Material = u52.Instance.Material;
            u57.Parent = Folder;
            local v58 = v56 * u2:NextNumber(0.7, 1.4);
            local v59 = v56 * u2:NextNumber(0.7, 1.4);
            local v60 = Vector3.new(v58, v56, v59);
            local _ = v55 * v40;
            u57.Size = Vector3.new(v60.X, v60.Y * (1 + v55 * v39), v60.Z);
            local Position = u52.Position;
            u57.CFrame = CFrame.lookAt(Position, u23.Position + u31 * 1000, u31) - u31 * u57.Size.X;
            task.spawn(function() -- Line: 180
                -- upvalues: u2 (ref), TweenService (ref), u57 (copy), Position (copy), u23 (copy), u31 (copy), u52 (copy), u25 (copy)
                local v61 = u2:NextNumber(0.08, 0.125);
                TweenService:Create(u57, TweenInfo.new(v61, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
                    CFrame = CFrame.lookAt(Position, u23.Position + u31 * 40, u31)
                }):Play();
                local v62 = u52.Instance:FindFirstChildOfClass("Texture") or u52.Instance:FindFirstChildOfClass("Decal");

                if v62 then
                    for _, v in { "Front", "Back", "Bottom", "Left", "Right", "Top" } do
                        local v63 = Instance.fromExisting(v62);
                        v63.Face = v;
                        v63.Parent = u57;
                    end;
                end;

                task.wait(v61);
                TweenService:Create(u57, TweenInfo.new(u25 * u2:NextNumber(1, 2), Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), {
                    Position = u57.Position - u31 * u57.Size.Magnitude
                }):Play();
                task.delay(u25 * 2, u57.Destroy, u57);
            end);
        end;
    end;
end;