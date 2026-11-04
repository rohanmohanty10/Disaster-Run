 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local GearCatalog = require(ChickenOrHero:WaitForChild("Gear"):WaitForChild("GearCatalog"));
local ParticipantDirectory = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ParticipantDirectory"));
local Lifeline = game:GetService("ReplicatedStorage"):WaitForChild("Lifeline", 30);
local u1 = GearCatalog.Items.Lifeline.ThrowSeconds or 0.35;
local Burlap = BrickColor.new("Burlap");
local CFrame_Angles_ret = CFrame.Angles(0, 0, 1.5707963267948966);
local Folder = Instance.new("Folder");
Folder.Name = "Lifelines";
Folder.Parent = workspace;
local u2 = {};

local function now() -- Line: 27
    local ServerTimeNow = workspace:GetServerTimeNow();

    if ServerTimeNow > 1000000000 then
        return ServerTimeNow;
    end;

    return os.time();
end;

local function targetCharacter(p3) -- Line: 32
    -- upvalues: Players (copy), ParticipantDirectory (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p3);

    if PlayerByUserId then
        return PlayerByUserId.Character;
    end;

    for _, v in ParticipantDirectory.list() do
        if v.UserId == p3 and v.Character then
            return v.Character;
        end;
    end;

    local ClientBots = workspace:FindFirstChild("ClientBots");

    for _, v in ClientBots and ClientBots:GetChildren() or {} do
        if v:GetAttribute("BotUserId") == p3 then
            return v;
        end;
    end;

    return nil;
end;

local function remove(p4) -- Line: 52
    -- upvalues: u2 (copy)
    local v5 = u2[p4];

    if not v5 then
        return;
    end;

    u2[p4] = nil;

    for _, v in { v5.rope, v5.handEnd, v5.ring } do
        if v then
            v:Destroy();
        end;
    end;
end;

local function create(p6, p7, p8) -- Line: 65
    -- upvalues: Lifeline (copy), Folder (copy), Burlap (copy), u2 (copy)
    if not Lifeline then
        return;
    end;

    local v9 = Lifeline:Clone();
    v9.Name = "Lifeline";

    for _, descendant in v9:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.CastShadow = false;
        end;
    end;

    v9:ScaleTo(v9:GetScale() * 0.8);
    v9.Parent = Folder;
    local v10 = v9:FindFirstChildWhichIsA("BasePart");
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "RopeEnd";
    Attachment.Parent = v10;
    local v11 = p6:FindFirstChild("Right Arm") or (p6:FindFirstChild("RightHand") or p6:FindFirstChild("HumanoidRootPart"));

    if not v11 then
        v9:Destroy();

        return;
    end;

    local Part = Instance.new("Part");
    Part.Name = "LifelineHand";
    Part.Size = Vector3.new(0.1, 0.1, 0.1);
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CFrame = v11.CFrame * CFrame.new(0, -v11.Size.Y / 2, 0);
    Part.Parent = Folder;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = Part;
    local RopeConstraint = Instance.new("RopeConstraint");
    RopeConstraint.Name = "LifelineRope";
    RopeConstraint.Attachment0 = Attachment2;
    RopeConstraint.Attachment1 = Attachment;
    RopeConstraint.Visible = true;
    RopeConstraint.Color = Burlap;
    RopeConstraint.Thickness = 0.2;
    RopeConstraint.Length = 1;
    RopeConstraint.Parent = Part;
    u2[p6] = {
        ring = v9,
        handEnd = Part,
        rope = RopeConstraint,
        arm = v11,
        targetId = p7,
        at = p8
    };
end;

local function scan() -- Line: 117
    -- upvalues: u2 (copy), remove (copy), Players (copy), create (copy)
    for i, v in u2 do
        if not (i.Parent and (i:GetAttribute("LifelineTargetId") == v.targetId and v.arm.Parent)) then
            remove(i);
        end;
    end;

    for _, v in Players:GetPlayers() do
        local Character = v.Character;
        local v12;

        if Character then
            v12 = Character:GetAttribute("LifelineTargetId");
        else
            v12 = Character;
        end;

        if type(v12) == "number" and not u2[Character] then
            local Attribute = Character:GetAttribute("LifelineAt");

            if not Attribute then
                Attribute = workspace:GetServerTimeNow();

                if Attribute <= 1000000000 then
                    Attribute = os.time();
                end;
            end;

            create(Character, v12, Attribute);
        end;
    end;
end;

local u13 = 0;
local u20 = RunService.RenderStepped:Connect(function(p14) -- Line: 133
    -- upvalues: u13 (ref), scan (copy), u2 (copy), targetCharacter (copy), CFrame_Angles_ret (copy), u1 (copy), Burlap (copy)
    u13 = u13 + p14;

    if u13 >= 0.15 then
        u13 = 0;
        scan();
    end;

    if not next(u2) then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    if ServerTimeNow <= 1000000000 then
        ServerTimeNow = os.time();
    end;

    for i, v in u2 do
        local v15 = targetCharacter(v.targetId);

        if v15 then
            v15 = v15:FindFirstChild("Torso") or (v15:FindFirstChild("UpperTorso") or v15:FindFirstChild("HumanoidRootPart"));
        end;

        if v15 then
            local v16 = v15.CFrame * CFrame_Angles_ret;
            local math_clamp_ret = math.clamp((ServerTimeNow - v.at) / u1, 0, 1);

            if math_clamp_ret < 1 and v.arm.Parent then
                local v17 = (v.arm.CFrame * CFrame.new(0, -v.arm.Size.Y / 2, 0)).Position:Lerp(v16.Position, math_clamp_ret) + Vector3.new(0, 1, 0) * (math_clamp_ret * 12 * (1 - math_clamp_ret));
                v.ring:PivotTo(CFrame.new(v17) * v16.Rotation * CFrame.Angles(12.566370614359172 * (1 - math_clamp_ret), 0, 0));
            else
                v.ring:PivotTo(v16);
            end;
        end;

        if v.arm.Parent then
            v.handEnd.CFrame = v.arm.CFrame * CFrame.new(0, -v.arm.Size.Y / 2, 0);
        end;

        v.rope.Length = math.max(0.5, (v.handEnd.Position - v.rope.Attachment1.WorldPosition).Magnitude * 1.025);
        local v18 = i:GetAttribute("LifelineCuts") or 0;

        if v18 ~= v.cuts then
            v.cuts = v18;
            v.rope.Thickness = (1 - math.min(v18, 2) * 0.28) * 0.2;
            local rope = v.rope;
            local v19;

            if v18 >= 2 then
                v19 = BrickColor.new("Dirt brown");
            elseif v18 == 1 then
                v19 = BrickColor.new("Brown");
            else
                v19 = Burlap;
            end;

            rope.Color = v19;
        end;
    end;
end);
script.Destroying:Connect(function() -- Line: 173
    -- upvalues: u20 (copy), u2 (copy), remove (copy), Folder (copy)
    u20:Disconnect();

    for i in u2 do
        remove(i);
    end;

    Folder:Destroy();
end);