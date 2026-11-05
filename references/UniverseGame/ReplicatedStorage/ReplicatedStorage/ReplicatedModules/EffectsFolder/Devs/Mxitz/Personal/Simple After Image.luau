  

 

local TweenService = game:GetService("TweenService");
local u1 = { "BasePart", "Accessory", "Humanoid", "Shirt", "Pants", "SpecialMesh" };

local function is_instance_whitelisted(p2) -- Line: 7
    -- upvalues: u1 (copy)
    for _, v in u1 do
        if p2:IsA(v) then
            return true;
        end;
    end;

    return false;
end;

return function(p3, p4, p5) -- Line: 19
    -- upvalues: TweenService (copy), u1 (copy)
    local v6;

    if typeof(p3) == "Instance" then
        v6 = p3:IsA("Model");
    else
        v6 = false;
    end;

    assert(v6, "character must be a model");
    local v7 = p4 or 0.5;
    local v8 = p5 or p3:FindFirstChild("HumanoidRootPart").CFrame;
    local v9 = p3:Clone();
    print(v9);
    v9.Name = "AfterimageClone";
    v9:FindFirstChild("HumanoidRootPart").CFrame = v8;
    v9.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    task.wait();
    v9.Parent = workspace.Effects;
    task.delay(v7, v9.Destroy, v9);
    local v10 = {};

    for _, descendant in v9:GetDescendants() do
        if descendant.Name == "HumanoidRootPart" then
            descendant:Destroy();
        end;

        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "Ghosted";
            descendant.CanCollide = false;
            descendant.Anchored = true;
            TweenService:Create(descendant, TweenInfo.new(v7), {
                Transparency = 1
            }):Play();
            table.insert(v10, descendant);
        else
            local v11 = false;

            for _, v in u1 do
                if descendant:IsA(v) then
                    v11 = true;
                    break;
                end;
            end;

            if not v11 then
                descendant:Destroy();
            end;
        end;
    end;
end;