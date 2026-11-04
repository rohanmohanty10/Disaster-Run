  

local game_ReplicatedStorage = game.ReplicatedStorage;
game:GetService("RunService");
require(game_ReplicatedStorage.Shared.VfxManager);
require(game_ReplicatedStorage.Shared.Essentials);
local LocalPlayer = game.Players.LocalPlayer;

local function makePlayerModel(u1: userdata) -- Line: 8
    -- upvalues: LocalPlayer (copy)
    local success, result = pcall(function() -- Line: 9
        -- upvalues: LocalPlayer (ref), u1 (copy)
        local AppliedDescription = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()).Humanoid:GetAppliedDescription();
        AppliedDescription.Shirt = 123131529989502;
        AppliedDescription.Pants = 76318455215217;
        local Parent = u1.Parent;
        local v2 = u1:Clone();
        u1:Destroy();
        v2.Parent = Parent;

        for _, child in v2:GetChildren() do
            if child:IsA("Accessory") then
                child:Destroy();
            end;
        end;

        v2.Humanoid:ApplyDescription(AppliedDescription);
    end);

    if not success then
        warn(result);
    end;
end;

local function motor6dTransfer(p3: userdata, p4: userdata) -- Line: 35
    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("Motor") and p4:FindFirstChild(descendant.Name) then
            if descendant.Part0 then
                descendant.Part1 = p4[descendant.Name];
            else
                descendant.Part0 = p4[descendant.Name];
            end;
        end;
    end;
end;

return {
    Emote = "Cortis Go",

    CosmeticSpawn = function(p5) -- Line: 49, Name: CosmeticSpawn
    end,

    EmoteSpawn = function(p6) -- Line: 65, Name: EmoteSpawn
        -- upvalues: LocalPlayer (copy), game_ReplicatedStorage (copy)
        local Emote = workspace.Mythics.Emote;
        local success, result = pcall(function() -- Line: 9
            -- upvalues: LocalPlayer (ref), Emote (copy)
            local AppliedDescription = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()).Humanoid:GetAppliedDescription();
            AppliedDescription.Shirt = 123131529989502;
            AppliedDescription.Pants = 76318455215217;
            local Parent = Emote.Parent;
            local v7 = Emote:Clone();
            Emote:Destroy();
            v7.Parent = Parent;

            for _, child in v7:GetChildren() do
                if child:IsA("Accessory") then
                    child:Destroy();
                end;
            end;

            v7.Humanoid:ApplyDescription(AppliedDescription);
        end);

        if not success then
            warn(result);
        end;

        local Emote2 = workspace.Mythics.Emote;
        local Sound = Instance.new("Sound");
        Sound.SoundId = "rbxassetid://88655232862426";
        Sound.Looped = true;
        Sound.Parent = Emote2.HumanoidRootPart;
        Sound:Play();
        local v8 = Emote2.Humanoid:LoadAnimation(game_ReplicatedStorage.Assets.Emotes["Cortis Go"]);
        v8.Priority = Enum.AnimationPriority.Action;
        v8.Looped = true;
        v8:Play();

        for _, child in ipairs(game_ReplicatedStorage.Assets.Vfx.CortisGo:GetChildren()) do
            if child:IsA("Folder") then
                local v9 = Emote2:FindFirstChild(child.Name);

                if v9 and v9:IsA("BasePart") then
                    for _, child2 in ipairs(child:GetChildren()) do
                        local v10 = child2:Clone();

                        if v10:IsA("BasePart") then
                            v10.Parent = Emote2;
                            v10:PivotTo(v9.CFrame);
                            local WeldConstraint = Instance.new("WeldConstraint");
                            WeldConstraint.Part0 = v9;
                            WeldConstraint.Part1 = v10;
                            WeldConstraint.Parent = v10;
                        else
                            v10.Parent = v9;
                        end;
                    end;
                end;
            end;
        end;
    end
};