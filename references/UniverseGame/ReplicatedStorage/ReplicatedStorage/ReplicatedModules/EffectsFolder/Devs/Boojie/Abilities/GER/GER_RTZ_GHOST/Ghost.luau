  

 

local u1 = {
    GhostModel = workspace
};
u1.__index = u1;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u2 = { "Head", "HumanoidRootPart", "Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg", "UpperTorso", "LowerTorso", "LeftUpperArm", "LeftLowerArm", "LeftHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperArm", "RightLowerArm", "RightHand", "RightUpperLeg", "RightLowerLeg", "RightFoot" };

local function Lerp(p3, p4, p5) -- Line: 41
    return p3 + (p4 - p3) * p5;
end;

function u1.new(p6, p7) -- Line: 45
    -- upvalues: u1 (copy), u2 (copy), Trove (copy)
    local u8 = setmetatable({}, u1);
    u8.Character = p6;
    u8.RootPart = p7 or p6:WaitForChild("HumanoidRootPart", 1);
    u8.PartList = u2;

    if u8.RootPart then
        u8.Janitor = Trove.new();
        u8.GhostCharacter = Instance.new("Model");
        u8.GhostCharacter.Name = u8.Character.Name;
        u8.GhostCharacter.Parent = u8.GhostModel;
        u8.GhostParts = {};
        u8.Objects = {};
        u8.CFrames = {};
        u8.Janitor:Add(u8.GhostCharacter);

        for _, descendant in pairs(u8.Character:GetDescendants()) do
            if descendant:IsA("BasePart") and u8:IsValid(descendant) then
                u8:AddPart(descendant);
            end;
        end;

        u8.Janitor:Add(u8.Character.DescendantAdded:Connect(function(p9) -- Line: 73
            -- upvalues: u8 (copy)
            if p9:IsA("BasePart") and u8:IsValid(p9) then
                u8:AddPart(p9);
            end;
        end));
        u8.Janitor:Add(u8.Character.DescendantRemoving:Connect(function(p10) -- Line: 78
            -- upvalues: u8 (copy)
            if p10:IsA("BasePart") then
                u8:RemovePart(p10);
            end;
        end));

        return u8;
    end;
end;

function u1.IsValid(p11, p12) -- Line: 87
    return (table.find(p11.PartList, p12) or table.find(p11.PartList, p12.Name)) and true or (p12:GetAttribute("Weakpoint") and true or false);
end;

function u1.AddPart(p13, p14) -- Line: 97
    if p13.GhostParts[p14] then
        return p13.GhostParts[p14];
    end;

    local Part = Instance.new("Part");
    Part.Name = p14.Name;
    Part.Anchored = true;
    Part.CanQuery = false;
    Part.CanCollide = false;
    Part.Material = "Neon";
    Part.Color = Color3.new(0, 1, 0);

    if p14.Name == "HumanoidRootPart" then
        Part.Transparency = 1;
    else
        Part.Transparency = 0.75;
    end;

    if p14.Name == "Head" then
        Part.Size = Vector3.new(1.25, 1.25, 1.25);
    else
        Part.Size = p14.Size;
    end;

    Part.Parent = p13.GhostCharacter;
    p13.GhostParts[p14] = Part;

    return Part;
end;

function u1.RemovePart(p15, p16) -- Line: 129
    local v17 = p15.GhostParts[p16];

    if not v17 then
        return false;
    end;

    v17:Destroy();
    p15.GhostParts[p16] = nil;

    return true;
end;

function u1.Cast(p18, p19, p20) -- Line: 139
    for i, v in pairs(p18.GhostParts) do
        if i and v then
            local v21 = p19 * p18.RootPart.CFrame:ToObjectSpace(i.CFrame);

            if p20 and p20 ~= 1 then
                v21 = v.CFrame:Lerp(v21, p20);
            end;

            table.insert(p18.Objects, v);
            table.insert(p18.CFrames, v21);

            if v.Name ~= "HumanoidRootPart" then
                local Magnitude = (i.Position - v.Position).Magnitude;

                if Magnitude > 8 then
                    v.Transparency = 0.75;
                else
                    local v22 = 1 + -0.5 * math.clamp((Magnitude - 2) / 6, 0, 1);
                    v.Transparency = math.clamp(v22, 0.5, 1);
                end;
            end;
        elseif not i and v then
            v:Destroy();
            p18.GhostParts[i] = nil;
        end;

        p18.GhostModel:BulkMoveTo(p18.Objects, p18.CFrames, Enum.BulkMoveMode.FireCFrameChanged);
        table.clear(p18.Objects);
        table.clear(p18.CFrames);
    end;
end;

function u1.Destroy(p23) -- Line: 175
    p23.Janitor:Destroy();
    setmetatable(p23, nil);
end;

return u1;