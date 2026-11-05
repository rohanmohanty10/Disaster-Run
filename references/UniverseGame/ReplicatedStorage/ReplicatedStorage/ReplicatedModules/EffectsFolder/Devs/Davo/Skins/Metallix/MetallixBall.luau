  

 

game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local Union = script.Union;
local u1 = 0;

return function(p2) -- Line: 15
    -- upvalues: Trove (copy), Union (copy), ParticleHandler (copy), u1 (ref), TweenService (copy)
    local Character = p2.Character;
    local Hook = p2.Hook;
    local v3;

    if Character then
        v3 = Character:FindFirstChild("Torso");
    else
        v3 = Character;
    end;

    if not (v3 and Character:GetAttribute(Hook)) then
        return;
    end;

    local u4 = Trove.new();
    u4:AttachToInstance(Character);
    local Folder = Instance.new("Folder");
    Folder.Name = "SpineContainer";
    Folder.Parent = workspace.Effects;
    local v5 = Instance.fromExisting(Union);
    v5.Color = p2.Color or (Character:GetAttribute("CosmeticsOn") and v5.Color or v3.Color);
    v5.Transparency = 1;
    v5.Parent = Folder;
    ParticleHandler.Unusualify(Folder, {
        IncludeParts = true,
        Character = Character
    });
    local u6 = {};

    for i = 0, 7 do
        local v7 = i > 0 and (i / 35 or 0) or 0;
        local v8 = Instance.fromExisting(v5);
        v8.Transparency = 0;
        v8.Anchored = false;
        v8.Parent = Folder;
        v8.CFrame = v3.CFrame;
        local Weld = Instance.new("Weld");
        Weld.Parent = v8;
        Weld.Part0 = v8;
        Weld.Part1 = v3;
        Weld.C1 = CFrame.Angles(math.rad(u1), 0, 3.141592653589793);
        TweenService:Create(Weld, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, v7), {
            C0 = CFrame.new(0, 1.69, 0)
        }):Play();
        u1 = u1 + 45;
        local v9 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, v7);
        table.insert(u6, TweenService:Create(Weld, v9, {
            C0 = CFrame.identity
        }));
    end;

    v5:Destroy();
    u4:Add(function() -- Line: 60
        -- upvalues: Character (copy), Folder (copy), u6 (copy)
        if Character then
            for i, v in u6 do
                v:Play();
                v.Completed:Once(function() -- Line: 68
                    -- upvalues: i (copy), u6 (ref), Folder (ref), v (copy)
                    if i == #u6 then
                        Folder:Destroy();

                        return;
                    end;

                    if not (v and (v.Instance and v.Instance.Parent)) then
                        return;
                    end;

                    v.Instance.Parent.Transparency = 1;
                end);
            end;

            return;
        end;

        Folder:Destroy();
    end);
    u4:Connect(Character:GetAttributeChangedSignal(Hook), function() -- Line: 79
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;