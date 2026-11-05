  

 

local function VisualizePart(p1, p2, p3) -- Line: 1
    local Part = Instance.new("Part");

    if typeof(p1) == "Vector3" then
        p1 = CFrame.new(p1) or p1;
    end;

    Part.CFrame = p1;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Color = p3 and Color3.new(0.25, 0.8, 0.25) or Color3.fromRGB(0, 0, 255);
    Part.Material = "ForceField";
    Part.CastShadow = false;

    if typeof(p2) == "number" then
        Part.Shape = Enum.PartType.Ball;
        Part.Size = Vector3.new(p2, p2, p2) * 2;
    elseif typeof(p2) == "Vector3" then
        Part.Size = p2;
    end;

    Part.Parent = workspace.Effects;
    task.delay(0.2, function() -- Line: 18
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

local LocalPlayer = game.Players.LocalPlayer;

return function(p4, p5, p6) -- Line: 25
    -- upvalues: LocalPlayer (copy), VisualizePart (copy)
    local v7 = {};
    local Character = LocalPlayer.Character;

    if not (Character and (Character:IsDescendantOf(workspace) and Character:FindFirstChild("HumanoidRootPart"))) then
        return v7;
    end;

    local HumanoidRootPart = Character.HumanoidRootPart;
    local v8 = p4 or (p5.HitboxType or p6.HitboxType);
    local Info = p6.Info;

    if (v8 == "ClientHitbox" and "NetworkCast" or v8) == "NetworkCast" then
        if Info.Part then
            if Info.Part and Info.Part:IsDescendantOf(workspace) then
                local v9 = Info.Part:Clone();
                v9.Parent = workspace.Effects;
                local v10 = OverlapParams.new();
                v10.FilterType = Info.Parameters and Info.Parameters.FilterType or Enum.RaycastFilterType.Include;
                v10.FilterDescendantsInstances = Info.Parameters and Info.Parameters.FilterDescendantsInstances or { workspace.Living };
                v10.CollisionGroup = Info.Parameters and (Info.Parameters.CollisionGroup or "Raycast") or "Raycast";
                v10.MaxParts = Info.Parameters and Info.Parameters.MaxParts or 0;
                v7 = workspace:GetPartsInPart(v9, v10);
                task.defer(v9.Destroy, v9);
            end;
        else
            if type(Info.OriginPart) == "string" and not Character:FindFirstChild(Info.OriginPart, true) then
                return v7;
            end;

            if typeof(Info.OriginPart) == "Instance" and not Info.OriginPart:IsDescendantOf(workspace) then
                return v7;
            end;

            local v11 = nil;

            if type(Info.OriginPart) == "string" then
                v11 = Character:FindFirstChild(Info.OriginPart, true);
            elseif typeof(Info.OriginPart) == "Instance" then
                v11 = Info.OriginPart;
            end;

            local CFrame2 = (v11 or HumanoidRootPart).CFrame;

            if Info.Offset then
                CFrame2 = CFrame2 * Info.Offset;
            end;

            if Info.ClientOrigin then
                CFrame2 = Info.ClientOrigin;
            end;

            local v12 = OverlapParams.new();
            v12.FilterType = Info.Parameters and Info.Parameters.FilterType or Enum.RaycastFilterType.Include;
            v12.FilterDescendantsInstances = Info.Parameters and Info.Parameters.FilterDescendantsInstances or { workspace.Living };
            v12.CollisionGroup = Info.Parameters and (Info.Parameters.CollisionGroup or "Raycast") or "Raycast";
            v12.MaxParts = Info.Parameters and (Info.Parameters.MaxParts or 0) or 0;
            local Size = Info.Size;

            if typeof(Size) == "number" then
                v7 = workspace:GetPartBoundsInRadius(CFrame2.Position, Size, v12);
            elseif typeof(Size) == "Vector3" then
                v7 = workspace:GetPartBoundsInBox(CFrame2, Size, v12);
            end;

            for i = #v7, 1, -1 do
                if v7[i]:IsDescendantOf(Character) then
                    table.remove(v7, i);
                end;
            end;

            local Settings = LocalPlayer:FindFirstChild("Settings");

            if Info.Debug or Settings and Settings.HitboxDisplay.Value then
                VisualizePart(CFrame2, Size);

                return v7;
            end;
        end;
    end;

    return v7;
end;