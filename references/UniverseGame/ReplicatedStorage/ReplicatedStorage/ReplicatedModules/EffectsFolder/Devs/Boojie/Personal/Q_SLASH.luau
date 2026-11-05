  

 

local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage"):FindFirstChild("Client Assets");
local FlipbookSlash = u1["Cursed Child"].FlipbookSlash;

return function(p2) -- Line: 8
    -- upvalues: u1 (copy), FlipbookSlash (copy), TweenService (copy)
    local AttachTo = p2.AttachTo;
    local Origin = p2.Origin;

    if Origin and Origin:IsA("BasePart") then
        Origin = Origin.CFrame;
    elseif not Origin and AttachTo then
        Origin = AttachTo.CFrame;
    end;

    local v3 = p2.StartOffset or CFrame.identity;
    local v4 = p2.EndOffset or (v3 or CFrame.identity);
    local v5 = p2.Size or Vector3.new(8, 16, 8);
    local v6 = Origin * v3;
    local v7 = v6 * v4;
    local v8 = p2.Time or 0.2;
    local v9 = p2.SurfaceDirection or "Bottom";
    local v10 = p2.Color or Color3.fromRGB(255, 255, 255);
    local v11 = p2.Flipbook or u1["Cursed Child"].SlashBook;
    local v12 = v11:GetChildren();
    local v13 = v8 / #v12;
    local v14 = (p2.SlashMesh or FlipbookSlash):Clone();
    v14.CFrame = v6;
    local v15;

    if AttachTo then
        v15 = Instance.new("Weld");
        v15.Part0 = AttachTo;
        v15.Part1 = v14;
        v15.C0 = v3;
        v15.Parent = v14;
        v14.Anchored = false;
        v14.Massless = true;
        v14.CanTouch = false;
        v14.CanQuery = false;
    else
        v15 = nil;
    end;

    v14.Decal.Face = v9;
    v14.Decal.Color3 = v10;
    v14.Mesh.Scale = v5;
    v14.Parent = workspace.Effects;
    task.delay(v8 * 5, v14.Destroy, v14);

    for i = 1, #v12 do
        local v16 = task.wait(v13);

        if not v14:IsDescendantOf(game) then
            break;
        end;

        v14.Decal.Texture = v11[tostring(i)].Texture;

        if AttachTo then
            TweenService:Create(v15, TweenInfo.new(v16, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                C0 = v3:Lerp(v3 * v4, i / #v12)
            }):Play();
        else
            TweenService:Create(v14, TweenInfo.new(v16, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                CFrame = v6:Lerp(v7, i / #v12)
            }):Play();
        end;
    end;

    v14:Destroy();
end;