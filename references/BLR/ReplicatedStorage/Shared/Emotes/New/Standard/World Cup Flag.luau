  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local WorldCupFlagEmote = ReplicatedStorage.Assets.Misc.WorldCupFlagEmote;

return v1({
    animationId = "rbxassetid://132542538024949",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2) -- Line: 15, Name: effect
        -- upvalues: Trove (copy), WorldCupFlagEmote (copy), Players (copy), VfxManager (copy)
        local v3 = Trove.new();
        local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");
        local v4 = p2:FindFirstChild("Left Arm");

        if not (HumanoidRootPart and v4) then
            return v3;
        end;

        local v5 = WorldCupFlagEmote.FlagProp:Clone();
        v5.Name = "WorldCupFlagProp";
        local FlagHandle = v5:FindFirstChild("FlagHandle");
        local Flag = v5:FindFirstChild("Flag");
        local CharacterMotor = v5:FindFirstChild("CharacterMotor");

        if not (FlagHandle and (Flag and (CharacterMotor and CharacterMotor:IsA("Motor6D")))) then
            v5:Destroy();

            return v3;
        end;

        for _, descendant in v5:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = false;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.Massless = true;
            end;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p2);

        if PlayerFromCharacter then
            PlayerFromCharacter = PlayerFromCharacter:GetAttribute("U20WorldTournamentTeam");
        end;

        if PlayerFromCharacter then
            PlayerFromCharacter = WorldCupFlagEmote.FlagAppearances:FindFirstChild(PlayerFromCharacter);
        end;

        if PlayerFromCharacter and PlayerFromCharacter:IsA("SurfaceAppearance") then
            local v6 = Flag:FindFirstChildOfClass("SurfaceAppearance");

            if v6 then
                v6:Destroy();
            end;

            local v7 = PlayerFromCharacter:Clone();
            v7.Name = "TeamAppearance";
            v7.Parent = Flag;
        end;

        v5.Parent = p2;
        CharacterMotor.Part0 = v4;
        CharacterMotor.Part1 = FlagHandle;
        v3:Add(v5);
        local v8 = WorldCupFlagEmote.VFXPart:Clone();
        v8.Name = "WorldCupFlagVFX";
        v8.Anchored = false;
        v8.CanCollide = false;
        v8.CanQuery = false;
        v8.CanTouch = false;
        v8.Massless = true;
        v8.CFrame = HumanoidRootPart.CFrame;
        v8.Parent = p2;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = HumanoidRootPart;
        WeldConstraint.Part1 = v8;
        WeldConstraint.Parent = v8;
        VfxManager.Enable(v8, true);
        v3:Add(v8);

        return v3;
    end
});