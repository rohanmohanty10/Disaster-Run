  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local CollectionService = game:GetService("CollectionService");
game:GetService("PathfindingService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("ContentProvider");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.Tweens);
require(ReplicatedStorage.Shared.VfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local _ = workspace.CurrentCamera;
local u2 = Knit.CreateController({
    Name = script.Name,
    CosmeticModules = {}
});

function u2.getModule(p3: table, p4: string) -- Line: 30
    return p3.CosmeticModules[p4] or nil;
end;

function u2.cleanCosmetic(p5: table, p6: userdata, p7: any) -- Line: 39
    -- upvalues: CollectionService (copy)
    for _, descendant in p6:GetDescendants() do
        if CollectionService:HasTag(descendant, (`Cosmetic{p7}`)) then
            descendant:Destroy();
        end;
    end;
end;

function u2.setupCosmetic(p8: table, p9: userdata, p10: string, p11: number) -- Line: 51
    -- upvalues: Players (copy), LocalPlayer (copy), u2 (copy)
    p8:cleanCosmetic(p9, p11);

    if not p10 then
        return;
    end;

    if p8.HideOthersCosmetics then
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p9);

        if PlayerFromCharacter and PlayerFromCharacter ~= LocalPlayer then
            return;
        end;
    end;

    local Module = u2:getModule(p10);

    if not Module then
        return;
    end;

    Module.SetupCosmetic(p9, p11);
end;

function u2.KnitStart(u12) -- Line: 68
    -- upvalues: Knit (copy), LocalPlayer (copy), Players (copy), CollectionService (copy)
    u12.CosmeticsService = Knit.GetService("CosmeticsService");
    u12.CosmeticsService.UpdateCosmetic:Connect(function(p13, p14, p15) -- Line: 71
        -- upvalues: u12 (copy), LocalPlayer (ref)
        if u12.HideOthersCosmetics and p13 ~= LocalPlayer then
            return;
        end;

        u12:setupCosmetic(p13.Character, p14, p15);
    end);
    Players.PlayerAdded:Connect(function(u16) -- Line: 76
        -- upvalues: u12 (copy), LocalPlayer (ref)
        u16.CharacterAdded:Connect(function(p17) -- Line: 77
            -- upvalues: u12 (ref), u16 (copy), LocalPlayer (ref)
            if u12.HideOthersCosmetics and u16 ~= LocalPlayer then
                return;
            end;

            for i = 1, 2 do
                u12:setupCosmetic(u16.Character, u16:GetAttribute((`EquippedCosmetic{i}`)), (tostring(i)));
                local _ = i;
            end;
        end);
    end);

    for _, v in Players:GetPlayers() do
        if v.Character then
            local v18 = v;

            for i = 1, 2 do
                u12:setupCosmetic(v18.Character, v18:GetAttribute((`EquippedCosmetic{i}`)), (tostring(i)));
                local _ = i;
            end;
        end;
    end;

    local function watchTag(p19) -- Line: 95
        -- upvalues: CollectionService (ref), u12 (copy), Players (ref), LocalPlayer (ref)
        CollectionService:GetInstanceAddedSignal(p19):Connect(function(p20) -- Line: 96
            -- upvalues: u12 (ref), Players (ref), LocalPlayer (ref)
            if not u12.HideOthersCosmetics then
                return;
            end;

            local v21 = p20:FindFirstAncestorOfClass("Model");

            if v21 then
                v21 = Players:GetPlayerFromCharacter(v21);
            end;

            if v21 and v21 ~= LocalPlayer then
                p20:Destroy();
            end;
        end);
    end;

    CollectionService:GetInstanceAddedSignal("Cosmetic1"):Connect(function(p22) -- Line: 96
        -- upvalues: u12 (copy), Players (ref), LocalPlayer (ref)
        if not u12.HideOthersCosmetics then
            return;
        end;

        local v23 = p22:FindFirstAncestorOfClass("Model");

        if v23 then
            v23 = Players:GetPlayerFromCharacter(v23);
        end;

        if v23 and v23 ~= LocalPlayer then
            p22:Destroy();
        end;
    end);
    CollectionService:GetInstanceAddedSignal("Cosmetic2"):Connect(function(p24) -- Line: 96
        -- upvalues: u12 (copy), Players (ref), LocalPlayer (ref)
        if not u12.HideOthersCosmetics then
            return;
        end;

        local v25 = p24:FindFirstAncestorOfClass("Model");

        if v25 then
            v25 = Players:GetPlayerFromCharacter(v25);
        end;

        if v25 and v25 ~= LocalPlayer then
            p24:Destroy();
        end;
    end);
end;

function u2.KnitInit(u26) -- Line: 109
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
    for _, child in script:GetChildren() do
        if child:IsA("ModuleScript") then
            u26.CosmeticModules[child.Name] = require(child);
        end;
    end;

    u26.BaseTrove = Trove.new();
    u26.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p27) -- Line: 117
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
        u1 = p27;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u26.BaseTrove:Connect(game.Players.PlayerRemoving, function(p28) -- Line: 123
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), Humanoid (ref), u26 (copy)
        if p28 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u26.BaseTrove:Destroy();
        end;
    end);
end;

function u2.SetHideOthersCosmetics(p29, p30) -- Line: 134
    -- upvalues: Players (copy), LocalPlayer (copy)
    p29.HideOthersCosmetics = p30 and true or false;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer and v.Character then
            local v31 = v;

            for i = 1, 2 do
                local v32;

                if p29.HideOthersCosmetics then
                    p29:cleanCosmetic(v31.Character, (tostring(i)));
                    v32 = i;
                else
                    p29:setupCosmetic(v31.Character, v31:GetAttribute((`EquippedCosmetic{i}`)), (tostring(i)));
                    v32 = i;
                end;
            end;
        end;
    end;
end;

return u2;