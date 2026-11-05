  

 

local u1 = {
    GhostModel = workspace
};
u1.__index = u1;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u2 = { "Head", "HumanoidRootPart", "Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg", "UpperTorso", "LowerTorso", "LeftUpperArm", "LeftLowerArm", "LeftHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperArm", "RightLowerArm", "RightHand", "RightUpperLeg", "RightLowerLeg", "RightFoot" };

function u1.new(p3, p4) -- Line: 41
    -- upvalues: u1 (copy), u2 (copy), Trove (copy)
    local u5 = setmetatable({}, u1);
    u5.Character = p3;
    u5.RootPart = p4 or p3:WaitForChild("HumanoidRootPart");
    u5.PartList = u2;
    u5.Janitor = Trove.new();
    u5.GhostCharacter = Instance.new("Model");
    u5.GhostCharacter.Name = u5.Character.Name;
    u5.GhostCharacter.Parent = u5.GhostModel;
    u5.GhostParts = {};
    u5.Objects = {};
    u5.CFrames = {};
    u5.Janitor:Add(u5.GhostCharacter);

    for _, descendant in pairs(u5.Character:GetDescendants()) do
        if descendant:IsA("BasePart") and u5:IsValid(descendant) then
            u5:AddPart(descendant);
        end;
    end;

    u5.Janitor:Add(u5.Character.DescendantAdded:Connect(function(p6) -- Line: 67
        -- upvalues: u5 (copy)
        if p6:IsA("BasePart") and u5:IsValid(p6) then
            u5:AddPart(p6);
        end;
    end));
    u5.Janitor:Add(u5.Character.DescendantRemoving:Connect(function(p7) -- Line: 72
        -- upvalues: u5 (copy)
        if p7:IsA("BasePart") then
            u5:RemovePart(p7);
        end;
    end));

    return u5;
end;

function u1.IsValid(p8, p9) -- Line: 81
    return (table.find(p8.PartList, p9) or table.find(p8.PartList, p9.Name)) and true or (p9:GetAttribute("Weakpoint") and true or false);
end;

function u1.AddPart(p10, p11) -- Line: 91
    if p10.GhostParts[p11] then
        return p10.GhostParts[p11];
    end;

    local Part = Instance.new("Part");
    Part.Name = p11.Name;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Material = "Neon";
    Part.Color = Color3.new(1, 0, 0);
    Part.Transparency = 0.5;

    if p11.Name == "Head" then
        Part.Size = Vector3.new(1.25, 1.25, 1.25);
    else
        Part.Size = p11.Size;
    end;

    Part.Parent = p10.GhostCharacter;
    p10.GhostParts[p11] = Part;

    return Part;
end;

function u1.RemovePart(p12, p13) -- Line: 118
    local v14 = p12.GhostParts[p13];

    if not v14 then
        return false;
    end;

    v14:Destroy();
    p12.GhostParts[p13] = nil;

    return true;
end;

function u1.Cast(p15, p16, p17) -- Line: 128
    for i, v in pairs(p15.GhostParts) do
        if i and v then
            local v18 = p16 * p15.RootPart.CFrame:ToObjectSpace(i.CFrame);

            if p17 and p17 ~= 1 then
                v18 = v.CFrame:Lerp(v18, p17);
            end;

            table.insert(p15.Objects, v);
            table.insert(p15.CFrames, v18);
        elseif not i and v then
            v:Destroy();
            p15.GhostParts[i] = nil;
        end;

        p15.GhostModel:BulkMoveTo(p15.Objects, p15.CFrames, Enum.BulkMoveMode.FireCFrameChanged);
        table.clear(p15.Objects);
        table.clear(p15.CFrames);
    end;
end;

function u1.Destroy(p19) -- Line: 152
    p19.Janitor:Destroy();
    setmetatable(p19, nil);
end;

return u1;