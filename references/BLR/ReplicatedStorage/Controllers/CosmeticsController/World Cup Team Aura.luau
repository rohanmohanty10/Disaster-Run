  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local v1 = {};
local WorldCupTeamAura = ReplicatedStorage.Assets.Misc.WorldCupTeamAura;

local function createEffects(p2, p3) -- Line: 10
    local Attribute = p3:GetAttribute("ReferenceCFrame");
    local Effects = p3:FindFirstChild("Effects");

    if typeof(Attribute) ~= "CFrame" or not (Effects and Effects:IsA("Model")) then
        return nil;
    end;

    local v4 = Effects:Clone();

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("JointInstance") or (descendant:IsA("WeldConstraint") or descendant:IsA("RigidConstraint")) then
            descendant:Destroy();
        end;
    end;

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Massless = true;
            descendant.CastShadow = false;
            descendant:PivotTo(p2.CFrame * Attribute:ToObjectSpace(descendant.CFrame));
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = p2;
            WeldConstraint.Part1 = descendant;
            WeldConstraint.Parent = descendant;
        end;
    end;

    return v4;
end;

function v1.SetupCosmetic(p5, p6) -- Line: 44
    -- upvalues: Players (copy), CollectionService (copy), WorldCupTeamAura (copy), createEffects (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p5);
    local HumanoidRootPart = p5:FindFirstChild("HumanoidRootPart");

    if not (PlayerFromCharacter and HumanoidRootPart) then
        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "WorldCupTeamAura";
    Folder.Parent = HumanoidRootPart;
    CollectionService:AddTag(Folder, (`Cosmetic{p6}`));
    local u7 = nil;

    local function refreshTeamAura() -- Line: 57
        -- upvalues: Folder (copy), PlayerFromCharacter (copy), u7 (ref), WorldCupTeamAura (ref), createEffects (ref), HumanoidRootPart (copy)
        if not Folder.Parent then
            return;
        end;

        local Attribute = PlayerFromCharacter:GetAttribute("U20WorldTournamentTeam");

        if Attribute == u7 then
            return;
        end;

        u7 = Attribute;
        local Effects = Folder:FindFirstChild("Effects");

        if Effects then
            Effects:Destroy();
        end;

        local v8;

        if type(Attribute) == "string" then
            v8 = WorldCupTeamAura.Teams:FindFirstChild(Attribute);
        else
            v8 = false;
        end;

        if not v8 then
            return;
        end;

        local v9 = createEffects(HumanoidRootPart, v8);

        if v9 then
            v9.Parent = Folder;
        end;
    end;

    local u10 = PlayerFromCharacter:GetAttributeChangedSignal("U20WorldTournamentTeam"):Connect(refreshTeamAura);
    Folder.Destroying:Once(function() -- Line: 85
        -- upvalues: u10 (copy)
        u10:Disconnect();
    end);
    refreshTeamAura();
end;

return v1;