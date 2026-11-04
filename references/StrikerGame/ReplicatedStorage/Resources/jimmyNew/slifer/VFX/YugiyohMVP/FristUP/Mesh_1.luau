 
 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");

local function getTweenInfo(p1: userdata, p2: string) -- Line: 7
    local v3 = p1:GetAttribute("Duration") or 0.1;
    local v4 = p1:GetAttribute(p2) or "";
    local string_split_ret = string.split(v4);

    return TweenInfo.new(v3, string_split_ret[1] and Enum.EasingStyle[string_split_ret[1]] or Enum.EasingStyle.Linear, string_split_ret[1] and Enum.EasingDirection[string_split_ret[2]] or Enum.EasingDirection.In);
end;

local function tweenMesh(p5: userdata) -- Line: 18
    -- upvalues: getTweenInfo (copy), TweenService (copy), Debris (copy)
    local End = p5:FindFirstChild("End");
    local Start = p5:FindFirstChild("Start");

    if not End then
        return;
    end;

    if not Start then
        return;
    end;

    local Attribute = p5:GetAttribute("StartTransparency");
    local Attribute2 = p5:GetAttribute("Duration");
    local v6 = End:Clone();
    local v7 = Start:Clone();
    v7.Anchored = true;
    v7.Locked = true;
    v7.Parent = workspace.Camera;

    if Attribute then
        if v7:IsA("MeshPart") then
            v7.Transparency = Attribute;

            if v7:FindFirstChildOfClass("Decal") then
                v7:FindFirstChildOfClass("Decal").Transparency = Attribute;
            end;
        elseif v7:IsA("BasePart") and v7:FindFirstChildOfClass("Decal") then
            v7:FindFirstChildOfClass("Decal").Transparency = Attribute;
        end;
    end;

    local v8 = getTweenInfo(p5, "Part_TweenParams");

    if v8 then
        TweenService:Create(v7, v8, {
            Transparency = 1,
            CFrame = v6.CFrame,
            Size = v6.Size
        }):Play();
    end;

    local v9 = getTweenInfo(p5, "Mesh_TweenParams");

    if v9 and (v7:FindFirstChildOfClass("SpecialMesh") and v6:FindFirstChildOfClass("SpecialMesh")) then
        TweenService:Create(v7:FindFirstChildOfClass("SpecialMesh"), v9, {
            Scale = v6:FindFirstChildOfClass("SpecialMesh").Scale
        }):Play();
    end;

    local v10 = getTweenInfo(p5, "Decal_TweenParams");

    if v10 and v7:FindFirstChildOfClass("Decal") then
        TweenService:Create(v7:FindFirstChildOfClass("Decal"), v10, {
            Transparency = 1
        }):Play();
    end;

    Debris:AddItem(v6);
    Debris:AddItem(v7, Attribute2);
end;

return function(p11: userdata) -- Line: 65
    -- upvalues: tweenMesh (copy)
    if p11:FindFirstChild("Start") and p11:FindFirstChild("End") then
        tweenMesh(p11);

        return;
    end;

    for _, child in p11:GetChildren() do
        if child:IsA("Model") then
            tweenMesh(child);
        end;
    end;
end;